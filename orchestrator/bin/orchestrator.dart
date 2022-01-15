import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

RegExp unityRegex =
    RegExp(r'^[+-]?([0-9/]+\.?[0-9]*|\.[0-9]+)\s([.àâa-zA-Z]*)');
RegExp quantityRegex = RegExp(r'[0-9]{1,10}\s[a-zA-Z]*');

List<String> unityWhiteList = [
  "g",
  "kg",
  "ml",
  "dl",
  "l",
  "c.à.s",
  "cas",
  "c.a.s",
  "cuillère",
  "cuillere",
  "morceaux",
  "verre",
  "tasse",
  "sachet",
  "pincée",
  "morceaux",
  "sachet",
  "cac",
  "c.a.c",
  "c.à.c"
];

Future<http.StreamedResponse> fetchSomething(String stringUrl) {
  var url = Uri.parse(stringUrl);
  http.Request request = http.Request("get", url);
  request.headers.clear();
  request.headers.addAll({"content-type": "application/json; charset=utf-8"});
  return request.send();
}

class Ingredient {
  String unity = "";
  String quantity = "";
  String name = "";
  dynamic price;
  String descriptionIngredient = "";
  Ingredient._(
      this.unity, this.quantity, this.descriptionIngredient, this.name);

  static Ingredient getIngredient(String ingredientDesciption) {
    var unityMatches = unityRegex.allMatches(ingredientDesciption);

    String unityString =
        unityMatches.isNotEmpty && unityMatches.first.groupCount == 2
            ? unityMatches.first.group(2) ?? ""
            : "";

    String quantityString =
        unityMatches.isNotEmpty && unityMatches.first.groupCount > 1
            ? unityMatches.first.group(1) ?? ""
            : "";

    if (!(unityWhiteList.contains(unityString))) {
      unityString = "";
    }
    String nameString;
    if (!(unityString == "")) {
      var tabIngredientName = ingredientDesciption.split(unityString);
      nameString = tabIngredientName[1];
    } else {
      nameString = ingredientDesciption;
    }

    return Ingredient._(
        unityString, quantityString, ingredientDesciption, nameString);
  }

  Map<String, dynamic> getJsonIngredient() {
    return {"unity": unity, "quantity": quantity, "name": name, "price": price};
  }
}

Future<dynamic> fetchIngredientPricing(Ingredient ingredient) async {
  http.StreamedResponse price = await fetchSomething(
      "http://localhost:8889/price/" + Uri.encodeComponent(ingredient.name));

  var respPrice = await price.stream.bytesToString();
  dynamic decodedPrice = json.decode(respPrice);

  ingredient.price = decodedPrice;
  return ingredient.getJsonIngredient();
}

Future<dynamic> fetchRecipeIngredients(dynamic recipe) async {
  List<Ingredient> ingredients = [];
  for (String ingredientDescription in recipe["ingredients"]) {
    Ingredient ingredient = Ingredient.getIngredient(ingredientDescription);
    ingredients.add(ingredient);
  }

  List<Future<dynamic>> futuresPrices = [];

  for (var ingredient in ingredients) {
    futuresPrices.add(fetchIngredientPricing(ingredient));
  }

  var res = await Future.wait(futuresPrices);
  recipe["ingredients"] = res;
  return recipe;
}

double getIngredientPrice(String priceDescription) {
  String stringPrice = priceDescription.split("€")[0].replaceAll(',', '.');
  double price = double.parse(stringPrice);
  return price;
}

dynamic computeRecipePrice(dynamic recipe) {
  double price = 0;
  for (var ingredient in recipe["ingredients"]) {
    double ingredientPrice =
        getIngredientPrice(ingredient["price"]["product"]["price"]);
    price = price + ingredientPrice;
  }
  recipe["recipePrice"] = price;
  return recipe;
}

List<dynamic> computeRecipesPrice(List<dynamic> recipes) {
  int index = 0;
  for (dynamic recipe in recipes) {
    dynamic recipePriced = computeRecipePrice(recipe);
    recipes[index] = recipePriced;
    index = index + 1;
  }
  return recipes;
}

List<dynamic> filterRecipes(int budget, List<dynamic> recipes) {
  List<dynamic> filteredRecipes = [];
  for (dynamic recipe in recipes) {
    if (recipe["recipePrice"] <= budget) {
      filteredRecipes.add(recipe);
    }
  }
  return filteredRecipes;
}

dynamic getRecipes(int budget) async {
  //get all recipes
  var recipes =
      await fetchSomething("http://localhost:8888/recipes?numberMax=1");
  var respRecipes = await recipes.stream.bytesToString();
  var decodedRecipes = json.decode(respRecipes);

  List<Future<dynamic>> recipeTasks = [];

  for (var recipe in decodedRecipes["recipes"]) {
    recipeTasks.add(fetchRecipeIngredients(recipe));
  }

  List<dynamic> results = await Future.wait(recipeTasks);

  // compute price
  List<dynamic> pricedRecipes = computeRecipesPrice(results);

  List<dynamic> filteredRecipes = filterRecipes(budget, pricedRecipes);

  return (pricedRecipes);
}

void main(List<String> arguments) async {
  int budget = 100;
  dynamic recipes = await getRecipes(budget);
  print(recipes);
}

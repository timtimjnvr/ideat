import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

RegExp unityRegex = RegExp(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)\s([.àâa-zA-Z]*)');
RegExp quantityRegex = RegExp(r'[0-9]{1,10}\s[a-zA-Z]*');

class Ingredient {
  String unity = "";
  String quantity = "";
  String name = "";
  Ingredient._(this.unity, this.quantity, this.name);

  static Ingredient getIngredient(String ingredientDesciption) {
    print(ingredientDesciption);
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
    print("unity:" + unityString);
    print("quantity: " + quantityString);
    print("name: " + nameString);
    print("");

    return Ingredient._(unityString, quantityString, nameString);
  }
}

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
  "morceaux"
];

Future<http.StreamedResponse> fetchRecipes(String numberMax) {
  var url = Uri.parse("http://localhost:8888/recipes?numberMax=" + numberMax);
  http.Request request = new http.Request("get", url);
  request.headers.clear();
  request.headers.addAll({"content-type": "application/json; charset=utf-8"});
  return request.send();
}

Future<http.StreamedResponse> fetchIngredientPrice(String ingredientName) {
  var url = Uri.parse("http://localhost:8889/price/" + ingredientName);
  http.Request request = new http.Request("get", url);
  request.headers.clear();
  request.headers.addAll({"content-type": "application/json; charset=utf-8"});
  return request.send();
}

void main(List<String> arguments) async {
  var recipes = await fetchRecipes("10");
  var respRecipes = await recipes.stream.bytesToString();
  var decodedRecipes = json.decode(respRecipes);
  for (var recipe in decodedRecipes["recipes"]) {
    List<Ingredient> ingredients = [];
    for (String ingredientDescription in recipe["ingredients"]) {
      Ingredient ingredient = Ingredient.getIngredient(ingredientDescription);
      ingredients.add(ingredient);
    }
    for (Ingredient ingredient in ingredients) {
      var price = await fetchIngredientPrice(ingredient.name);
      var respPrice = await price.stream.bytesToString();
      var decodedPrice = json.decode(respPrice);
      print(decodedPrice);
    }
  }
}

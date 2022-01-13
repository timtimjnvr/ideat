import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

RegExp unityRegex = RegExp(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)\s([.àâa-zA-Z]*)');
RegExp quantityRegex = RegExp(r'[0-9]{1,10}\s[a-zA-Z]*');

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

void main(List<String> arguments) async {
  var recipes =
      await fetchSomething("http://localhost:8888/recipes?numberMax=10");
  var respRecipes = await recipes.stream.bytesToString();
  var decodedRecipes = json.decode(respRecipes);
  for (var recipe in decodedRecipes["recipes"]) {
    List<Ingredient> ingredients = [];
    for (String ingredientDescription in recipe["ingredients"]) {
      Ingredient ingredient = Ingredient.getIngredient(ingredientDescription);
      ingredients.add(ingredient);
    }
    ingredients.map((ingredient) =>
        fetchSomething("http://localhost:8889/price/" + ingredient.name));

    List<Future<http.StreamedResponse>> futuresPrices = [];

    for (var ingredient in ingredients) {
      futuresPrices.add(
          fetchSomething("http://localhost:8889/price/" + ingredient.name));
    }

    var res = await Future.wait(futuresPrices);

    for (var price in res) {
      var respPrice = await price.stream.bytesToString();
      var decodedPrice = json.decode(respPrice);
      print(decodedPrice);
    }
    break;
  }
}

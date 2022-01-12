import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

RegExp unityRegex = RegExp(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)\s([a-zA-Z]*)\s');
RegExp quantityRegex = RegExp(r'[0-9]{1,10}\s[a-zA-Z]*\s');

class Ingredient {
  String unity = "";
  String quantity = "";
  String name = "";
  Ingredient._(this.unity, this.quantity, this.name);

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
    print("unity:" + unityString);
    print("quantity: " + quantityString);
    print("");

    return Ingredient._("test", "test", "test");
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
  "pincée"
];

Future<http.StreamedResponse> fetchRecipes(String numberMax) {
  var url = Uri.parse("http://localhost:8888/recipes?numberMax=" + numberMax);
  http.Request request = new http.Request("get", url);
  request.headers.clear();
  request.headers.addAll({"content-type": "application/json; charset=utf-8"});
  return request.send();
}

void main(List<String> arguments) async {
  var recipes = await fetchRecipes("10");
  final respStr = await recipes.stream.bytesToString();
  final decoded = json.decode(respStr);
  for (var recipe in decoded["recipes"]) {
    for (String ingredientDescription in recipe["ingredients"]) {
      Ingredient ingredient = Ingredient.getIngredient(ingredientDescription);
    }
  }
}

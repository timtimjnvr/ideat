import 'dart:convert';
import 'fetcher.dart';
import 'package:http/http.dart' as http;

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

class Ingredient {
  String descriptionIngredient = "";
  String unity = "";
  String quantity = "";
  String querryParameter = "";
  dynamic product;

  Ingredient._(this.descriptionIngredient, this.unity, this.quantity,
      this.querryParameter);

  Map<String, dynamic> getJsonIngredient() {
    return {
      "descriptionIngredient": descriptionIngredient,
      "unity": unity,
      "quantity": quantity,
      "product": product
    };
  }

  static Ingredient getIngredient(String ingredientDescription) {
    var unityMatches = unityRegex.allMatches(ingredientDescription);

    String unity = unityMatches.isNotEmpty && unityMatches.first.groupCount == 2
        ? unityMatches.first.group(2) ?? ""
        : "";

    String quantity =
        unityMatches.isNotEmpty && unityMatches.first.groupCount > 1
            ? unityMatches.first.group(1) ?? ""
            : "";

    if (!(unityWhiteList.contains(unity))) {
      unity = "";
    }

    String querryParameter;
    if (!(unity == "")) {
      var tabIngredientName = ingredientDescription.split(unity);
      querryParameter = tabIngredientName[1];
    } else {
      querryParameter = ingredientDescription;
    }

    return Ingredient._(
        unity, quantity, ingredientDescription, querryParameter);
  }

  Future<dynamic> fetchIngredientPricing(Ingredient ingredient) async {
    var product = await getSomething("http://localhost:8889/price/" +
        Uri.encodeComponent(ingredient.querryParameter));

    try {
      ingredient.product = product["product"];
    } catch (e) {
      print("no product found");
    }

    return ingredient.getJsonIngredient();
  }
}

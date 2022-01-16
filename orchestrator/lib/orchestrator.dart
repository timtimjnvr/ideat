import 'dart:developer';
import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'ingredient.dart';
import 'fetcher.dart';

Future<dynamic> getRecipesWithIngredientsPrices(dynamic recipe) async {
  List<Ingredient> ingredients = [];

  for (String ingredientDescription in recipe["ingredients"]) {
    Ingredient ingredient = Ingredient.getIngredient(ingredientDescription);
    ingredients.add(ingredient);
  }

  List<Future<dynamic>> futuresPrices = [];

  for (var ingredient in ingredients) {
    futuresPrices.add(ingredient.fetchIngredientPricing(ingredient));
  }

  var ingredientWithPrice = await Future.wait(futuresPrices);
  recipe["ingredients"] = ingredientWithPrice;
  return recipe;
}

dynamic getRecipeWithPrice(dynamic recipe) {
  double getPrice(dynamic ingredient) {
    double price = 0;
    try {
      price = double.parse(
          ingredient["product"]["productPrice"].replaceAll(',', '.'));
    } catch (e) {
      print(e);
    }
    return (price);
  }

  Iterable<dynamic> ingredients = recipe["ingredients"];

  double price = 0;
  for (dynamic ingredient in ingredients) {
    price = price + getPrice(ingredient);
  }

  recipe["recipePrice"] = price;
  return recipe;
}

List<dynamic> getRecipesWithPrice(List<dynamic> recipes) {
  List<dynamic> recipesWithprice = [];
  for (dynamic recipe in recipes) {
    dynamic recipeWithprice = getRecipeWithPrice(recipe);
    recipesWithprice.add(recipeWithprice);
  }
  return recipesWithprice;
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

Future<List<dynamic>> getRecipes(String url) async {
  dynamic json = await getSomething(url);

  List<Future<dynamic>> recipesPriceTasks = [];

  for (var recipe in json["recipes"]) {
    recipesPriceTasks.add(getRecipesWithIngredientsPrices(recipe));
  }

  List<dynamic> recipesWithIngredientPrices =
      await Future.wait(recipesPriceTasks);

  List<dynamic> pricesWithRecipes =
      getRecipesWithPrice(recipesWithIngredientPrices);

  return pricesWithRecipes;
}

dynamic searchRecipes(Map<String, String> params, int budget) async {
  String url = "http://localhost:8888/recipes?";

  params.forEach((key, value) {
    url += key + "=" + value + "&";
  });

  List<dynamic> recipes = await getRecipes(url);

  List<dynamic> filteredRecipes = filterRecipes(budget, recipes);

  return (filteredRecipes);
}

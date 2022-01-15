import 'dart:developer';
import 'dart:convert';
import 'dart:async';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'ingredient.dart';
import 'fetcher.dart';

Future<dynamic> getIngredientsInformations(dynamic recipe) async {
  List<Ingredient> ingredients = [];

  for (String ingredientDescription in recipe["ingredients"]) {
    Ingredient ingredient = Ingredient.getIngredient(ingredientDescription);
    ingredients.add(ingredient);
  }

  List<Future<dynamic>> futuresPrices = [];

  for (var ingredient in ingredients) {
    futuresPrices.add(ingredient.fetchIngredientPricing(ingredient));
  }

  var res = await Future.wait(futuresPrices);
  recipe["ingredients"] = res;
  return recipe;
}

dynamic computeRecipePrice(dynamic recipe) {
  double price = 0;

  double getPrice(dynamic ingredient) {
    print(ingredient);
    double price = 0;
    try {
      price = double.parse(
          ingredient["product"]["productPrice"].replaceAll(',', '.'));
    } catch (e) {
      print(e);
    }
    return (price);
  }

  for (var ingredient in recipe["ingredients"]) {
    price = price + getPrice(ingredient);
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

Future<List<dynamic>> getRecipes() async {
  var recipes = await getSomething("http://localhost:8888/recipes?numberMax=1");

  List<Future<dynamic>> recipeTasks = [];

  for (var recipe in recipes["recipes"]) {
    recipeTasks.add(getIngredientsInformations(recipe));
  }

  List<dynamic> results = await Future.wait(recipeTasks);

  List<dynamic> pricedRecipes = computeRecipesPrice(results);

  return pricedRecipes;
}

dynamic getRecipes(int budget) async {
  List<dynamic> recipes = await getRecipes();

  List<dynamic> filteredRecipes = filterRecipes(budget, recipes);

  return (filteredRecipes);
}

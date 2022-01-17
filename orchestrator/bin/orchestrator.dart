import 'package:orchestrator/fetcher.dart';
import 'package:orchestrator/ingredient.dart';
import 'package:orchestrator/orchestrator.dart';

void main(List<String> arguments) async {
  int budget = 100;
  Map<String, String> params = {
    "name": "",
    "cookingTime": "129",
    "recipeDiffuculty": "EASY",
    "numberMax": "1",
    "recipeType": "platprincipal"
  };

  dynamic recipes = await searchRecipes(params, budget);

  print(recipes);
}

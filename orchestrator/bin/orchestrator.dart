import 'package:orchestrator/fetcher.dart';
import 'package:orchestrator/ingredient.dart';
import 'package:orchestrator/orchestrator.dart';

void main(List<String> arguments) async {
  int budget = 100;
  dynamic recipes = await getRecipes(budget);
  print(recipes);
}

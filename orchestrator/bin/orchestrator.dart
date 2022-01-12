import 'package:orchestrator/orchestrator.dart' as orchestrator;
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  var recipes = await orchestrator.fetchRecipes();
  print(recipes);
}

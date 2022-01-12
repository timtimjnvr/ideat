import 'package:orchestrator/orchestrator.dart' as orchestrator;
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  var recipes = await orchestrator.fetchRecipes();
  final respStr = await recipes.stream.bytesToString();
  print(respStr);
}

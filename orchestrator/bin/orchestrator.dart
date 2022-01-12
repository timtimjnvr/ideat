import 'package:orchestrator/orchestrator.dart' as orchestrator;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(List<String> arguments) async {
  var recipes = await orchestrator.fetchRecipes();
  final respStr = await recipes.stream.bytesToString();
  final decoded = json.decode(respStr);
  print(decoded["recipes"]);
}

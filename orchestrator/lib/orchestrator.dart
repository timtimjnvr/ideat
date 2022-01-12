import 'package:http/http.dart' as http;

Future<http.Response> fetchRecipes() {
  return http.get(Uri.parse('http://localhost:8888/recipes'));
}

import 'package:http/http.dart' as http;

class RecipesGetter {
  final client = http.Client;
  final numberMax;

  RecipesGetter(this.numberMax);

  Future<http.StreamedResponse> fetchRecipes(String numberMax) {
    var url = Uri.parse("http://localhost:8888/recipes?numberMax=" + numberMax);
    http.Request request = new http.Request("get", url);
    request.headers.clear();
    request.headers.addAll({"content-type": "application/json; charset=utf-8"});
    return request.send();
  }
}

class RecipesComputer {
  List<Map<String, String?>> recipesList;
  int budget;

  RecipesComputer(this.recipesList, this.budget);

  void getPrices() {}

  void recipesMatching(int budget) {}
}

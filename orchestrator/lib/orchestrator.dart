import 'package:http/http.dart' as http;

var client = http.Client();

Future<http.StreamedResponse> fetchRecipes() {
  var url = Uri.parse("http://localhost:8888/recipes?numberMax=10");
  http.Request request = new http.Request("get", url);
  request.headers.clear();
  request.headers.addAll({"content-type": "application/json; charset=utf-8"});
  return request.send();
}

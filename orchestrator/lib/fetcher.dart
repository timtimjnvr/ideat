import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.StreamedResponse> fetchSomething(String stringUrl) {
  var url = Uri.parse(stringUrl);
  http.Request request = http.Request("get", url);
  request.headers.clear();
  request.headers.addAll({"content-type": "application/json; charset=utf-8"});
  return request.send();
}

dynamic decodeSomething(http.StreamedResponse response) async {
  return json.decode(await response.stream.bytesToString());
}

dynamic getSomething(String stringUrl) async {
  Future<http.StreamedResponse> response = fetchSomething(stringUrl);
  return decodeSomething(await response);
}

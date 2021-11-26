import 'package:http/http.dart' as http;

void fetch(){
  http.get(Uri.parse('https://www.e.leclerc'))
  .then((response){
    if (response.statusCode == 200) {
      print(response.body);
    }
  });
}

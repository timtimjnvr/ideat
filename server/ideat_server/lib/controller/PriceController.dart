import 'dart:convert';
import 'package:ideat_server/ideat_server.dart';
import 'package:ideat_server/webscraper/webscraper.dart' as webscraper;
import 'package:ideat_server/webscraper/product.dart';

Future<List<Product>> getPrices(String name) {
  return webscraper.fetchAmazonProducts(name, "monoprix");
}

class PriceController extends ResourceController {
  @Operation.get('ingredientName')
  Future<Response> getRestMethod() async {
    final String? ingredientName =
        request != null ? request!.path.variables['ingredientName'] : "";

    final List<Product> products = await getPrices(ingredientName!);

    final List<Map<String, String?>> productJson = [];

    for (var element in products) {
      print(element.getProduct());
      productJson.add(element.getProduct());
    }
    if (productJson.length != 0) {
      //we suppose that first product from list best suites request
      print(productJson.first);
      return Response.ok({"product": productJson.first});
    } else {
      return Response.ok({"product": "no price found"});
    }
  }
}

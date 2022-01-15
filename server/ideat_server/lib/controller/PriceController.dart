import 'dart:convert';
import 'dart:ffi';
import 'package:ideat_server/ideat_server.dart';
import 'package:ideat_server/webscraper/webscraper.dart' as webscraper;
import 'package:ideat_server/webscraper/product.dart';

Future<List<Product>> getAmazonPrices(String name) {
  return webscraper.fetchProducts(name, "monoprix");
}

Future<List<Product>> getCasinoPrices(String name) {
  return webscraper.fetchProducts(name, "casino");
}

class PriceController extends ResourceController {
  @Operation.get('ingredientName')
  Future<Response> getRestMethod() async {
    final String? ingredientName =
        request != null ? request!.path.variables['ingredientName'] : "";

    var products = await getAmazonPrices(ingredientName!);

    final List<Map<String, String?>> productJson = [];

    for (var element in products) {
      productJson.add(element.getProduct());
    }

    if (productJson.length != 0) {
      //we assume that first product from list best suites request
      return Response.ok({"product": productJson.first});
    } else {
      return Response.ok({
        "product": {"title": ingredientName, "price": "0 €"}
      });
    }
  }
}

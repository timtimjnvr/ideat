import 'dart:convert';
import 'package:ideat_server/ideat_server.dart';
import 'package:ideat_server/webscraper.dart' as webscraper;
import 'package:ideat_server/product.dart';

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
      productJson.add(element.getProduct());
    }

    return Response.ok({"products": productJson})
      ..contentType = ContentType.json;
  }
}

import 'package:webscraper/webscraper.dart' as webscraper;
import 'package:webscraper/product.dart';

Future<List<Product>> main(List<String> arguments) {
  return webscraper.fetchAmazonProducts("steak", "monoprix");
}

import 'package:webscraper/webscraper.dart' as webscraper;

Future<List<webscraper.Product>> main(List<String> arguments) {
  return webscraper.fetchAmazonProducts("oeuf", "monoprix");
}

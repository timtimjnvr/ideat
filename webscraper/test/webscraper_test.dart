import 'package:webscraper/webscraper.dart' as webscraper;
import 'package:webscraper/product.dart';
import 'package:test/test.dart';

void main() {
  test('fetchAmazonProducts', () async {
    expect(
        (await webscraper.fetchAmazonProducts("steak", "monoprix")).length > 0,
        true);
  });
}

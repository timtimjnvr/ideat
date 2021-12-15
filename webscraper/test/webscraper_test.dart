import 'package:webscraper/webscraper.dart' as webscraper;
import 'package:webscraper/product.dart';
import 'package:test/test.dart';

void main() {
  // works in local
  /*test('fetchAmazonProducts', () async {
    expect(
        (await webscraper.fetchAmazonProducts("steak", "monoprix")).length > 0,
        true);
  });*/

  var realProductTitle =
      " Monoprix Steaks hachés pur boeuf 15% mg, surgelés - La barquette de 10, 1kg  4,4 sur 5 étoiles 77  7,49 €7,49€ (7,49 €/kg)   Livraison GRATUITE le jour même dès 60€ d'achats avec Amazon Prime";
  test("try to get product from an advertisement", () {
    var product = webscraper.getProduct(realProductTitle);
    expect(
        product.title, " Monoprix Steaks hachés pur boeuf 15% mg, surgelés ");
    expect(product.price, "7,49 €");
    expect(product.unity, "kg");
  });
}

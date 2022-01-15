import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';
import 'dart:convert';
import 'package:ideat_server/webscraper/product.dart';

RegExp pricesRegex = RegExp(r'[0-9]{1,10},[0-9]{1,2}.€\/[^\s,)]{1,10}');
RegExp newRegex = RegExp(
    r'.([0-9]{1,10},[0-9]{1,2}).\s\(([0-9]{1,10},[0-9]{1,2}).(.)\/([^\s,)]{1,10})');

Product getProduct(String productDescription) {
  var tab = productDescription.split("-");
  var title = tab[0];
  var restOfProductDescription = tab[1];

  var productInfosMatches = newRegex.allMatches(restOfProductDescription);

  String getString(Iterable<RegExpMatch> matches, int index) {
    return matches.isNotEmpty && matches.first.groupCount >= index
        ? matches.first.group(index) ?? ""
        : "";
  }

  String productPrice = getString(productInfosMatches, 1);
  String unityPrice = getString(productInfosMatches, 2);
  String currency = getString(productInfosMatches, 3);
  String unity = getString(productInfosMatches, 4);

  Product product = Product(title, productPrice, currency, unityPrice, unity);
  return product;
}

Future<List<String>> fetchTitles(
    String url, String query, String selector) async {
  final List<String> titles = [];

  final WebScraper webScraper = WebScraper(url);
  bool loaded = false;

  List<Map<String, dynamic>>? domElements = null;

  /*int maxTries = 100;
  int currentAttempts = 0;

  while ((!loaded || domElements == null || domElements.length == 0) &&
      currentAttempts < maxTries) {*/
  loaded = await webScraper.loadWebPage(query);
  if (loaded) {
    domElements = webScraper.getElement(selector, ['']);
  }
  /*currentAttempts++;
    if (!loaded || domElements == null || domElements.length == 0)
      sleep(Duration(seconds: 2));
  }*/

  //print(webScraper.getPageContent());

  loaded = loaded && domElements != null && domElements.length != 0;

  if (loaded) {
    for (var domElement in domElements) {
      titles.add(domElement['title'] as String);
    }
  } else {
    print("page not loaded");
  }
  return titles;
}

Future<List<Product>> fetchProducts(String productName, String provider) async {
  List<Product> products = [];

  List<String> titles = await fetchTitles(
      'https://www.amazon.fr',
      '/s?k=' + productName + '&i=' + provider,
      'div[data-component-type="s-search-result"] > * > span > * > * > *');

  for (var title in titles) {
    try {
      products.add(getProduct(title));
    } catch (e) {}
  }
  return products;
}

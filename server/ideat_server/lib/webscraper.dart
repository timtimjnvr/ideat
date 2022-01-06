import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_scraper/web_scraper.dart';
import 'dart:convert';
import 'package:ideat_server/product.dart';

RegExp pricesRegex = RegExp(r'[0-9]{1,10},[0-9]{1,2}.€\/[^\s,)]{1,10}');

//analyse Product Description to build the product Object
Product getProduct(String productDescription) {
  var tab = productDescription.split("-");

  var title = tab[0];
  var restOfProductDescription = tab[1];

  //looking for this type of expr : "9,39€ (117,38 €/"
  //the first price is product price and the second unit price (kg/L or unity)
  var stringPriceMatches = pricesRegex.allMatches(restOfProductDescription);

  var priceString = stringPriceMatches.first.group(0);
  var tabPrices = priceString!.split("/");
  var price = tabPrices[0];
  var unity = tabPrices[1];

  return Product(title, price, unity);
}

Future<List<String>> fetchTitles(
    String url, String query, String selector) async {
  final List<String> titles = [];

  final WebScraper webScraper = WebScraper(url);
  bool loaded = false;
  print("test bool");

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

  print(webScraper.getPageContent());

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

Future<List<Product>> fetchAmazonProducts(
    String productName, String provider) async {
  List<Product> products = [];

  List<String> titles = await fetchTitles(
      'https://www.amazon.fr',
      '/s?k=' + productName,
      'div[data-component-type="s-search-result"] > * > span > * > * > *');

  for (var title in titles) {
    //get only provider's products
    if (title.toLowerCase().contains(provider)) {
      var productDescription = title;
      try {
        products.add(getProduct(productDescription));
      } catch (e) {}
    }
  }
  print(products);
  return products;
}

/*
DIV PRODUCT
<div data-asin="B07DJB1BW9" data-index="11" data-uuid="b9731ef2-a0d8-4c03-8805-8ca29da2e220" data-component-type="s-search-result" class="sg-col-4-of-12 s-result-item s-asin sg-col-4-of-16 sg-col s-widget-spacing-small sg-col-4-of-20" data-component-id="34" data-cel-widget="search_result_5"><div class="sg-col-inner">
    
<span cel_widget_id="MAIN-SEARCH_RESULTS-11" class="celwidget slot=MAIN template=SEARCH_RESULTS widgetId=search-results_5" data-csa-c-id="igl3sh-bqtwe6-tpnezk-eyb6tu" data-cel-widget="MAIN-SEARCH_RESULTS-11">
    <div class="s-expand-height s-include-content-margin s-latency-cf-section s-border-bottom s-border-top"><div class="a-section a-spacing-medium"><div class="a-section a-spacing-none s-grid-status-badge-container s-expand-height s-padding-micro"></div><span data-component-type="s-product-image" class="rush-component"><a class="a-link-normal s-no-outline" href="/LOeuf-nos-Villages-Oeufs-frais/dp/B07DJB1BW9/ref=sr_1_5?__mk_fr_FR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&amp;keywords=oeuf&amp;qid=1638958511&amp;sr=8-5"><div class="a-section aok-relative s-image-square-aspect"><img class="s-image" src="https://m.media-amazon.com/images/I/41t+0lXb-sL._AC_UL320_.jpg" srcset="https://m.media-amazon.com/images/I/41t+0lXb-sL._AC_UL320_.jpg 1x, https://m.media-amazon.com/images/I/41t+0lXb-sL._AC_UL480_QL65_.jpg 1.5x, https://m.media-amazon.com/images/I/41t+0lXb-sL._AC_UL640_QL65_.jpg 2x, https://m.media-amazon.com/images/I/41t+0lXb-sL._AC_UL800_QL65_.jpg 2.5x, https://m.media-amazon.com/images/I/41t+0lXb-sL._AC_UL960_QL65_.jpg 3x" alt="L'Oeuf de nos Villages Oeufs frais plein air - La boîte de 12" data-image-index="5" data-image-load="" data-image-latency="s-product-image" data-image-source-density="1"></div></a></span><div class="a-section a-spacing-none"><div class="a-section a-spacing-none a-spacing-top-small"><h2 class="a-size-mini a-spacing-none a-color-base s-line-clamp-4"><a class="a-link-normal a-text-normal" href="/LOeuf-nos-Villages-Oeufs-frais/dp/B07DJB1BW9/ref=sr_1_5?__mk_fr_FR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&amp;keywords=oeuf&amp;qid=1638958511&amp;sr=8-5"><span class="a-size-base-plus a-color-base a-text-normal">L'Oeuf de nos Villages Oeufs frais plein air - La boîte de 12</span> </a> </h2></div><div class="a-section a-spacing-none a-spacing-top-micro"><div class="a-row a-size-small"><span aria-label="4,6 sur 5&nbsp;étoiles"><span class="a-declarative" data-action="a-popover" data-csa-c-type="widget" data-csa-c-func-deps="aui-da-a-popover" data-a-popover="{&quot;closeButton&quot;:false,&quot;closeButtonLabel&quot;:&quot;&quot;,&quot;position&quot;:&quot;triggerBottom&quot;,&quot;popoverLabel&quot;:&quot;&quot;,&quot;url&quot;:&quot;/review/widgets/average-customer-review/popover/ref=acr_search__popover?ie=UTF8&amp;asin=B07DJB1BW9&amp;ref=acr_search__popover&amp;contextId=search&quot;}" data-csa-c-id="zd4rjp-w6rzly-ml1adf-gje1zd"><a href="javascript:void(0)" role="button" class="a-popover-trigger a-declarative"><i class="a-icon a-icon-star-small a-star-small-4-5 aok-align-bottom"><span class="a-icon-alt">4,6 sur 5&nbsp;étoiles</span></i><i class="a-icon a-icon-popover"></i></a></span> </span><span aria-label="110"><a class="a-link-normal" href="/LOeuf-nos-Villages-Oeufs-frais/dp/B07DJB1BW9/ref=sr_1_5?__mk_fr_FR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&amp;keywords=oeuf&amp;qid=1638958511&amp;sr=8-5#customerReviews"><span class="a-size-base">110</span> </a> </span></div></div><div class="a-section a-spacing-none a-spacing-top-micro"><div class="a-row a-size-base a-color-secondary"><span aria-label="Actuellement indisponible."><span class="a-size-small">Actuellement indisponible.</span></span></div></div></div></div></div>
</span>

</div></div>

DIV MONOPRIX 

<img alt="Monoprix" src="https://m.media-amazon.com/images/I/51od8ClHGjL.png" class="s-image" height="14px">
*/

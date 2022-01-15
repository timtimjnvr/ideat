import 'dart:convert';

class Product {
  String? title, productPrice, currency, unityPrice, unity;
  Product(this.title, this.productPrice, this.currency, this.unityPrice,
      this.unity);

  Map<String, String?> getProduct() {
    return {
      "title": title,
      "productPrice": productPrice,
      "currency": currency,
      "unityPrice": unityPrice,
      "unity": unity
    };
  }
}

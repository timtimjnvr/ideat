import 'dart:convert';

class Product {
  String? title, price, unity;
  Product(this.title, this.price, this.unity);

  Map<String, String?> getProduct() {
    return {"title": title, "price": price, "unity": unity};
  }
}

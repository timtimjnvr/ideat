class Product {
  String? title, price, unity;
  Product(this.title, this.price, this.unity);

  getProduct() {
    return {"title": title, "price": price, "unity": unity};
  }
}

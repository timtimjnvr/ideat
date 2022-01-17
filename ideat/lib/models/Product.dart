import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  final List<String> ingredients;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
    required this.ingredients,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Sauté de veau au chorizo",
      price: 39,
      size: 5,
      description: " steps",
      image: "assets/images/bag_1.png",
      color: Color(0xFFE6B398),
      ingredients: [
        '1 horizo 2,69 € ',
        '4 oignons 2,61 €'
            '1 bouquet basilic 2,99 €',
        '1 gousse ail 5,19 €',
        "2 c.à.s d'huile 13,50 €/100ml",
        '1 kg de sauté de veau 5,19€ ',
        '2 boîtes de pulpe de tomate 2,79€',
        '1 pot d\'olives vertes dénoyautées 1,89 €',
      ]),
  Product(
      id: 2,
      title: "Tarte pommes râpées citrons",
      price: 22,
      size: 5,
      description: dummyText,
      image: "assets/images/bag_2.jpeg",
      color: Color(0xFFD3A984),
      ingredients: [
        '1 pâte brisée 0,75€',
        '3 pommes pas trop acides 4,49€',
        '150 g de sucre en poudre 0,99€',
        '80 g de beurre fondu 1,79€',
        '2 citrons bien lavés',
        '2 oeufs 2,29 €',
      ]),
  Product(
      id: 3,
      title: "Pâte à crêpes (des plus raffinées)",
      price: 16,
      size: 5,
      description: dummyText,
      image: "assets/images/bag_3.png",
      color: Color(0xFF989493),
      ingredients: [
        '1 pâte brisée 0,75€',
        '3 pommes pas trop acides 4,49€',
        '150 g de sucre en poudre 0,99€',
        '80 g de beurre fondu 1,79€',
        '2 citrons bien lavés',
        '2 oeufs 2,29 €',
      ]),
  Product(
      id: 4,
      title: "Tarte au fromage blanc ",
      price: 24,
      size: 5,
      description: "bla bla bla",
      image: "assets/images/bag_4.jpeg",
      color: Color(0xFFE6B398),
      ingredients: [
        '1 pâte brisée 0,75€',
        '3 pommes pas trop acides 4,49€',
        '150 g de sucre en poudre 0,99€',
        '80 g de beurre fondu 1,79€',
        '2 citrons bien lavés',
        '2 oeufs 2,29 €',
      ]),
  Product(
      id: 5,
      title: "Hachis Parmentier",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/bag_5.png",
      color: Color(0xFFFB7883),
      ingredients: [
        '8 large eggs',
        '1 tsp. Dijon mustard',
        'Kosher salt and pepper',
        '1 tbsp. olive oil or unsalted butter',
        '2 slices thick-cut bacon, cooked and broken into pieces',
        '2 c. spinach, torn',
        '2 oz. Gruyère cheese, shredded',
      ]),
  Product(
    id: 6,
    title: "Tarte à la rhubarbe meringuée alsacienne",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_6.jpeg",
    color: Color(0xFFAEAEAE),
    ingredients: [
      '1 pâte brisée 0,75€',
      '3 pommes pas trop acides 4,49€',
      '150 g de sucre en poudre 0,99€',
      '80 g de beurre fondu 1,79€',
      '2 citrons bien lavés',
      '2 oeufs 2,29 €',
    ],
  ),
];
String dummyText = "blabla";
String DEStext =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

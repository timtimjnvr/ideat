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
      title: "Escargot",
      price: 14,
      size: 5,
      description: " steps",
      image: "assets/images/bag_1.png",
      color: Color(0xFF3D82AE),
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
      id: 2,
      title: "Bacon Cheddar",
      price: 15,
      size: 5,
      description: dummyText,
      image: "assets/images/bag_2.png",
      color: Color(0xFFD3A984),
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
      id: 3,
      title: "Foie gras",
      price: 16,
      size: 5,
      description: dummyText,
      image: "assets/images/bag_3.png",
      color: Color(0xFF989493),
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
      id: 4,
      title: "Mandu",
      price: 24,
      size: 5,
      description: "bla bla bla",
      image: "assets/images/bag_4.png",
      color: Color(0xFFE6B398),
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
      id: 5,
      title: "Office Code",
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
    title: "Office Code",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/bag_6.png",
    color: Color(0xFFAEAEAE),
    ingredients: [
      '8 large eggs',
      '1 tsp. Dijon mustard',
      'Kosher salt and pepper',
      '1 tbsp. olive oil or unsalted butter',
      '2 slices thick-cut bacon, cooked and broken into pieces',
      '2 c. spinach, torn',
      '2 oz. Gruyère cheese, shredded',
    ],
  ),
];
String dummyText = "blabla";
String DEStext =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";

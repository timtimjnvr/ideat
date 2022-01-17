import 'package:flutter/material.dart';
import 'package:ideat/models/Product.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Ingredients(product: product),
    );
  }
}

class Ingredients extends StatelessWidget {
  const Ingredients({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: product.ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                  ),
                  child: Text('⚫️ ' + product.ingredients[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black.withOpacity(0.3));
              },
            ),
          ],
        ),
      ),
    );
  }
}

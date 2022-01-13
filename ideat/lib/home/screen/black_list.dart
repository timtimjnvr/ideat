import 'package:flutter/material.dart';

class Food {
  const Food(this.name);
  final String name;
}

class CastList extends StatefulWidget {
  const CastList({Key? key}) : super(key: key);

  @override
  State createState() => CastListState();
}

class CastListState extends State<CastList> {
  final List<Food> _cast = <Food>[
    const Food('Poulet'),
    const Food('Alexander Hamilton'),
    const Food('Eliza Hamilton'),
    const Food('James Madison'),
  ];

  Iterable<Widget> get actorWidgets sync* {
    for (final Food food in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          label: Text(food.name),
          onDeleted: () {
            setState(() {
              _cast.removeWhere((Food entry) {
                return entry.name == food.name;
              });
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text("Ingredients you dislike"),
      Wrap(
       children: actorWidgets.toList(),
    ),
    ElevatedButton(
  onPressed: () {setState((){_cast.add(const Food("Les endives"));});},
  child: Text('+'),
  style: ElevatedButton.styleFrom(
    shape: CircleBorder(),
    padding: EdgeInsets.all(12),
    primary: Colors.grey,
  ),

)
    ],);
  }
}


class BlackList extends StatefulWidget {
  const BlackList({Key? key}) : super(key: key);

  @override
  State<BlackList> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BlackList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CastList(),
      Text('This is a test')
    ],);
  }
}

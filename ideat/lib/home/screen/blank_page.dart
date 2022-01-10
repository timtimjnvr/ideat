import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget {
  BlankPage({Key? key}) : super(key: key);

  @override
  _BlankPagePageState createState() => _BlankPagePageState();
}

class _BlankPagePageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlankPage Page"),
      ),
      body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}

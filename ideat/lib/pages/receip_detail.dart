import 'package:flutter/material.dart';

class Receip_detail extends StatefulWidget {
  Receip_detail({Key? key}) : super(key: key);

  @override
  _Receip_detailPageState createState() => _Receip_detailPageState();
}

class _Receip_detailPageState extends State<Receip_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receip_detail Page"),
      ),
          body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}

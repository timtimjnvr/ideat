import 'package:flutter/material.dart';

class Cart_list extends StatefulWidget {
  Cart_list({Key? key}) : super(key: key);

  @override
  _Receip_detailPageState createState() => _Receip_detailPageState();
}

class _Receip_detailPageState extends State<Cart_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart_list Page"),
      ),
      body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}

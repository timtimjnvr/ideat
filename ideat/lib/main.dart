import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title of Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int tapCount = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BottomNavigationBar Example"),
      ),
      body: Center(
          child: Text("Tap Count: " +
              tapCount.toString() +
              ", Index: " +
              selectedIndex.toString())),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedIconTheme:
            const IconThemeData(color: Colors.red, opacity: 1.0, size: 30),
        backgroundColor: Colors.orange.shade100,
        unselectedIconTheme:
            const IconThemeData(color: Colors.cyan, opacity: 1.0, size: 28),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_rounded),
            title: Text("Contacts"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Emails"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    setState(() {
      tapCount++;
      selectedIndex = index;
    });
  }
}

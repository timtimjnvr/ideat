import 'package:flutter/material.dart';
import 'package:ideat/home/screen/blank_page.dart';
import 'package:ideat/home/screen/preferences.dart';

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

  final screens = [
    Preferences(),
    BlankPage(),
    BlankPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
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
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Emails",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
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

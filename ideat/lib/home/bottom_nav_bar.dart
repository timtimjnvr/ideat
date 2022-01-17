import 'package:flutter/material.dart';
import 'package:ideat/home/components/search_bar.dart';
import 'package:ideat/home/screen/black_list.dart';
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
  int selectedIndex = 0;

  final screens = [
    Preferences(),
    BlackList(),
    SearchBar(),
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
            label: "Profil",

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
      selectedIndex = index;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:ideat/home/components/search_bar.dart';
import 'package:ideat/home/screen/black_list.dart';
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
    SearchBar(),
    //BlackList()
    Preferences(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedIconTheme:
            const IconThemeData(color: Colors.black, opacity: 1.0, size: 28),
        //backgroundColor: Colors.grey,
        unselectedIconTheme:
            const IconThemeData(color: Colors.grey, opacity: 1.0, size: 25),
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Contacts",
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Emails",
          ),
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

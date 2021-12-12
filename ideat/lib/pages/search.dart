import 'package:flutter/material.dart';
import 'package:ideat/pages/receip_detail.dart';

void main() {
  runApp(const Search());
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  PageController _pageController = PageController();
  List<Widget> _screens = [Search(), Receip_detail()];
  void _onPageChanged(int selectedIndex) {
    print(selectedIndex);
  }

  void _onItemTapped(int index) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //currentIndex: selectedIndex,
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
          //onTapHandler(index);
        },
      ),
    );
  }
}

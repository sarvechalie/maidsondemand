import 'package:flutter/material.dart';
import 'package:shop_app/screens/categories/categories_screen.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = "/tabs";

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': HomeScreen(), 'title': 'Chat'},
      {'page': ProfileScreen(), 'title': 'Profile'},
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: <Widget>[
        _pages[_selectedPageIndex]['page'],
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: _selectPage,
      elevation: 0,
      iconSize: 25,
      backgroundColor: Colors.white,
      currentIndex: _selectedPageIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/Shop.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/Shop.png"),
          ),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: ImageIcon(
        //     AssetImage("assets/icons/Grid View.png"),
        //   ),
        //   activeIcon: ImageIcon(
        //     AssetImage("assets/icons/Grid View.png"),
        //   ),
        //   label: 'Categories',
        // ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/Contact Us.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/Contact Us.png"),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/User.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/User.png"),
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: _body(context),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }
}

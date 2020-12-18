import 'package:flutter/material.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/orders/orders_screen.dart';

class TabsScreenMaid extends StatefulWidget {
  static String routeName = "/tabsMaid";
  final String name;

  const TabsScreenMaid({Key key, this.name}) : super(key: key);
  @override
  _TabsScreenMaidState createState() => _TabsScreenMaidState(name);
}

class _TabsScreenMaidState extends State<TabsScreenMaid> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  final String name;

  _TabsScreenMaidState(this.name);
  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': OrdersScreen(), 'title': 'Order'},
      {'page': HomeScreen(), 'title': 'Chat'},
      {'page': ProfileScreen(), 'title': 'Profile'},
    ];
    if (name == "order") {
      setState(() {
        _selectedPageIndex = 0;
      });
    }
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
            AssetImage("assets/icons/Orders.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/Orders.png"),
          ),
          label: 'Order',
        ),
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

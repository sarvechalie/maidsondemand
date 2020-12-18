import 'package:flutter/material.dart';
import 'package:shop_app/home.dart';
import 'package:shop_app/screens/maid_screen/maid_screen.dart';
import 'package:shop_app/screens/reshedule_screen/reschedule_screen.dart';
import 'package:shop_app/screens/orders/orders_screen.dart';
import 'package:shop_app/screens/user_screen/user_screen.dart';

class TabsAdmin extends StatefulWidget {
  static String routeName = "/tabs_admin";
  final String name;

  const TabsAdmin({Key key, this.name}) : super(key: key);
  @override
  _TabsAdminState createState() => _TabsAdminState(name);
}

class _TabsAdminState extends State<TabsAdmin> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  final String name;

  _TabsAdminState(this.name);

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': MaidScreen(), 'title': 'User'},
      {'page': OrdersScreen(), 'title': 'Order'},
      {'page': RescheduleScreen(), 'title': 'Reschedule Order'},
      {'page': HomeScreen(), 'title': 'Chat'},
      {'page': UserScreen(), 'title': 'Profile'},
    ];
    if (name == "maid") {
      setState(() {
        _selectedPageIndex = 0;
      });
    }
    if (name == "order") {
      setState(() {
        _selectedPageIndex = 1;
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
            AssetImage("assets/icons/maid.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/maid.png"),
          ),
          label: 'Maids',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/Orders.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/Orders.png"),
          ),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/reschedule.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/reschedule.png"),
          ),
          label: 'Reschedule',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/Contact Us.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/Contact Us.png"),
          ),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/User.png"),
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/User.png"),
          ),
          label: 'Users',
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

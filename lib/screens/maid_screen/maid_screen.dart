import 'package:flutter/material.dart';
import 'package:shop_app/screens/register_maid_screen/register_maid_screen.dart';
import 'package:shop_app/screens/tabs_admin/tabs_admin.dart';

import 'components/body.dart';

class MaidScreen extends StatelessWidget {
  static String routeName = "/maid_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maids'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              RegisterMaidScreen.routeName,
            ).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TabsAdmin(
                    name: "maid",
                  ),
                ),
              );
            }),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Body(),
    );
  }
}

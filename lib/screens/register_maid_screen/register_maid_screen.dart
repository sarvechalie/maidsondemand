import 'package:flutter/material.dart';

import 'components/body.dart';

class RegisterMaidScreen extends StatelessWidget {
  static String routeName = "/register_maid_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Maid'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

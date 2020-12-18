import 'package:flutter/material.dart';
import 'components/body.dart';

class UserScreen extends StatelessWidget {
  static String routeName = "/user_screen.dart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('User Details'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

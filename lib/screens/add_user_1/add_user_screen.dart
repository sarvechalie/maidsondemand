import 'package:flutter/material.dart';

import 'components/body.dart';

class AddUserScreen extends StatelessWidget {
  static String routeName = "/add_user";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

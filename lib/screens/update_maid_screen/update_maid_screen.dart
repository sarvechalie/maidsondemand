import 'package:flutter/material.dart';

import 'components/body.dart';

class UpdateMaidScreen extends StatelessWidget {
  static String routeName = "/update_maid_screen";
  final String userId;

  const UpdateMaidScreen({Key key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Maid'),
        centerTitle: true,
      ),
      body: Body(userId:userId),
    );
  }
}

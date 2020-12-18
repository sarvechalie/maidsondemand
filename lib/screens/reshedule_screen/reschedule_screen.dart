import 'package:flutter/material.dart';

import 'components/body.dart';

class RescheduleScreen extends StatelessWidget {
  static String routeName = "/reschedule_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Reschedule Orders'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

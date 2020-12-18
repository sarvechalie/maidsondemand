import 'package:flutter/material.dart';

import 'components/body.dart';

class DetailClientScreen extends StatelessWidget {
  static String routeName = "/detail_client";
  final String userId;

  const DetailClientScreen({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Info'),
        centerTitle: true,
      ),
      body: Body(userId:userId),
    );
  }
}

import 'package:flutter/material.dart';

import 'components/body.dart';

class OrdersDetailScreen extends StatelessWidget {
  static String routeName = "/user_screen.dart";
  final String orderId;

  const OrdersDetailScreen({Key key, this.orderId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Order Details'),
        centerTitle: true,
      ),
      body: Body(orderId:orderId),
    );
  }
}

import 'package:flutter/material.dart';

import 'components/body.dart';

class RescheduleOrderScreen extends StatelessWidget {
  static String routeName = "/reschedule_order";
  final String orderId;
  final int orderNumber;
  const RescheduleOrderScreen({Key key, this.orderId,this.orderNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reschedule Orders'),
        centerTitle: true,
      ),
      body: Body(orderId:orderId,orderNumber:orderNumber),
    );
  }
}

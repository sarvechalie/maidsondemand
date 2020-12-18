import 'package:flutter/material.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/models/order.dart';

import 'orders_detail_list_item.dart';

class Body extends StatefulWidget {
  final String orderId;
  const Body({Key key, this.orderId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(orderId);
}

class _BodyState extends State<Body> {
  final String orderId;
  List<Order> order = [];

  _BodyState(this.orderId);
  @override
  void initState() {
    super.initState();
    print("hello");
    Future.delayed(Duration(milliseconds: 10), () {
      getOrderDetails(orderId);
    });
  }

  getOrderDetails(String id) async {
    DummyData.orderNumber = 0;
    Future<List<Order>> list = DatabaseFireStore().getDetailOrders(id);
    List<Order> data = await list;
    setState(() {
      order = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemCount: order.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: OrderDetailListItem(
                          order: order[index],
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

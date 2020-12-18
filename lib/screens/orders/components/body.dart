import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/screens/orders/components/orders_list_item.dart';
import 'package:flutter_session/flutter_session.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Order> order=[];
  dynamic userId;
  dynamic screen;
  @override
  void initState() {
    super.initState();
   getSession();
    getSession1();
   Future.delayed(Duration(milliseconds:10),(){
     getOrders(userId,screen);
   });

  }
  getSession() async {
    dynamic id=await FlutterSession().get('login');
    setState(() {
      userId=id;
    });
  }
  getSession1() async {
    dynamic screenRetrieve=await FlutterSession().get('screen');
    setState(() {
      screen=screenRetrieve;
    });
  }
  getOrders(dynamic id,dynamic screen)async{
    DummyData.orderNumber=0;
    Future<List<Order>> list=DatabaseFireStore().getOrders(id,screen);
    List<Order> data=await list;
    setState(() {
      order=data;
    });
  }
  removeOrder(int index) {
    setState(() {
      DatabaseFireStore().deleteOrders(order[index].orderId);
      order.removeAt(index);

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
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: OrderListItem(
                        order: order[index],
                      ),
                      secondaryActions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: IconSlideAction(
                              color: Colors.transparent,
                              icon: Icons.delete,
                              foregroundColor: kPrimaryColor,
                              onTap: () => removeOrder(index),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

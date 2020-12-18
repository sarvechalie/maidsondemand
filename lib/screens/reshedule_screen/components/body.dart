import 'package:flutter/material.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/models/reschedule.dart';
import 'package:shop_app/screens/reshedule_screen/components/reschedule_list_items.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<RescheduleOrder> order = [];
  dynamic userId;
  dynamic screen;
  @override
  void initState() {
    super.initState();
    getRescheduleOrders();
    // getSession();
    //  getSession1();
    // Future.delayed(Duration(milliseconds:10),(){
    //   getOrders(userId,screen);
    // });
  }

  // getSession() async {
  //   dynamic id=await FlutterSession().get('login');
  //   setState(() {
  //     userId=id;
  //   });
  // }
  // getSession1() async {
  //   dynamic screenRetrieve=await FlutterSession().get('screen');
  //   setState(() {
  //     screen=screenRetrieve;
  //   });
  // }
  getRescheduleOrders() async {
    DummyData.orderNumber = 0;
    Future<List<RescheduleOrder>> list =
        DatabaseFireStore().getRescheduleOrders();
    List<RescheduleOrder> data = await list;
    setState(() {
      order = data;
    });
  }

  removeRescheduleOrder(int index) {
    setState(() {
      DatabaseFireStore().deleteRescheduleOrders(order[index].id);
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
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: RescheduleScreenListItem(
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

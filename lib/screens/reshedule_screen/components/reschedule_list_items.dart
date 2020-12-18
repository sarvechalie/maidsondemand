import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/reschedule.dart';
import 'package:shop_app/screens/reshedule_screen/reschedule_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/Services/database.dart';

class RescheduleScreenListItem extends StatefulWidget {
  final RescheduleOrder order;
  const RescheduleScreenListItem({
    Key key,
    this.order,
  }) : super(key: key);
  @override
  _RescheduleScreenListItemState createState() =>
      _RescheduleScreenListItemState();
}

class _RescheduleScreenListItemState extends State<RescheduleScreenListItem> {
  bool processing = false;
  @override
  void initState() {
    super.initState();
  }

  updateOrder() async {
    setState(() {
      processing = true;
    });
    await DatabaseFireStore()
        .updateOrder(widget.order.date, widget.order.time, widget.order.id);
    await DatabaseFireStore().updateScheduleOrder(widget.order.id);
    Navigator.pushReplacementNamed(context, RescheduleScreen.routeName);
    setState(() {
      processing = false;
    });
    Fluttertoast.showToast(
        msg: "Order has been rescheduled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(150, 161, 55, 1),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // getSession() async {
  //   dynamic screenRetrieve=await FlutterSession().get('screen');
  //   setState(() {
  //     screen=screenRetrieve;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: double.infinity,
        child: Card(
          shadowColor: kCardBackgroundColor,
//        color: kBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.04,
                vertical: SizeConfig.screenHeight * 0.010),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Order id',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                widget.order.number.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date'),
                              Text(widget.order.date),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Time'),
                              Text(widget.order.time),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.005,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 120,
                                height: 28,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  color: kPrimaryColor,
                                  onPressed: () {
                                    updateOrder();
                                  },
                                  child: Text(
                                    'Approve',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: getProportionateScreenWidth(10)),
                            ],
                          ),
//                        GestureDetector(
//                          onTap: () => null,
//                          child: Text(
//                            'DETAILS',
//                            style: TextStyle(
//                              color: kPrimaryColor,
//                              fontSize: 14,
//                            ),
//                          ),
//                        )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

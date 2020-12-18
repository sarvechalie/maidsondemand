import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/screens/orders_detail/orders_detail.dart';
import 'package:shop_app/screens/reschedule_order/reschedule_order.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter_session/flutter_session.dart';

class OrderListItem extends StatefulWidget {
  final Order order;

  const OrderListItem({
    Key key,
    this.order,
  }) : super(key: key);
  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  dynamic screen;
  @override
  void initState() {
    super.initState();
    getSession();
  }

  getSession() async {
    dynamic screenRetrieve = await FlutterSession().get('screen');
    setState(() {
      screen = screenRetrieve;
    });
  }

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
                vertical: SizeConfig.screenHeight * 0.050),
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
                                width: 80,
                                height: 28,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  color: kPrimaryColor,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrdersDetailScreen(
                                          orderId: widget.order.orderId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: getProportionateScreenWidth(10)),
                              screen.toString() != "admin"
                                  ? Container(
                                      width: 110,
                                      height: 28,
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        color: kPrimaryColor,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RescheduleOrderScreen(
                                                orderId: widget.order.orderId,
                                                orderNumber:
                                                    widget.order.number,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Reschedule',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
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

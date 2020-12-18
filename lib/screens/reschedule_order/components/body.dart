import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/components/basic_date_field.dart';
import 'package:shop_app/components/basic_time_field.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/size_config.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final String orderId;
  final int orderNumber;
  const Body({Key key, this.orderId, this.orderNumber}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(orderId, orderNumber);
}

class _BodyState extends State<Body> {
  final String orderId;
  final int orderNumber;
  final _formKey = GlobalKey<FormState>();
  bool processing = false;
  bool completed = false;
  TextEditingController date;
  TextEditingController time;

  _BodyState(this.orderId, this.orderNumber);

  @override
  void initState() {
    super.initState();
    date = new TextEditingController();
    time = new TextEditingController();
  }

  updateOrder() async {
    setState(() {
      processing = true;
    });
    await DatabaseFireStore()
        .scheduleOrder(date.text, time.text, orderId, orderNumber);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Enter Rescheduling Details'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasicDateField(
                          format: DateFormat("dd-MMM-yyyy"),
                          autoFocus: false,
                          controller: date,
                          label: "Select Date",
                          formFieldValidator: (value) {
                            String result;
                            if (value.isEmpty) {
                              result = "This is Required Field";
                            } else {
                              result = null;
                            }
                            return result;
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        BasicTimeField(
                          format: DateFormat("HH:mm"),
                          autoFocus: false,
                          controller: time,
                          label: "Select Time",
                          formFieldValidator: (value) {
                            String result;
                            if (value.isEmpty) {
                              result = "This is Required Field";
                            } else {
                              result = null;
                            }
                            return result;
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                      ],
                    ),
                  ],
                ),
              ),
              DefaultButton(
                processing: processing,
                text: 'Request Reschedule',
                press: () {
                  updateOrder();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

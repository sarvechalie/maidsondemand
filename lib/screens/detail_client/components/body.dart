import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/components/basic_date_field.dart';
import 'package:shop_app/screens/map_screen/map_screen.dart';
import 'package:shop_app/components/basic_time_field.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/card_custom_text_field.dart';
import 'package:shop_app/size_config.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  final String userId;

  const Body({Key key, this.userId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(userId);
}

class _BodyState extends State<Body> {
  final String userId;
  String _address = '';

  final _formKey = GlobalKey<FormState>();
  bool processing = false;
  bool completed = false;
  TextEditingController name;
  TextEditingController city;
  TextEditingController country;
  TextEditingController phoneNumber;
  TextEditingController address;
  TextEditingController date;
  TextEditingController time;

  _BodyState(this.userId);

  @override
  void initState() {
    super.initState();
    name = new TextEditingController();
    city = new TextEditingController();
    country = new TextEditingController();
    phoneNumber = new TextEditingController();
    address = new TextEditingController();
    date = new TextEditingController();
    time = new TextEditingController();
  }

  bookOrder() async {
    setState(() {
      processing = true;
    });
    await DatabaseFireStore().bookMaid(name.text, city.text, phoneNumber.text,
        address.text, date.text, time.text, userId);
    setState(() {
      processing = false;
    });
    Fluttertoast.showToast(
        msg: "Order has been booked",
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
              Text('Enter Your Information For Booking Maid'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardCustomTextField(
                          label: 'Name',
                          hint: "Please enter your name",
                          autoFocus: true,
                          obscure: false,
                          textInputType: TextInputType.name,
                          controller: name,
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
                        CardCustomTextField(
                          label: 'City',
                          autoFocus: true,
                          textInputType: TextInputType.text,
                          controller: city,
                          hint: 'Please enter your city',
                          obscure: false,
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
                        CardCustomTextField(
                          label: 'Address',
                          autoFocus: true,
                          textInputType: TextInputType.text,
                          controller: address,
                          hint: 'Please enter your address',
                          obscure: false,
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
                        RaisedButton(
                          onPressed: () {
                            Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high)
                                .then((value) async {
                              _address = await Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => MapScreen(
                                            lat: value.latitude,
                                            lng: value.longitude,
                                          )));
                              address.text = _address;
                            });
                          },
                          child: Text('Add Location'),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        CardCustomTextField(
                          label: 'Phone Number',
                          autoFocus: true,
                          textInputType: TextInputType.phone,
                          controller: phoneNumber,
                          hint: 'Please enter your phone number',
                          obscure: false,
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
                        BasicDateField(
                          format: DateFormat("dd-MMM-yyyy"),
                          autoFocus: true,
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
                          autoFocus: true,
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
                text: 'Book',
                press: () {
                  bookOrder();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

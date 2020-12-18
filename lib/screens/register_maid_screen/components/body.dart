import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Services/auth.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/card_custom_text_field.dart';
import 'package:shop_app/components/drop_down_menu.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  bool processing = false;
  bool completed = false;
  String dropdownValue;
  TextEditingController name;
  TextEditingController email;
  TextEditingController password;
  TextEditingController phoneNumber;
  TextEditingController address;
  TextEditingController description;
  TextEditingController city;
  TextEditingController confirmPassword;
  String url =
      "https://firebasestorage.googleapis.com/v0/b/sweepon-b06ba.appspot.com/o/maid.jpg?alt=media&token=46db9370-fb38-4608-8def-cc5892b7bc3b";
  @override
  void initState() {
    super.initState();
    name = new TextEditingController();
    email = new TextEditingController();
    password = new TextEditingController();
    phoneNumber = new TextEditingController();
    address = new TextEditingController();
    city = new TextEditingController();
    description = new TextEditingController();
    confirmPassword = new TextEditingController();
  }

  maidRegistration() async {
    setState(() {
      processing = true;
    });
    dynamic result = await Authentication().registrationMaid(
        name.text,
        email.text,
        password.text,
        phoneNumber.text,
        address.text,
        city.text,
        dropdownValue,
        url,
        description.text);
    Future.delayed(Duration(microseconds: 10), () {
      if (result.toString() == "Instance of 'UserId'") {
        Fluttertoast.showToast(
            msg: "New Record Created Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(150, 161, 55, 1),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          processing = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: result.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(150, 161, 55, 1),
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          processing = false;
        });
      }
    });
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
              Text('Enter Maid Information'),
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
                          autoFocus: true,
                          obscure: false,
                          textInputType: TextInputType.name,
                          controller: name,
                          hint: "Please enter your name",
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
                          label: "email",
                          hint: 'Please enter your email',
                          obscure: false,
                          autoFocus: true,
                          controller: email,
                          textInputType: TextInputType.emailAddress,
                          formFieldValidator: (value) {
                            String result;
                            if (value.isEmpty) {
                              result = "This is Required Field";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              result = "Email is not valid";
                            } else {
                              result = null;
                            }
                            return result;
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        CardCustomTextField(
                          label: "Password",
                          hint: 'Please enter your password',
                          obscure: true,
                          autoFocus: true,
                          controller: password,
                          textInputType: TextInputType.text,
                          formFieldValidator: (value) {
                            String result;
                            if (value.isEmpty) {
                              result = "This is Required Field";
                            } else if (value.length < 6) {
                              result =
                                  "Password must be at least 6 characters long";
                            } else {
                              result = null;
                            }
                            return result;
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        CardCustomTextField(
                          label: "Retype Password",
                          hint: 'Please re enter your password',
                          obscure: true,
                          textInputType: TextInputType.text,
                          controller: confirmPassword,
                          autoFocus: true,
                          formFieldValidator: (value) {
                            String result;
                            if (value.isEmpty) {
                              result = "This is Required Field";
                            } else if (value != password.text) {
                              result = "Password Does Not match";
                            } else {
                              result = null;
                            }
                            return result;
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        CardCustomTextField(
                          hint: "Please enter your city",
                          label: 'City / Country',
                          autoFocus: true,
                          obscure: false,
                          textInputType: TextInputType.text,
                          controller: city,
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
                          obscure: false,
                          hint: "Please enter your address",
                          textInputType: TextInputType.text,
                          controller: address,
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
                          label: 'Phone Number',
                          autoFocus: true,
                          obscure: false,
                          hint: "Please enter your number",
                          textInputType: TextInputType.phone,
                          controller: phoneNumber,
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
                          label: 'Description',
                          autoFocus: true,
                          obscure: false,
                          hint: "Enter Maid Description",
                          textInputType: TextInputType.text,
                          controller: description,
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
                        DropdownFormField(
                          label: "Categories",
                          dropdownValue: dropdownValue,
                          hint: "Please choose any one",
                          formFieldValidator: (value) {
                            String result;
                            if (value.isEmpty) {
                              result = "This is Required Field";
                            } else {
                              result = null;
                            }
                            return result;
                          },
                          saved: (value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                          changed: (value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                      ],
                    ),
                  ],
                ),
              ),
              DefaultButton(
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    maidRegistration();
                  }
                },
                processing: processing,
                text: 'Add',
              )
            ],
          ),
        ),
      ),
    );
  }
}

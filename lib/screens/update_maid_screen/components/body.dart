import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/card_custom_text_field.dart';
import 'package:shop_app/components/drop_down_menu.dart';
import 'package:shop_app/models/get_maid.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatefulWidget {
  final String userId;

  const Body({Key key, this.userId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(userId);
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final String userId;
  bool processing = false;
  bool completed = false;
  String dropdownValue;
  TextEditingController name;
  TextEditingController email;
  TextEditingController phoneNumber;
  TextEditingController address;
  TextEditingController city;
  TextEditingController amount;
  TextEditingController discountAmount;
  TextEditingController description;
  _BodyState(this.userId);
  @override
  void initState() {
    super.initState();
    name = new TextEditingController();
    email = new TextEditingController();
    phoneNumber = new TextEditingController();
    address = new TextEditingController();
    city = new TextEditingController();
    description = new TextEditingController();
    getMaid();
  }

  getMaid() async {
    Future<List<GetMaid>> list = DatabaseFireStore().getMaidForUpdation(userId);
    List<GetMaid> data = await list;
    for (GetMaid i in data) {
      setState(() {
        name.text = i.name;
        email.text = i.email;
        phoneNumber.text = i.phoneNumber;
        city.text = i.city;
        address.text = i.address;
        description.text=i.description;
        dropdownValue = i.category;
      });
    }
  }

  maidUpdation() async {
    setState(() {
      processing = true;
    });
    await DatabaseFireStore().updationMaid(name.text, email.text,
        phoneNumber.text, address.text, city.text, dropdownValue,description.text, userId);
    Fluttertoast.showToast(
        msg: "Updated Successfully",
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
                        // SizedBox(height: getProportionateScreenHeight(8)),
                        // CardCustomTextField(
                        //   label: "Password",
                        //   hint: 'Please enter your password',
                        //   obscure: true,
                        //   autoFocus: true,
                        //   controller: password,
                        //   textInputType: TextInputType.text,
                        //   formFieldValidator: (value) {
                        //     String result;
                        //     if(value.isEmpty){
                        //       result="This is Required Field";
                        //     }
                        //     else if(value.length<6){
                        //       result="Password must be at least 6 characters long";
                        //     }
                        //     else{
                        //       result=null;
                        //     }
                        //     return result;
                        //   },
                        //  ),
                        // SizedBox(height: getProportionateScreenHeight(8)),
                        // CardCustomTextField(
                        //   label: "Retype Password",
                        //   hint: 'Please re enter your password',
                        //   obscure: true,
                        //   textInputType: TextInputType.text,
                        //   controller: confirmPassword,
                        //   autoFocus: true,
                        //   formFieldValidator: (value) {
                        //     String result;
                        //     if(value.isEmpty){
                        //       result="This is Required Field";
                        //     }
                        //     else if(value!=password.text){
                        //       result="Password Does Not match";
                        //     }
                        //     else{
                        //       result=null;
                        //     }
                        //     return result;
                        //   },
                        // ),
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
                        CardCustomTextField(
                          label: 'Description',
                          autoFocus: true,
                          obscure: false,
                          hint: "Please enter your description",
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
                      ],
                    ),
                  ],
                ),
              ),
              DefaultButton(
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    maidUpdation();
                  }
                },
                processing: processing,
                text: 'Update',
              )
            ],
          ),
        ),
      ),
    );
  }
}

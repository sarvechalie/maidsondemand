import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Services/auth.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/tabs/tabs_screen.dart';
import 'package:shop_app/screens/tabsMaid/tabs_screenMaid.dart';
import 'package:shop_app/screens/tabs_admin/tabs_admin.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_session/flutter_session.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email, password;
  bool remember = false;
  bool processing = false;
  final List<String> errors = [];
  String dropdownValue = 'Client';
  @override
  void initState() {
    super.initState();
    email = new TextEditingController();
    password = new TextEditingController();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  userLogin() async {
    setState(() {
      processing = true;
    });
    Future<bool> userCheck = DatabaseFireStore().userCheck(email.text);
    bool data = await userCheck;
    if (data == true) {
      login();
    } else {
      Fluttertoast.showToast(
          msg: "Record Not Found",
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
  }

  maidLogin() async {
    setState(() {
      processing = true;
    });
    Future<bool> userCheck = DatabaseFireStore().maidCheck(email.text);
    bool data = await userCheck;
    if (data == true) {
      login();
    } else {
      Fluttertoast.showToast(
          msg: "Record Not Found",
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
  }

  login() async {
    dynamic result =
        await Authentication().login(email.text, password.text, dropdownValue);
    Future.delayed(Duration(microseconds: 100), () {
      if (result.toString() == "Instance of 'UserId'") {
        if (FirebaseAuth.instance.currentUser.emailVerified == true) {
          Fluttertoast.showToast(
              msg: "Successfully Signed In",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(150, 161, 55, 1),
              textColor: Colors.white,
              fontSize: 16.0);
          if (dropdownValue == "Client") {
            FlutterSession().set('screen', "client");
            FlutterSession().set('login', result.id);
            Navigator.pushNamed(context, TabsScreen.routeName);
          } else {
            FlutterSession().set('screen', "maid");
            FlutterSession().set('login', result.id);
            Navigator.pushNamed(context, TabsScreenMaid.routeName);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Email is Not Verified",
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

  adminLogin() async {
    setState(() {
      processing = true;
    });
    Future<dynamic> id = DatabaseFireStore().addAdmin();
    String adminId = await id;
    if (id != null) {
      FlutterSession().set('screen', "admin");
      FlutterSession().set('login', adminId);
      Fluttertoast.showToast(
          msg: "Successfully Signed In",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(150, 161, 55, 1),
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Email',
              style: TextStyle(fontSize: 15),
            ),
          ),
          CustomTextFormField(
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
          SizedBox(height: getProportionateScreenHeight(10)),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Password',
              style: TextStyle(fontSize: 15),
            ),
          ),
          CustomTextFormField(
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
                result = "Password must be at least 6 characters long";
              } else {
                result = null;
              }
              return result;
            },
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Login As',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Container(
            width: 400.0,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: kPrimaryColor,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Client', 'Maid', 'Admin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (dropdownValue == "Client") {
                  userLogin();
                } else if (dropdownValue == "Maid") {
                  maidLogin();
                } else {
                  if (email.text == "admin@gmail.com" &&
                      password.text == "admin123") {
                    adminLogin();
                    Navigator.pushNamed(context, TabsAdmin.routeName);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Email and Password Invalid",
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
                }
              }
            },
            processing: processing,
            text: "Login",
          ),
        ],
      ),
    );
  }
}

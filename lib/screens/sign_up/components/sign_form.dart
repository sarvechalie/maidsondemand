import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Services/auth.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import '../../../components/default_button.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name, email, password, confirmPassword, phoneNumber;
  String url =
      "https://firebasestorage.googleapis.com/v0/b/sweepon-b06ba.appspot.com/o/maid.jpg?alt=media&token=46db9370-fb38-4608-8def-cc5892b7bc3b";
  bool remember = false;
  final List<String> errors = [];
  bool processing = false;
  @override
  void initState() {
    super.initState();
    name = new TextEditingController();
    email = new TextEditingController();
    password = new TextEditingController();
    confirmPassword = new TextEditingController();
    phoneNumber = new TextEditingController();
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

  registration() async {
    setState(() {
      processing = true;
    });
    dynamic result = await Authentication().registration(
        name.text, email.text, password.text, phoneNumber.text, url);
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
        Navigator.pushNamed(context, SignInScreen.routeName);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Name',
              style: TextStyle(fontSize: 15),
            ),
          ),
          CustomTextFormField(
            hint: 'Please enter your name',
            obscure: false,
            autoFocus: true,
            controller: name,
            textInputType: TextInputType.name,
            formFieldValidator: (value) =>
                value.isEmpty ? "This is Required Field" : null,
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
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
              'Phone Number',
              style: TextStyle(fontSize: 15),
            ),
          ),
          CustomTextFormField(
            hint: 'Please enter your number',
            obscure: false,
            textInputType: TextInputType.phone,
            controller: phoneNumber,
            autoFocus: true,
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
            textInputType: TextInputType.text,
            controller: password,
            autoFocus: true,
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
          SizedBox(height: getProportionateScreenHeight(10)),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Retype Password',
              style: TextStyle(fontSize: 15),
            ),
          ),
          CustomTextFormField(
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
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                registration();
                // if all are valid then go to success screen
                //Navigator.pushNamed(context, VerificationScreen.routeName);
              }
            },
            processing: processing,
            text: "Sign up",
          ),
        ],
      ),
    );
  }
}

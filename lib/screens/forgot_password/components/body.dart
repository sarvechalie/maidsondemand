import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/custom_text_form_field.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/Services/auth.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(23)),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),
              Text(
                "Please enter your email and we will send \nyou a link to update your password",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  TextEditingController email;
  bool processing = false;
  @override
  void initState() {
    super.initState();
    email = new TextEditingController();
  }

  forgotPassword() async {
    setState(() {
      processing = true;
    });
    String result = await Authentication().passwordReset(email.text);
    Future.delayed(Duration(microseconds: 10), () {
      if (result == "Succeeded") {
        Fluttertoast.showToast(
            msg: "Password resent link send Successfully",
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
          SizedBox(height: getProportionateScreenHeight(60)),
          DefaultButton(
            press: () {
              if (_formKey.currentState.validate()) {
                forgotPassword();
              }
            },
            processing: processing,
            text: "Continue",
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          AccountText(
            question: "Don’t have an account? ",
            action: 'Sign Up',
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: kTextColor),
      gapPadding: 10,
    );
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder,
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(4),
          horizontal: getProportionateScreenWidth(36),
        ),
        // If  you are using latest version of flutter then label text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.mail_outline,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/components/card_custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

bookOrder() {
  Fluttertoast.showToast(
      msg: "Payment unsuccesful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromRGBO(255, 80, 80, 1),
      textColor: Colors.white,
      fontSize: 16.0);
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardCustomTextField(
              label: 'Name',
              autoFocus: true,
              hint: 'Please enter your Name',
              obscure: false,
              textInputType: TextInputType.text,
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
              label: 'Amount',
              autoFocus: true,
              hint: 'Please enter amount',
              obscure: false,
              textInputType: TextInputType.number,
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
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                bookOrder();
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text('Paypal Pay', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class CardListItem extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CardListItem({
    Key key,
    this.label,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder inputBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        filled: true,
        border: inputBorder,
        fillColor: Colors.white,
        prefixIcon: label != null
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(11),
                  vertical: getProportionateScreenHeight(16),
                ), //12
                child: Container(
                  width: 100,
                  child: Text(
                    label,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(12),
          horizontal: getProportionateScreenWidth(11),
        ),
        // If  you are using latest version of flutter then label text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

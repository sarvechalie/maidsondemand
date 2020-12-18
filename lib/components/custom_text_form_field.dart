import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  //final Function value;
  final bool autoFocus;
  final bool obscure;
  final int maxLines;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FormFieldValidator formFieldValidator;
  const CustomTextFormField({
    Key key,
    this.hint,
    this.obscure,
    this.autoFocus,
    this.maxLines,
    this.controller,
    this.textInputType,
    this.formFieldValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder inputBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );

    return Card(
      elevation: 5,
      shadowColor: kCardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        //onSaved: value(String),
        obscureText: obscure,
        cursorColor: kPrimaryColor,
        autofocus: autoFocus,
        controller: controller,
        validator: formFieldValidator,
        maxLines: maxLines != null ? maxLines : 1,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 15),
          border: inputBorder,
          contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(12),
            horizontal: getProportionateScreenWidth(12),
          ),
          // If  you are using latest version of flutter then label text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class CardCustomTextField extends StatelessWidget {
  final String label;
  final bool autoFocus;
  final String hint;
  final TextInputType textInputType;
  final TextEditingController controller;
  final FormFieldValidator formFieldValidator;
  final bool obscure;
  const CardCustomTextField({
    Key key,
    this.label,
    this.controller, this.autoFocus, this.textInputType, this.formFieldValidator, this.obscure, this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnderlineInputBorder inputBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );

    return Card(
      margin: EdgeInsets.all(1),
      shadowColor: kCardBackgroundColor,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        cursorColor: kPrimaryColor,
        autofocus: autoFocus,
        controller: controller,
        keyboardType: textInputType,
        validator: formFieldValidator,
        obscureText: obscure,
        decoration: InputDecoration(
          border: inputBorder,
          hintText: hint,
          prefixIcon: label != null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(11),
                    vertical: getProportionateScreenHeight(16),
                  ), //12
                  child: Container(
                    width: 105,
                    child: Text(
                      label,
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
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
      ),
    );
  }
}

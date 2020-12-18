import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../constants.dart';
import '../size_config.dart';
class BasicTimeField extends StatelessWidget {
  final DateFormat format;
  final String label;
  final bool autoFocus;
  final TextEditingController controller;
  final FormFieldValidator formFieldValidator;
  const BasicTimeField({Key key, this.format, this.label, this.autoFocus,this.controller, this.formFieldValidator}) : super(key: key);
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
    child:DateTimeField(
      controller: controller,
      format: format,
      autofocus: true,
      validator: formFieldValidator,
      onShowPicker: (context, currentValue) async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: const Color.fromRGBO(150, 161, 55,1),
                accentColor: const Color.fromRGBO(150, 161, 55,1),
                colorScheme: ColorScheme.light(primary: const Color.fromRGBO(150, 161, 55,1)),
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary
                ),
              ),
              child: child,
            );
          },
        );
        return DateTimeField.convert(time);
      },
      decoration: InputDecoration(
        border: inputBorder,
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
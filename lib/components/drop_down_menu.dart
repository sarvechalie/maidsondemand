import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../size_config.dart';

class DropdownFormField extends StatelessWidget {
  final String label;
  final Function saved;
  final Function changed;
  final String dropdownValue;
  final String hint;
  final FormFieldValidator formFieldValidator;
  const DropdownFormField(
      {Key key,
      this.label,
      this.formFieldValidator,
      this.saved,
      this.changed,
      this.dropdownValue,
      this.hint})
      : super(key: key);
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
      child: DropdownButtonFormField(
        isExpanded: true,
        value: dropdownValue,
        onSaved: saved,
        onChanged: changed,
        validator: formFieldValidator,
        items: <String>[
          'Residential Deep Cleaning',
          'Commercial Deep Cleaning',
          'Carpet Cleaning',
          'Tile & Grout Deep Cleaning',
          'Window Cleaning',
          'Oven Deep Clean',
          'Refrigerator/Freezer Deep Clean',
          'Regularly Scheduled Cleaning Service'
              'Maids For Extra Assistance'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: hint,
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

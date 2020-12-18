import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press, this.processing,
  }) : super(key: key);
  final String text;
  final Function press;
  final processing;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: kPrimaryColor,
        onPressed: press,
        child:!processing
            ?Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        )
            :Padding(
            padding: const EdgeInsets.all(2.0),
            child:CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 4.0,
              valueColor: new AlwaysStoppedAnimation<Color>(Color.fromRGBO(150, 161, 55,1)),
            ),
        ),
      ),
    );
  }
}

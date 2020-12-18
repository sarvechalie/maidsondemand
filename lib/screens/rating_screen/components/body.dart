import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Services/auth.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/card_custom_text_field.dart';
import 'package:shop_app/components/drop_down_menu.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatefulWidget {
  final String maidId;

  const Body({Key key, this.maidId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  bool processing = false;
  TextEditingController rating;
    @override
  void initState() {
    super.initState();
    rating = new TextEditingController();
  }

  maidRating() async {
    setState(() {
      processing = true;
    });
    await DatabaseFireStore().addMaidRating(rating.text, widget.maidId);
    setState(() {
      processing = false;
    });
    Fluttertoast.showToast(
        msg: "Thanks for rating us",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(150, 161, 55, 1),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Enter Rating'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardCustomTextField(
                          label: 'Rating',
                          autoFocus: true,
                          obscure: false,
                          textInputType: TextInputType.number,
                          controller: rating,
                          hint: "Please rate maid from 1 to 5",
                          formFieldValidator: (value) {
                            String result;
                            if (value.isEmpty) {
                              result = "This is Required Field";
                            } else if(value.length>5){
                              result = "Rating must be less than 5";
                            }
                            else {
                            result = null;
                            }
                            return result;
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                      ],
                    ),
                  ],
                ),
              ),
              DefaultButton(
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    maidRating();
                  }
                },
                processing: processing,
                text: 'Submit',
              )
            ],
          ),
        ),
      ),
    );
  }
}

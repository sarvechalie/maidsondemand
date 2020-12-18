import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/components/card_custom_text_field.dart';
import 'package:shop_app/models/users.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:path/path.dart' as Path;

File _image;
String _uploadedFileURL;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  bool processing = false;
  TextEditingController name;
  TextEditingController email;
  TextEditingController phoneNumber;
  String url = "";
  dynamic screen;

  @override
  void initState() {
    super.initState();
    getSession();
    Future.delayed(Duration(milliseconds: 10), () {
      getUser(screen);
    });
    name = new TextEditingController();
    email = new TextEditingController();
    phoneNumber = new TextEditingController();
  }

  getSession() async {
    dynamic screenRetrieve = await FlutterSession().get('screen');
    setState(() {
      screen = screenRetrieve;
    });
  }

  getUser(dynamic screen) async {
    dynamic result = await DatabaseFireStore().getUser(screen);
    List<Users> data = await result;
    for (Users i in data) {
      setState(() {
        name.text = i.name;
        email.text = i.email;
        phoneNumber.text = i.phoneNumber;
        url = i.url;
      });
    }
  }

  updateUser() async {
    setState(() {
      processing = true;
    });

    if (await DatabaseFireStore().maidCheck(email.text))
      await DatabaseFireStore().updateMaids(
          name.text, email.text, phoneNumber.text, _uploadedFileURL);
    if (await DatabaseFireStore().userCheck(email.text))
      await DatabaseFireStore().updateUser(
          name.text, email.text, phoneNumber.text, _uploadedFileURL);

    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(url),
                            maxRadius: 52,
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: Container(
                                width: 40,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: IconButton(
                                    onPressed: () => uploadFile(),
                                    splashRadius: 30,
                                    icon: ImageIcon(
                                      AssetImage('assets/icons/Camera.png'),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                  ],
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  CardCustomTextField(
                    label: "Name",
                    autoFocus: false,
                    obscure: false,
                    hint: "",
                    textInputType: TextInputType.name,
                    controller: name,
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
                    label: 'email',
                    autoFocus: false,
                    obscure: false,
                    hint: "",
                    textInputType: TextInputType.text,
                    controller: email,
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
                    label: 'PhoneNumber',
                    obscure: false,
                    hint: "",
                    autoFocus: false,
                    textInputType: TextInputType.name,
                    controller: phoneNumber,
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
                  SizedBox(height: getProportionateScreenHeight(23)),
                ],
              ),
              DefaultButton(
                processing: processing,
                text: 'Save',
                press: () {
                  if (_formKey.currentState.validate()) {
                    updateUser();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  uploadFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });

    upload();
  }

  upload() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('maids/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        url = _uploadedFileURL;
        print(_uploadedFileURL);
      });
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/Services/auth.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/contact_us/contact_us.dart';
import 'package:shop_app/screens/edit_profile/edit_profile_screen.dart';
import 'package:shop_app/screens/orders/orders_screen.dart';
import 'package:shop_app/screens/settings/settings_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/payment/payment_screen.dart';

import 'package:flutter_session/flutter_session.dart';

class ProfileListViewItem extends StatelessWidget {
  final String icon;
  final String text;

  const ProfileListViewItem({
    Key key,
    this.icon,
    this.text,
  }) : super(key: key);

  void logout() async {
    await Authentication().logOut();
    String out = jsonEncode(null);
    FlutterSession().set('login', out);
    FlutterSession().set('screen', out);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
      child: Card(
        elevation: 5,
        shadowColor: kCardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: InkWell(
            onTap: () {
              switch (text) {
                case 'My Account':
                  Navigator.pushNamed(context, EditProfileScreen.routeName);
                  break;
                case 'My Orders':
                  Navigator.pushNamed(context, OrdersScreen.routeName);
                  break;
                case 'Settings':
                  Navigator.pushNamed(context, SettingsScreen.routeName);
                  break;
                case 'Contact Us':
                  Navigator.pushNamed(context, ContactUsScreen.routeName);
                  break;
                case 'Payment':
                  Navigator.pushNamed(context, PaymentScreen.routeName);
                  break;
                case 'Logout':
                  logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                    (Route<dynamic> route) => false,
                  );
                  break;
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: ImageIcon(
                      AssetImage(icon),
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(text,
                      style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

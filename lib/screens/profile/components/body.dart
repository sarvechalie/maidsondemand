import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/models/users.dart';
import 'package:shop_app/screens/profile/components/profile_list_view_item.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter_session/flutter_session.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  dynamic screen;
  String name = "";
  String url = "";
  @override
  void initState() {
    super.initState();
    getSession();
    Future.delayed(Duration(milliseconds: 10), () {
      getUser(screen);
    });
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
        name = i.name;
        url = i.url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(url),
                  maxRadius: 52,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Text(
                name,
                style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 15),
              children: <Widget>[
                ProfileListViewItem(
                  icon: 'assets/icons/Account.png',
                  text: 'My Account',
                ),
                ProfileListViewItem(
                  icon: 'assets/icons/Orders.png',
                  text: 'My Orders',
                ),
                ProfileListViewItem(
                  icon: 'assets/icons/Settings.png',
                  text: 'Settings',
                ),
                ProfileListViewItem(
                  icon: 'assets/icons/Contact Us.png',
                  text: 'Contact Us',
                ),
                ProfileListViewItem(
                  icon: 'assets/icons/Card.png',
                  text: 'Payment',
                ),
                ProfileListViewItem(
                  icon: 'assets/icons/Logout.png',
                  text: 'Logout',
                ),
              ],
            ),
          ),
        ))
      ],
    );
  }
}

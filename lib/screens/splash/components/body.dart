import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shop_app/screens/tabs/tabs_screen.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/screens/tabsMaid/tabs_screenMaid.dart';
import 'package:shop_app/screens/tabs_admin/tabs_admin.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  dynamic userId;
  dynamic screen;
  @override
  void initState() {
    super.initState();
    getSession();
    getSession1();
    Future.delayed(const Duration(seconds: 3), () {
      DummyData.orderNumber = 0;
      if (userId != null) {
        if (screen.toString() == "client") {
          Navigator.pushReplacementNamed(context, TabsScreen.routeName);
        } else if (screen.toString() == "maid") {
          Navigator.pushReplacementNamed(context, TabsScreenMaid.routeName);
        } else {
          Navigator.pushReplacementNamed(context, TabsAdmin.routeName);
        }
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  getSession() async {
    dynamic id = await FlutterSession().get('login');
    setState(() {
      userId = id;
    });
  }

  getSession1() async {
    dynamic screenRetrieve = await FlutterSession().get('screen');
    setState(() {
      screen = screenRetrieve;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/Splash Background.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Splash Logo.png',
                width: 150,
                height: 150,
              ),
              Text(
                'Maids on Demand',
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

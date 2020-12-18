import 'package:flutter/material.dart';
import 'package:shop_app/Services/database.dart';

import 'package:shop_app/models/users.dart';
import 'package:shop_app/screens/profile/components/profile_list_view_item.dart';

import 'user_screen_list_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Users> user = [];

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    Future<List<Users>> list = DatabaseFireStore().getUserDetails();
    List<Users> data = await list;
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: user.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: UserDetailListItem(
                        user: user[index],
                      ),
                    );
                  }),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 15),
            children: <Widget>[
              ProfileListViewItem(
                icon: 'assets/icons/Logout.png',
                text: 'Logout',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

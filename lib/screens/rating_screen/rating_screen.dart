import 'package:flutter/material.dart';

import 'components/body.dart';

class RatingScreen extends StatelessWidget {
  static String routeName = "/rating_screen";
  final String maidId;

  const RatingScreen({Key key, this.maidId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Rating'),
        centerTitle: true,
      ),
      body: Body(maidId:maidId),
    );
  }
}

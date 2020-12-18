import 'package:flutter/material.dart';

import 'components/body.dart';

class ReviewScreen extends StatelessWidget {
  static String routeName = "/review_screen";
  final String maidId;

  const ReviewScreen({Key key, this.maidId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Review Maid'),
        centerTitle: true,
      ),
      body: Body(maidId:maidId),
    );
  }
}

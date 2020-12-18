import 'package:flutter/material.dart';

import 'components/body.dart';

class MaidsDetailScreen extends StatelessWidget {
  static String routeName = "/maids_detail.dart";
  final String maidId;

  const MaidsDetailScreen({Key key, this.maidId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text('Maid Details'),
        centerTitle: true,
      ),
      body: Body(maidId: maidId),
    );
  }
}

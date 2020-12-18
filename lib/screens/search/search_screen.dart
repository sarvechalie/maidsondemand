import 'package:flutter/material.dart';

import 'components/body.dart';

class SearchScreen extends StatelessWidget {
  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Body(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentScreen extends StatelessWidget {
  static String routeName = "/payment";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      routes: {
        "/": (_) => new WebviewScaffold(
              url: "https://housekeepingmaidaffordable.com/payment-page/",
              appBar: new AppBar(
                title: new Text("Payment"),
                centerTitle: true,
              ),
            ),
      },
    );
  }
}

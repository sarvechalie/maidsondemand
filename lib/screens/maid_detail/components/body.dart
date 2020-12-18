import 'package:flutter/material.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/models/get_maid.dart';
import 'package:shop_app/models/order.dart';

import 'maids_detail_list_item.dart';

class Body extends StatefulWidget {
  final String maidId;
  const Body({Key key, this.maidId}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(maidId);
}

class _BodyState extends State<Body> {
  final String maidId;
  List<GetMaid> maid = [];

  _BodyState(this.maidId);
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
      getMaidDetails(maidId);
    });
  }

  getMaidDetails(String id) async {
    Future<List<GetMaid>> list = DatabaseFireStore().getMaidDetails(id);
    List<GetMaid> data = await list;
    setState(() {
      maid = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
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
                    itemCount: maid.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: MaidDetailListItem(
                          maid: maid[index],
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

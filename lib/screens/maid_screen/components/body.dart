import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/get_maid.dart';
import 'package:shop_app/screens/maid_screen/components/maid_item.dart';
import 'maid_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<GetMaid> maid = [];

  @override
  void initState() {
    super.initState();
    getMaid();
    //user = DummyData;
  }

  getMaid() async {
    Future<List<GetMaid>> list = DatabaseFireStore().getMaid();
    List<GetMaid> data = await list;
    setState(() {
      maid = data;
    });
  }

  removeMaid(int index) {
    setState(() {
      DatabaseFireStore().deleteMaid(maid[index].id);
      maid.removeAt(index);
    });
  }

  changeMaidStatus(int index) {
    setState(() {
      for (int i = 0; i < maid.length; i++) {
        if (i == index) {
          if (maid[i].booked != true) {
            setState(() {
              maid[i].booked = true;
              DatabaseFireStore().updateMaid(maid[i].id, maid[i].booked);
            });
          } else {
            setState(() {
              maid[i].booked = false;
              DatabaseFireStore().updateMaid(maid[i].id, maid[i].booked);
            });
          }
        }
      }
      getMaid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text('All Maids'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.builder(
                  itemCount: maid.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: MaidItem(
                        maid: maid[index],
                        changeMaidStatus: () => changeMaidStatus(index),
                      ),
                      closeOnScroll: true,
                      secondaryActions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Container(
                            height: double.infinity,
                            child: Card(
                              elevation: 5,
                              shadowColor: kCardBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: IconSlideAction(
                                color: Colors.transparent,
                                icon: Icons.delete,
                                foregroundColor: kPrimaryColor,
                                onTap: () => removeMaid(index),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

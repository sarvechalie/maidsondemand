import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/get_maid.dart';
import 'package:shop_app/screens/maid_detail/maids_detail.dart';
import 'package:shop_app/screens/tabs_admin/tabs_admin.dart';
import 'package:shop_app/screens/update_maid_screen/update_maid_screen.dart';
import 'package:shop_app/size_config.dart';

class MaidItem extends StatefulWidget {
  final GetMaid maid;
  final Function changeMaidStatus;

  const MaidItem({Key key, this.changeMaidStatus, this.maid}) : super(key: key);
  @override
  _MaidItemState createState() => _MaidItemState();
}

class _MaidItemState extends State<MaidItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.maid.booked
          ? EdgeInsets.fromLTRB(5, 2, 5, 2)
          : EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: GestureDetector(
        onTap: widget.changeMaidStatus,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border: widget.maid.booked
                ? Border.all(color: kPrimaryColor, width: 2)
                : Border.all(color: Colors.transparent),
          ),
          child: Card(
            shadowColor: kCardBackgroundColor,
            margin: EdgeInsets.all(2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            elevation: widget.maid.booked ? 0 : 5,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(11),
                vertical: getProportionateScreenHeight(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getProportionateScreenHeight(4)),
                          ImageIcon(
                            AssetImage('assets/icons/maid.png'),
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                      SizedBox(width: getProportionateScreenWidth(8)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: " + widget.maid.name,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(4)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Email: " + widget.maid.email,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(4)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Phone Number: " + widget.maid.phoneNumber,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Country / City: " + widget.maid.city,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Address: " + widget.maid.address,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Category: " + widget.maid.category,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Description: " + widget.maid.description,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(8)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 90,
                                  height: 28,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    color: kPrimaryColor,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateMaidScreen(
                                            userId: widget.maid.id,
                                          ),
                                        ),
                                      ).then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TabsAdmin(
                                              name: "maid",
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 90,
                                  height: 28,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    color: kPrimaryColor,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MaidsDetailScreen(
                                                maidId: widget.maid.id,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

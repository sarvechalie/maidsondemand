import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/get_maid.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/size_config.dart';

class MaidDetailListItem extends StatefulWidget {
  final GetMaid maid;

  const MaidDetailListItem({
    Key key,
    this.maid,
  }) : super(key: key);
  @override
  _MaidDetailListItemState createState() => _MaidDetailListItemState();
}

class _MaidDetailListItemState extends State<MaidDetailListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: double.infinity,
        child: Card(
          shadowColor: kCardBackgroundColor,
//        color: kBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.04,
                vertical: SizeConfig.screenHeight * 0.010),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                widget.maid.name.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text('Email:'),
                              ),
                              Expanded(
                                child: Text(widget.maid.address),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.005,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('City:'),
                              ),
                              Expanded(
                                child: Text(widget.maid.city),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text('Description'),
                              ),
                              Expanded(
                                child: Text(widget.maid.description),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.01,
                          ),

//                        GestureDetector(
//                          onTap: () => null,
//                          child: Text(
//                            'DETAILS',
//                            style: TextStyle(
//                              color: kPrimaryColor,
//                              fontSize: 14,
//                            ),
//                          ),
//                        )
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
    );
  }
}

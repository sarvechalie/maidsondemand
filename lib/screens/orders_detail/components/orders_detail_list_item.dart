import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/size_config.dart';

class OrderDetailListItem extends StatefulWidget {
  final Order order;

  const OrderDetailListItem({
    Key key,
    this.order,
  }) : super(key: key);
  @override
  _OrderDetailListItemState createState() => _OrderDetailListItemState();
}

class _OrderDetailListItemState extends State<OrderDetailListItem> {
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
                                widget.order.name.toString(),
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
                                child: Text('Address:'),
                              ),
                              Expanded(
                                child: Text(widget.order.address),
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
                                child: Text(widget.order.city),
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
                                child: Text('Date:'),
                              ),
                              Expanded(
                                child: Text(widget.order.date),
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
                                child: Text('Time:'),
                              ),
                              Expanded(
                                child: Text(widget.order.time),
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
                                child: Text('Phone Number:'),
                              ),
                              Expanded(
                                child: Text(widget.order.phoneNumber),
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
                                child: Text('Maid Name:'),
                              ),
                              Expanded(
                                child: Text(widget.order.maidName),
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
                                child: Text('Maid Address:'),
                              ),
                              Expanded(
                                child: Text(widget.order.maidAddress),
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
                                child: Text('Maid City:'),
                              ),
                              Expanded(
                                child: Text(widget.order.maidCity),
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
                                child: Text('Maid Category:'),
                              ),
                              Expanded(
                                child: Text(widget.order.maidCategory),
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
                                child: Text('Maid Phone Number:'),
                              ),
                              Expanded(
                                child: Text(widget.order.maidNumber),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.005,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/maid.dart';
import 'package:shop_app/screens/detail_client/detail_client_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductListItem extends StatelessWidget {
  final Maid maid;
  final Function removeFunction;

  const ProductListItem({
    Key key,
    this.maid,
    this.removeFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.routeName),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(8),
          vertical: getProportionateScreenHeight(6),
        ),
        child: Container(
          width: double.infinity,
          child: Card(
            elevation: 5,
            shadowColor: kCardBackgroundColor,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 95,
                  height: 95,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 28,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            //  Navigator.push(
                            //  context,
                            //   MaterialPageRoute(
                            //     builder: (context) => MaidsDetailScreen(
                            //       orderId: widget.order.orderId,
                            //    ),
                            //  ),
                            //  );
                          },
                          child: Text(
                            'Details',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Image.network(
                        maid.url,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(11)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          maid.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: IconButton(
                                onPressed: () {
                                  String phoneno = "tel:" + "+1 480-718-0567";
                                  launch(phoneno);
                                },
                                splashRadius: 20,
                                icon: Icon(
                                  Icons.add_call,
                                  color: kPrimaryColor,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailClientScreen(
                              userId: maid.id,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(0),
                        child: Container(
                          width: 35,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Color.fromRGBO(150, 161, 55, 1),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              VerticalText(),
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: VerticalIcon(),
                              ),
                            ],
                          ),
                        ),
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

  Widget VerticalText() {
    return Wrap(
      direction: Axis.vertical,
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: Text(
            "Book Now",
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget VerticalIcon() {
    return Wrap(
      direction: Axis.vertical,
      children: [
        RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.calendar_today_outlined,
            color: Colors.white,
            size: 17,
          ),
        ),
      ],
    );
  }
}

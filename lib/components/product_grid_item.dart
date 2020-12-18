import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/maid.dart';
import 'package:shop_app/screens/maid_detail/maids_detail.dart';
import 'package:shop_app/screens/rating_screen/rating_screen.dart';
import 'package:shop_app/screens/review_screen/review_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shop_app/screens/detail_client/detail_client_screen.dart';

class ProductGridItem extends StatelessWidget {
  final Maid maid;
  const ProductGridItem({
    Key key,
    this.maid,
  }) : super(key: key);

  calculateRating(){
    if(maid.rating!=null) {
      return maid.rating / maid.counter;
    }
    else{
      return 0.0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.routeName),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(8),
          vertical: getProportionateScreenHeight(6),
        ),
        child: Card(
          elevation: 5,
          shadowColor: kCardBackgroundColor,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2.3,
                child: Container(
                  width: double.infinity,
                  height: 100,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        maid.url,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        maid.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: getProportionateScreenHeight(6)),
                      RatingBar(
                        initialRating: calculateRating(),
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemSize: 20.0,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context,_) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(6)),
                      Row(
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
                                 Navigator.push(
                                 context,
                                  MaterialPageRoute(
                                    builder: (context) => MaidsDetailScreen(
                                      maidId: maid.id,
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
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                String phoneno = "tel:" + "+1 480-718-0567";
                                launch(phoneno);
                              },
                              child: Icon(
                                Icons.add_call,
                                color: kPrimaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(6)),
                      Row(children: [
                        Container(
                          width: 120,
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
                                  builder: (context) => RatingScreen(
                                    maidId: maid.id,
                                 ),
                               ),
                               ).then((value) => calculateRating());
                            },
                            child: Text(
                              'Rating',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: getProportionateScreenHeight(6)),
                      Row(children: [
                        Container(
                          width: 120,
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
                                  builder: (context) => ReviewScreen(
                                    maidId: maid.id,
                                 ),
                               ),
                               );
                            },
                            child: Text(
                              'Give Review',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
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
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(0),
                      child: Container(
                        width: 300,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Color.fromRGBO(206, 162, 101, 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Book Now",
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.5,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white,
                                size: 18.5,
                              ),
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
    );
  }
}

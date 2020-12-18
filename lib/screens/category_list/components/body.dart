import 'package:flutter/material.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/components/product_grid_item.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/components/product_list_item.dart';
import 'package:shop_app/models/maid.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatefulWidget {
  final String name;

  const Body({Key key, this.name}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(name);
}

class _BodyState extends State<Body> {
  final String name;

  _BodyState(this.name);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(11),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(10),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(8),
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),
            Expanded(
                    child: FutureBuilder(
                    future:DummyData.getMaid(name),
                        builder:(BuildContext context, AsyncSnapshot snapshot){
                        if(!snapshot.hasData){
                        return Container(
                        child:Center(
                        child: CircularProgressIndicator(),
                        )
                        );
                        }
                        else {
                          return Container(
                          height: getProportionateScreenHeight(250),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.78,
                            ),
                            itemBuilder: (context, index) {
                              return ProductGridItem(
                                  maid: snapshot.data[index],
                              );
                            },
                          ),

                           );
                        }
                        },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

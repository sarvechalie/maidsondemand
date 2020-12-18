import 'package:flutter/material.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/screens/categories/components/category_list_item.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(11),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getProportionateScreenHeight(50)),
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: getProportionateScreenWidth(8)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Card(
              //         margin: EdgeInsets.all(0),
              //         elevation: 5,
              //         shadowColor: kCardBackgroundColor,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(
              //             Radius.circular(20),
              //           ),
              //         ),
              //         child: SearchTextField(label: 'Search Category'),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: getProportionateScreenHeight(16)),
              GridView.builder(
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 4),
                  shrinkWrap: true,
                  itemCount: DummyData.dummyAllCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryListItem(
                      category: DummyData.dummyAllCategories[index],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

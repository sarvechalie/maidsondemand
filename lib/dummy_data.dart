import 'package:flutter/material.dart';
import 'package:shop_app/models/address.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/order_notification.dart';
import 'package:shop_app/models/payment_card.dart';
import 'package:shop_app/models/promotion_notification.dart';
import 'Services/database.dart';
import 'models/get_maid.dart';
import 'models/maid.dart';
import 'models/product.dart';

class DummyData {

  static List<Category> dummyAllCategories = [
    Category(
        id: 1,
        name: 'Residential Deep Cleaning',
        image: 'assets/images/Residential clean.png'),
    Category(
        id: 2,
        name: 'Commercial Deep Cleaning',
        image: 'assets/images/Commercial clean.jpg'),
    Category(id: 3, name: 'Carpet Cleaning', image: 'assets/images/Carpet.png'),
    Category(
        id: 4,
        name: 'Tile & Grout Deep Cleaning',
        image: 'assets/images/Tile.png'),
    Category(id: 5, name: 'Window Cleaning', image: 'assets/images/window.png'),
    Category(
        id: 6,
        name: 'Oven Deep Clean',
        image: 'assets/images/microwave-oven.jpg'),
    Category(
        id: 7,
        name: 'Refrigerator/Freezer Deep Clean',
        image: 'assets/images/refrigerator.jpg'),
    Category(
        id: 8,
        name: 'Regularly Scheduled Cleaning Service',
        image: 'assets/images/Regulerly Schedule.png'),
    Category(
        id: 9,
        name: 'Maids For Extra Assistance',
        image: 'assets/images/Maids for extra assistance.png'),
  ];
  static Future<List<Maid>> getMaid(String name) async {
    List<Maid> maidList=[];
    List<GetMaid> data= await DatabaseFireStore().getMaid();
      for (GetMaid i in data) {
        if (i.category == name) {
          Maid maid = Maid(
            id: i.id,
            name: i.name,
            url: i.url,
            phoneNumber: i.phoneNumber,
            rating: i.rating,
            counter: i.counter,
          );
          maidList.add(maid);
        }
      }
    return maidList;
  }

  static int orderNumber;

}

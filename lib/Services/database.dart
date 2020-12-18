import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/dummy_data.dart';
import 'package:shop_app/models/get_maid.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/models/reschedule.dart';
import 'package:shop_app/models/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseFireStore {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Clients');
  CollectionReference maids = FirebaseFirestore.instance.collection('Maids');
  CollectionReference orders = FirebaseFirestore.instance.collection('Orders');
  CollectionReference admin = FirebaseFirestore.instance.collection('Admin');
  CollectionReference reviews = FirebaseFirestore.instance.collection('Review');
  CollectionReference schedule =
      FirebaseFirestore.instance.collection('Schedule');
  SharedPreferences prefs;
  Future<void> addUser(String name, String email, String phoneNumber,
      String userId, String url) async {
    return users.doc(userId).set({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "url": url,
    });
  }

  Future<void> addMaid(
      String name,
      String email,
      String phoneNumber,
      String userId,
      String address,
      String city,
      String category,
      String url,
      String description) async {
    return maids.doc(userId).set({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address,
      "city": city,
      "category": category,
      "url": url,
      "description": description,
      "working": false,
      "active": true,
    });
  }
  Future<void> addreview(String review,String maidId) async {
    return reviews.doc(_auth.currentUser.uid).set({
      "maidId":maidId,
      "review":review,
    });
  }
  Future<List<Users>> getUser(dynamic screen) async {
    List<Users> getUser = [];
    if (screen != "maid") {
      var response = await users.doc(_auth.currentUser.uid).get();
      Map<String, dynamic> map = response.data();
      getUser.add(Users(
          name: map['name'],
          email: map['email'],
          phoneNumber: map['phoneNumber'],
          url: map['url']));
    } else {
      var response = await maids.doc(_auth.currentUser.uid).get();
      Map<String, dynamic> map = response.data();
      getUser.add(Users(
          name: map['name'],
          email: map['email'],
          phoneNumber: map['phoneNumber'],
          url: map['url']));
    }
    return getUser;
  }

  Future<List<Users>> getUserDetails() async {
    List<Users> getUsers = [];
    QuerySnapshot querySnapshot = await users.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      Map<String, dynamic> map = a.data();
      getUsers.add(Users(
          name: map['name'],
          email: map['email'],
          phoneNumber: map['phoneNumber']));
    }
    return getUsers;
  }

  Future<bool> userCheck(String email) async {
    bool found = false;
    QuerySnapshot querySnapshot = await users.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      Map<String, dynamic> map = a.data();
      if (map['email'] == email) {
        found = true;
        break;
      }
    }
    return found;
  }

  Future<bool> maidCheck(String email) async {
    bool found = false;
    QuerySnapshot querySnapshot = await maids.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      Map<String, dynamic> map = a.data();
      if (map['email'] == email) {
        found = true;
        break;
      }
    }
    return found;
  }

  Future<List<GetMaid>> getMaid() async {
    List<GetMaid> getMaid = [];
    QuerySnapshot querySnapshot = await maids.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      Map<String, dynamic> map = a.data();
      if (map['active'] == true) {
        getMaid.add(GetMaid(
          id: a.id,
          name: map['name'],
          email: map['email'],
          phoneNumber: map['phoneNumber'],
          address: map['address'],
          category: map['category'],
          city: map['city'],
          description: map['description'],
          url: map['url'],
          booked: map['working'],
          active: map['active'],
          rating: map['rating'],
          counter: map['counter']
        ));
      }
    }
    return getMaid;
  }
  Future<List<GetMaid>> getMaidDetails(String id) async {
    List<GetMaid> getMaid = [];
    var response = await maids.doc(id).get();
    Map<String, dynamic> map = response.data();
    getMaid.add(GetMaid(
      id: id,
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      category: map['category'],
      city: map['city'],
      description: map['description'],
      url: map['url'],
      booked: map['working'],
      active: map['active'],
    ));

    return getMaid;
  }
  Future<List<GetMaid>> getMaidForUpdation(String userId) async {
    var response = await maids.doc(userId).get();
    List<GetMaid> getMaid = [];
    Map<String, dynamic> map = response.data();
    getMaid.add(GetMaid(
        id: userId,
        name: map['name'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        address: map['address'],
        category: map['category'],
        city: map['city'],
        description: map['description'],
        booked: map['working']));
    return getMaid;
  }

  Future<void> updateUser(
      String name, String email, String phoneNumber, String url) async {
    return users.doc(_auth.currentUser.uid).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "url": url,
    });
  }

  Future<void> updateMaids(
      String name, String email, String phoneNumber, String url) async {
    return maids.doc(_auth.currentUser.uid).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "url": url,
    });
  }

  Future<void> updateMaid(String userId, bool working) async {
    return maids.doc(userId).update({
      "working": working,
    });
  }
  Future<void> addMaidRating(String rating, String maidId) async {
    int counter;
    int initialRating;
    var response = await maids.doc(maidId).get();
    Map<String, dynamic> map = response.data();
    if(map['counter']==null && map['rating']==null){
      counter=1;
      initialRating=int.parse(rating);
    }
    else{
      counter=counter+1;
      initialRating+=int.parse(rating);
    }
    return maids.doc(maidId).update({
      "rating": initialRating,
      "counter":counter,
    });
  }
  Future<void> updationMaid(String name, String email, String phoneNumber,
      String address, String city, String category, String description,String userId,) async {
    return maids.doc(userId).update({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address,
      "city": city,
      "category": category,
      "description":description
    });
  }

  Future<void> deleteMaid(String userId) async {
    return maids.doc(userId).update({
      "active": false,
    });
  }

  Future<void> bookMaid(String name, String city, String phoneNumber,
      String address, String date, String time, String maidId) async {
    String id = orders.doc().id;
    return orders.doc(id).set({
      "name": name,
      "city": city,
      "phoneNumber": phoneNumber,
      "address": address,
      "date": date,
      "time": time,
      "clientId": _auth.currentUser.uid,
      "maidId": maidId,
      "status": "Pending",
    });
  }

  Future<List<Order>> getOrders(dynamic id, dynamic screen) async {
    List<Order> getOrders = [];
    if (screen.toString() != "admin") {
      if (screen.toString() != "maid") {
        QuerySnapshot querySnapshot = await orders.get();
        for (int i = 0; i < querySnapshot.docs.length; i++) {
          var a = querySnapshot.docs[i];
          Map<String, dynamic> map = a.data();
          if (map['clientId'] == _auth.currentUser.uid) {
            String maidId = map['maidId'].toString();
            var response = await maids.doc(maidId).get();
            Map<String, dynamic> maidmap = response.data();
            getOrders.add(Order(
              orderId: a.id,
              number: DummyData.orderNumber += 1,
              date: map['date'],
              time: map['time'],
            ));
          }
        }
      } else {
        QuerySnapshot querySnapshot = await orders.get();
        for (int i = 0; i < querySnapshot.docs.length; i++) {
          var a = querySnapshot.docs[i];
          Map<String, dynamic> map = a.data();
          if (map['maidId'] == _auth.currentUser.uid) {
            String maidId = map['maidId'].toString();
            var response = await maids.doc(maidId).get();
            Map<String, dynamic> maidmap = response.data();
            getOrders.add(Order(
              orderId: a.id,
              number: DummyData.orderNumber += 1,
              date: map['date'],
              time: map['time'],
            ));
          }
        }
      }
    } else {
      QuerySnapshot querySnapshot = await orders.get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        Map<String, dynamic> map = a.data();
        String maidId = map['maidId'].toString();
        var response = await maids.doc(maidId).get();
        Map<String, dynamic> maidmap = response.data();
        getOrders.add(Order(
          orderId: a.id,
          number: DummyData.orderNumber += 1,
          date: map['date'],
          time: map['time'],
        ));
      }
    }
    return getOrders;
  }

  Future<List<Order>> getDetailOrders(String orderId) async {
    List<Order> getOrderDetails = [];
    var response = await orders.doc(orderId).get();
    Map<String, dynamic> map = response.data();
    String maidId = map['maidId'].toString();
    var response_maid = await maids.doc(maidId).get();
    Map<String, dynamic> maidmap = response_maid.data();
    getOrderDetails.add(Order(
      orderId: orderId,
      number: DummyData.orderNumber += 1,
      date: map['date'],
      time: map['time'],
      name: map['name'],
      address: map['address'],
      city: map['city'],
      phoneNumber: map['phoneNumber'],
      maidName: maidmap['name'],
      maidAddress: maidmap['address'],
      maidCity: maidmap['city'],
      maidNumber: maidmap['phoneNumber'],
      maidCategory: maidmap['category'],
    ));
    return getOrderDetails;
  }

  Future<void> updateOrder(String date, String time, String orderId) async {
    return orders.doc(orderId).update({
      "date": date,
      "time": time,
    });
  }

  Future<void> updateScheduleOrder(String orderId) async {
    return schedule.doc(orderId).update({"approved": true});
  }

  Future<void> scheduleOrder(
      String date, String time, String orderId, int orderNumber) async {
    return schedule.doc(orderId).set({
      "date": date,
      "time": time,
      "orderNumber": orderNumber,
      "approved": false
    });
  }

  Future<List<RescheduleOrder>> getRescheduleOrders() async {
    List<RescheduleOrder> getRescheduleDetails = [];
    QuerySnapshot querySnapshot = await schedule.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      Map<String, dynamic> map = a.data();
      if (map["approved"] == false) {
        getRescheduleDetails.add(RescheduleOrder(
            id: a.id,
            number: map['orderNumber'],
            date: map['date'],
            time: map['time'],
            approved: map['approved']));
      }
    }
    return getRescheduleDetails;
  }

  Future<void> deleteOrders(String orderId) async {
    return orders.doc(orderId).delete();
  }

  Future<void> deleteRescheduleOrders(String orderId) async {
    return schedule.doc(orderId).delete();
  }

  Future addAdmin() async {
    String adminId;
    final QuerySnapshot resultUser = await admin.get();
    final List<DocumentSnapshot> documents = resultUser.docs;
    adminId = documents[0].id;
    prefs = await SharedPreferences.getInstance();
    if (documents.length == 0) {
      String id = admin.doc().id;
      // Update data to server if new user
      admin.doc(id).set({
        'nickname': 'admin',
        'photoUrl': null,
        'id': id,
        'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
        'chattingWith': null
      });
      // Write data to local
      await prefs.setString('id', id);
      await prefs.setString('nickname', 'admin');
      await prefs.setString('photoUrl', null);
      adminId = id;
    } else {
      // Write data to local
      await prefs.setString('id', documents[0].data()['id']);
      await prefs.setString('nickname', documents[0].data()['nickname']);
      await prefs.setString('photoUrl', documents[0].data()['photoUrl']);
      await prefs.setString('aboutMe', documents[0].data()['aboutMe']);
    }
    return adminId;
  }
}

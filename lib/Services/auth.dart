import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/Services/database.dart';
import 'package:shop_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Clients');
  CollectionReference maids = FirebaseFirestore.instance.collection('Maids');
  SharedPreferences prefs;
  User currentUser;
  UserId _userFromFirebaseUser(User user) {
    return user != null ? UserId(id: user.uid) : null;
  }

  Future registration(String name, String email, String password,
      String phoneNumber, String url) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await user.sendEmailVerification();
      await DatabaseFireStore()
          .addUser(name, email, phoneNumber, user.uid, url);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Password is weak";
      } else if (e.code == 'email-already-in-use') {
        return "Email address is already in use";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future registrationMaid(
      String name,
      String email,
      String password,
      String phoneNumber,
      String address,
      String city,
      String category,
      String url,
      String description) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await user.sendEmailVerification();
      await DatabaseFireStore().addMaid(name, email, phoneNumber, user.uid,
          address, city, category, url, description);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Password is weak";
      } else if (e.code == 'email-already-in-use') {
        return "Email address is already in use";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future login(String email, String password, String type) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      final QuerySnapshot resultUser = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> documents = resultUser.docs;
      print(documents.length);
      prefs = await SharedPreferences.getInstance();
      if (documents.length == 0) {
        // Update data to server if new user
        var response;
        Map<String, dynamic> map;
        if (type == "Client") {
          response = await users.doc(user.uid).get();
          map = response.data();
        }
        if (type == "Maid") {
          response = await maids.doc(user.uid).get();
          map = response.data();
        }
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'nickname': map['name'],
          'photoUrl': null,
          'id': user.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        // Write data to local
        currentUser = user;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', map['name']);
        await prefs.setString('photoUrl', null);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0].data()['id']);
        await prefs.setString('nickname', documents[0].data()['nickname']);
        await prefs.setString('photoUrl', documents[0].data()['photoUrl']);
        await prefs.setString('aboutMe', documents[0].data()['aboutMe']);
      }
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future passwordReset(String email) async {
    String result;
    QuerySnapshot querySnapshot = await users.get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      Map<String, dynamic> map = a.data();
      print(map['email']);
      if (map['email'] == email) {
        await _auth.sendPasswordResetEmail(email: email);
        result = "Succeeded";
        break;
      } else {
        result = "No user found for that email.";
      }
    }
    return result;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}

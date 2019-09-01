import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_gorgeous_login/core/models/user.dart';
import 'package:the_gorgeous_login/firebase/firebase.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject;

class AuthenticationService {
  final Firebase firebase;

  AuthenticationService({this.firebase});
  BehaviorSubject<User> userController = BehaviorSubject<User>();

  Stream<User> get userStream => userController.stream;

  User get user => userController.value;

  Future<bool> login(String email, String password) async {
    var doc = await firebase.usersCollection().document(email).get();
    User user = User.fromMap(doc.data);
    if (doc.exists) {
      //Check Password
      if (password == doc.data["passkey"]) {
        userController.add(user);
      }
    }
    return doc.exists;
  }

  DocumentReference userDocument([email]) {
    return firebase.usersCollection().document(email ?? user.email);
  }

  Future<dynamic> register(Map data) async {
    Map<String, dynamic> newData = Map<String, dynamic>.from(data);
    //Check if User Already Existing
    DocumentSnapshot doc =
        await firebase.usersCollection().document(data['email']).get();
    if (doc.exists) {
      throw "Email Already exists";
    }
    /*DocumentSnapshot doc = await Firestore.instance
        .collection('users')
//        .document(data['email'])
//        .get();
    if (doc.exists) {
      //Email Already Exist
      return ResultModel()..message = "Email already exist";
    }
*/
    await userDocument(data['email']).setData(newData);
    return true;
  }

  dispose() {
    userController.close();
  }
}

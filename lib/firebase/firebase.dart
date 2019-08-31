import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { Success, Error, Warning, Information }

class ResultModel {
  MessageType type;
  String message;
}

class Firebase {
  CollectionReference usersCollection() {
    return Firestore.instance.collection('users');
  }

  //Login
//  Future<ResultModel> login(String email, String password) async {
//    DocumentSnapshot doc = await Firestore.instance.collection('users');
  //Check If User Exist
//  }

  //Sign Up
  Future<ResultModel> signup(Map data) async {
    ResultModel result;
    //Check if Password and Confirm Password are the same
    if (data['password'] != data['confirmPassword']) {
      return ResultModel()..message = "Password does not match";
    }
    //Check if User Already Existing
    DocumentSnapshot doc = await Firestore.instance
        .collection('users')
        .document(data['email'])
        .get();
    if (doc.exists) {
      //Email Already Exist
      return ResultModel()..message = "Email already exist";
    }

    await Firestore.instance
        .collection('users')
        .document(data['email'])
        .setData(data, merge: true);

    result = ResultModel()..message = "Registration Complete";

    return result;
  }
}

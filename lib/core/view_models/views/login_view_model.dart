import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/core/services/authentication_service.dart';

import '../base_model.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService authenticationService;
  bool passwordObscure = true;
  LoginViewModel({@required this.authenticationService});

  Future<bool> login(String email, String password) async {
    setBusy(true);
    try {
      var success = await authenticationService.login(email, password);
      setBusy(false);
      return success;
    } catch (e) {
      setBusy(false);
      return false;
    
    }
  }

  togglePasswordObscure() {
    passwordObscure = !passwordObscure;
    notifyListeners();
  }
}

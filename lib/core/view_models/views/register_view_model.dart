import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/core/services/authentication_service.dart';
import 'package:the_gorgeous_login/utils/show_snack_bar.dart';

import '../base_model.dart';

class RegisterViewModel extends BaseModel {
  AuthenticationService authenticationService;
  bool passwordObscure = false;

  RegisterViewModel({@required this.authenticationService});

  Future<bool> register(Map data) async {
    setBusy(true);
    var success;
    try {
      success = await authenticationService.register(data);
      setBusy(false);
    } catch (e) {
      showSnackBar("Can't Register");
      success = false;
    }
    return success;
  }

  togglePasswordObscure() {
    passwordObscure = !passwordObscure;
    notifyListeners();
  }
}

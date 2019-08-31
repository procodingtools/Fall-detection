import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/core/services/scaffold_service.dart';
import 'package:the_gorgeous_login/locator_setup.dart';
import '../style/theme.dart' as Theme;
import '../locator_setup.dart';

showSnackBar(String value) {
  ScaffoldService scaffoldService = locator<ScaffoldService>();
  FocusScope.of(scaffoldService.context).requestFocus(new FocusNode());
  scaffoldService.removeCurrentSnackBar();
  scaffoldService.showSnackBar(new Text(
    value,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontFamily: "WorkSansSemiBold",
    ),
  )
      /*new SnackBar(
      content: ,
      backgroundColor: Theme.Colors.loginButtonGradientEnd,
      duration: Duration(seconds: 3),
    ),*/
      );
}

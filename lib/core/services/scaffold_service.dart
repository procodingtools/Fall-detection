import 'package:flutter/material.dart';
import 'package:flashbar/flashbar.dart';
import '../../style/theme.dart' as Theme;

class ScaffoldService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => navigatorKey.currentState.overlay.context;

  ScaffoldState get scaffoldState => Scaffold.of(context);
  showSnackBar(Widget child) {
    showFlashbar(
      context: context,
      duration: Duration(milliseconds: 3000),
      builder: (context, controller) {
        return Flashbar(
          controller: controller,
          message: child,
          backgroundColor: Theme.Colors.loginButtonGradientEnd,
          boxShadows: kElevationToShadow[4],
        );
      },
    );
  }

  removeCurrentSnackBar(
      {SnackBarClosedReason reason = SnackBarClosedReason.remove}) {
//    scaffoldState.removeCurrentSnackBar(reason: reason);
  }
}

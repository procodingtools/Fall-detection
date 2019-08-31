import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/provider_setup.dart';
import 'package:the_gorgeous_login/ui/router.dart';
import 'package:the_gorgeous_login/locator_setup.dart';

import 'core/constants/app_contstants.dart';
import 'core/services/scaffold_service.dart';

void main() {
  setupLocator();
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: new MaterialApp(
        navigatorKey: locator<ScaffoldService>().navigatorKey,
        title: 'FallDetection',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.Login,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

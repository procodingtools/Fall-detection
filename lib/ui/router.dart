import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gorgeous_login/core/constants/app_contstants.dart';
import 'package:the_gorgeous_login/core/view_models/views/contacts_view_model.dart';
import 'package:the_gorgeous_login/ui/views/add_contacts_view.dart';
import 'package:the_gorgeous_login/ui/views/auth_view.dart';
import 'package:the_gorgeous_login/ui/views/contacts_view.dart';
import 'package:the_gorgeous_login/ui/views/home_view.dart';
import 'package:the_gorgeous_login/ui/views/tug_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.TUG:
        return MaterialPageRoute(builder: (_) => TUGView());
      case Routes.contacts:
        return MaterialPageRoute(builder: (_) => ContactsView());
      case Routes.AddContacts:
        return MaterialPageRoute(builder: (_) => AddContactsView());
      case Routes.Login:
        return MaterialPageRoute(builder: (_) => AuthView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

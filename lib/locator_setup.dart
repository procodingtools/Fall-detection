import 'package:get_it/get_it.dart';
import 'package:the_gorgeous_login/core/services/scaffold_service.dart';

GetIt locator = GetIt();

setupLocator() {
  locator.registerSingleton(ScaffoldService());
}

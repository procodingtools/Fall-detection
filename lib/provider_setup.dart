import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/core/services/contacts_service.dart';
import 'package:the_gorgeous_login/firebase/firebase.dart';

import 'core/models/user.dart';
import 'core/services/authentication_service.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Firebase())
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Firebase, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(firebase: api),
  ),
  ProxyProvider<Firebase, ContactsService>(
    builder: (context, firebase, contactsService) => ContactsService(
      firebase: firebase,
      authenticationService: Provider.of<AuthenticationService>(context),
    ),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    initialData: User(),
    builder: (context) =>
        Provider.of<AuthenticationService>(context, listen: false).userStream,
  ),
];

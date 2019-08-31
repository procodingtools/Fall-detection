import 'package:the_gorgeous_login/core/models/contact.dart';
import 'package:the_gorgeous_login/core/services/contacts_service.dart';
import 'package:the_gorgeous_login/core/view_models/base_model.dart';

class AddContactViewModel extends BaseModel {
  final ContactsService contactsService;

  AddContactViewModel(this.contactsService);

  add(List<Contact> contacts) async {
    setBusy(true);
    contactsService.addContacts(contacts);
    setBusy(false);
  }
}

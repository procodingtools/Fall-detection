import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_gorgeous_login/core/models/contact.dart';
import 'package:the_gorgeous_login/core/services/contacts_service.dart';
import 'package:the_gorgeous_login/core/view_models/base_model.dart';

class ContactsViewModel extends BaseModel {
  final ContactsService contactsService;
  List<Contact> contacts = [];

  ContactsViewModel({this.contactsService}) {
    fetchContacts();
  }

  fetchContacts() {
    return contactsService.fetchContacts();
  }
}

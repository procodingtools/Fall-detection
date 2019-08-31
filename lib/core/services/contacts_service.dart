import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_gorgeous_login/core/models/contact.dart';
import 'package:the_gorgeous_login/core/services/authentication_service.dart';
import 'package:the_gorgeous_login/firebase/firebase.dart';

class ContactsService {
  final AuthenticationService authenticationService;
  final Firebase firebase;

  ContactsService({this.authenticationService, this.firebase});

  CollectionReference contactsCollection() {
    return authenticationService.userDocument().collection('contacts');
  }

  addContact(Contact contact) async {
    await contactsCollection().add(contact.toMap());
  }

  addContacts(List<Contact> contacts) {
    contacts.forEach((contact) async => await addContact(contact));
    return;
  }

  Stream<QuerySnapshot> fetchContacts() {
    return contactsCollection().snapshots();
  }
}

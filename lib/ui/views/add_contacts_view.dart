import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/core/models/contact.dart';
import 'package:the_gorgeous_login/core/services/contacts_service.dart';
import 'package:the_gorgeous_login/core/view_models/views/add_contact_view_model.dart';
import 'package:the_gorgeous_login/ui/widgets/base_widget.dart';
import 'package:the_gorgeous_login/ui/widgets/button.dart';
import 'package:the_gorgeous_login/ui/widgets/input.dart';
import 'package:url_launcher/url_launcher.dart';

class AddContactsView extends StatefulWidget {
  @override
  _AddContactsViewState createState() => _AddContactsViewState();
}

class _AddContactsViewState extends State<AddContactsView> {
  List<TextEditingController> _contactsNames = [];

  List<TextEditingController> _contactsEmails = [];

  List<Contact> mapControllers() {
    List<Contact> contacts = [];
    _contactsNames.asMap().forEach((index, nameController) {
      if (nameController.text.length < 1) return;
      Contact contact = Contact(
        name: nameController.text,
        email: _contactsEmails[index].text,
      );
      contacts.add(contact);
    });
    return contacts;
  }

  initState() {
    for (int i = 0; i <= 4; i++) {
      _contactsNames.add(TextEditingController());
      _contactsEmails.add(TextEditingController());
    }
    super.initState();
  }

  _buildContact(number, index) {
    return Column(
      children: <Widget>[
        Input(
          hintText: '$number Person Name',
          controller: _contactsNames[index],
        ),
        Input(
          hintText: '$number Person Email Address',
          controller: _contactsEmails[index],
          keyboardType: TextInputType.emailAddress,
          bottom: false,
        ),
        SizedBox(
          height: 10,
        ),
        Button(
          label: 'Text Email for test',
          onPressed: () async {
            final url =
                'mailto:${_contactsEmails[index].text}?subject=Test Message';
            if (await canLaunch(url)) {
              await launch(url);
            }
          },
        ),
      ],
    );
  }

  Widget _buildBody(AddContactViewModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contacts'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              _buildContact('First', 0),
              _buildContact('Second', 1),
              _buildContact('Third', 2),
              _buildContact('Fourth', 3),
              _buildContact('Fifth', 4),
              SizedBox(
                height: 30,
              ),
              model.busy
                  ? CircularProgressIndicator()
                  : Button(
                      label: 'Save',
                      onPressed: () async {
                        model.add(mapControllers());
                        Navigator.pop(context);
                      },
                    ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: AddContactViewModel(Provider.of<ContactsService>(context)),
      builder:
          (BuildContext context, AddContactViewModel model, Widget child) =>
              _buildBody(model),
    );
  }
}

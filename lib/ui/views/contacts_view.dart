import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_gorgeous_login/core/services/contacts_service.dart';
import 'package:the_gorgeous_login/core/view_models/views/contacts_view_model.dart';
import 'package:the_gorgeous_login/ui/widgets/base_widget.dart';

class ContactsView extends StatelessWidget {
  Widget _buildListItem(DocumentSnapshot item) {
    return ListTile(
      title: Text(item['name']),
      subtitle: Text(item['phone']),
    );
  }

  Widget _buildLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildList(context, List data) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          _buildListItem(data[index]),
      itemCount: data.length,
    );
  }

  Widget _buildBody(context) {
    return BaseWidget(
      model: ContactsViewModel(
          contactsService: Provider.of<ContactsService>(context)),
      builder: (BuildContext context, ContactsViewModel model, Widget child) =>
          StreamBuilder<QuerySnapshot>(
        stream: model.fetchContacts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return _buildLoading();
          print(snapshot.data.documents);
          return _buildList(context, snapshot.data.documents);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: _buildBody(context),
    );
  }
}

class Contact {
  String name;
  String phone;

  Contact({this.name, this.phone});

  Contact.fromMap(Map data)
      : name = data['name'],
        phone = data['phone'];

  Map<String, dynamic> toMap() {
    return {'name': name, 'phone': phone};
  }
}

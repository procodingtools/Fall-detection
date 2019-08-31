class Contact {
  final String name;
  final String email;

  Contact({this.name, this.email});

  Contact.fromMap(Map data)
      : name = data['name'],
        email = data['email'];

  Map<String, String> toMap() {
    return {'name': name, 'email': email};
  }
}

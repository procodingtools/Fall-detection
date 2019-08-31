class User {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String birthDate;
  final String height;
  final String weight;

  User(
      {this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.birthDate,
      this.height,
      this.weight});

  User.fromMap(Map<String, dynamic> data)
      : firstName = data['firstName'],
        lastName = data['lastName'],
        username = data['username'],
        email = data['email'],
        birthDate = data['birthDate'],
        height = data['height'],
        weight = data['weight'];

  String get name => '$firstName $lastName';
}

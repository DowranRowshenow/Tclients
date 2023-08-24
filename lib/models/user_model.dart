class User {
  final int id;
  final String name;
  final String number;
  final String birth;
  final String address;
  final String passport;

  const User({
    required this.id,
    required this.name,
    required this.number,
    required this.birth,
    required this.address,
    required this.passport,
  });

  factory User.toUser(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      number: map['number'],
      birth: map['birth'],
      address: map['address'],
      passport: map['passport'],
    );
  }

  factory User.defaultUser() {
    return const User(
      id: 0,
      name: 'name',
      number: 'number',
      birth: 'birth',
      address: 'address',
      passport: 'passport',
    );
  }

  @override
  String toString() {
    return "Id: $id \nNumber: $number \nName: $name \nBirth: $birth \nAddress: $address \nPassport: $passport";
  }
}

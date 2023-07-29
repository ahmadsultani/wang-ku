class Profile {
  final String name;
  final String email;
  final String number;
  final DateTime birthdate;

  Profile({
    required this.name,
    required this.email,
    required this.number,
    required this.birthdate,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      email: json['email'],
      number: json['phone_number'],
      birthdate:
          DateTime.fromMillisecondsSinceEpoch((json['birth_date'] as int)),
    );
  }
}

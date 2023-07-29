class Profile {
  final String name;
  final String email;
  final String number;
  final DateTime birthdate;
  int lendTotal;
  int lendLimit;

  Profile({
    required this.name,
    required this.email,
    required this.number,
    required this.birthdate,
    required this.lendTotal,
    required this.lendLimit,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      email: json['email'],
      number: json['phone_number'],
      birthdate:
          DateTime.fromMillisecondsSinceEpoch((json['birth_date'] as int)),
      lendLimit: 0,
      lendTotal: 0,
    );
  }
}

class User {
  final String id;
  final String email;
  final String phoneNumber;
  final BigInt birthdate;
  final String gender;

  const User({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.birthdate,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      birthdate: json['birthdate'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emai': email,
      'phoneNumber': phoneNumber,
      'birthdate': birthdate,
      'gender': gender,
    };
  }
}

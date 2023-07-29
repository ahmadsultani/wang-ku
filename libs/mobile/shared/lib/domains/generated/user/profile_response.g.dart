// To parse this JSON data, do
//
//     final profileResponse = profileResponseFromJson(jsonString);

import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  ProfileResponse({
    required this.data,
  });

  Data data;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.business,
    required this.user,
  });

  Business? business;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        business: json["business"] == null
            ? null
            : Business.fromJson(json["business"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "business": business == null ? null : business.toJson(),
        "user": user.toJson(),
      };
}

class Business {
  Business({
    required this.address,
    required this.category,
    required this.createdAt,
    required this.id,
    required this.lendLimit,
    required this.monthlyIncome,
    required this.monthlySpending,
    required this.name,
    required this.nib,
    required this.npwp,
    required this.phoneNumber,
    required this.updatedAt,
    required this.userId,
  });

  String address;
  String category;
  int createdAt;
  String id;
  double? lendLimit;
  double? monthlyIncome;
  double? monthlySpending;
  String name;
  String nib;
  String npwp;
  String? phoneNumber;
  int updatedAt;
  String userId;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        address: json["address"],
        category: json["category"],
        createdAt: json["created_at"],
        id: json["id"],
        lendLimit:
            json["lend_limit"] == null ? null : json["lend_limit"].toDouble(),
        monthlyIncome: json["monthly_income"] == null
            ? null
            : json["monthly_income"].toDouble(),
        monthlySpending: json["monthly_spending"] == null
            ? null
            : json["monthly_spending"].toDouble(),
        name: json["name"],
        nib: json["nib"],
        npwp: json["npwp"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "category": category,
        "created_at": createdAt,
        "id": id,
        "lend_limit": lendLimit == null ? null : lendLimit,
        "monthly_income": monthlyIncome == null ? null : monthlyIncome,
        "monthly_spending": monthlySpending == null ? null : monthlySpending,
        "name": name,
        "nib": nib,
        "npwp": npwp,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "updated_at": updatedAt,
        "user_id": userId,
      };
}

class User {
  User({
    required this.birthDate,
    required this.email,
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  int birthDate;
  String email;
  String id;
  String name;
  String? phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
        birthDate: json["birth_date"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "birth_date": birthDate,
        "email": email,
        "id": id,
        "name": name,
        "phone_number": phoneNumber,
      };
}

// To parse this JSON data, do
//
//     final readResponse = readResponseFromJson(jsonString);

import 'dart:convert';

ReadResponse readResponseFromJson(String str) =>
    ReadResponse.fromJson(json.decode(str));

String readResponseToJson(ReadResponse data) => json.encode(data.toJson());

class ReadResponse {
  ReadResponse({
    required this.data,
  });

  Data data;

  factory ReadResponse.fromJson(Map<String, dynamic> json) => ReadResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.business,
    required this.lastLendStatus,
    required this.lendLimit,
    required this.lendedTotal,
    required this.monthlyIncome,
    required this.monthlySpending,
    required this.userVerification,
  });

  Business? business;
  String lastLendStatus;
  double? lendLimit;
  double lendedTotal;
  double? monthlyIncome;
  double? monthlySpending;
  UserVerification? userVerification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        business: json["business"] == null
            ? null
            : Business.fromJson(json["business"]),
        lastLendStatus: json["last_lend_status"],
        lendLimit: json["lend_limit"].toDouble(),
        lendedTotal: json["lended_total"].toDouble(),
        monthlyIncome: json["monthly_income"].toDouble(),
        monthlySpending: json["monthly_spending"].toDouble(),
        userVerification: json["user_verification"] == null
            ? null
            : UserVerification.fromJson(json["user_verification"]),
      );

  Map<String, dynamic> toJson() => {
        "business": business == null ? null : business.toJson(),
        "last_lend_status": lastLendStatus,
        "lend_limit": lendLimit,
        "lended_total": lendedTotal,
        "monthly_income": monthlyIncome,
        "monthly_spending": monthlySpending,
        "user_verification":
            userVerification == null ? null : userVerification.toJson(),
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

class UserVerification {
  UserVerification({
    required this.birthPlace,
    required this.createdAt,
    required this.id,
    required this.nik,
    required this.picture,
    required this.updatedAt,
    required this.userId,
  });

  String birthPlace;
  int createdAt;
  String id;
  String nik;
  String? picture;
  int updatedAt;
  String userId;

  factory UserVerification.fromJson(Map<String, dynamic> json) =>
      UserVerification(
        birthPlace: json["birth_place"],
        createdAt: json["created_at"],
        id: json["id"],
        nik: json["nik"],
        picture: json["picture"] == null ? null : json["picture"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "birth_place": birthPlace,
        "created_at": createdAt,
        "id": id,
        "nik": nik,
        "picture": picture == null ? null : picture,
        "updated_at": updatedAt,
        "user_id": userId,
      };
}

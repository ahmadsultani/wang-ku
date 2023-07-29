// To parse this JSON data, do
//
//     final createResponse = createResponseFromJson(jsonString);

import 'dart:convert';

CreateResponse createResponseFromJson(String str) =>
    CreateResponse.fromJson(json.decode(str));

String createResponseToJson(CreateResponse data) => json.encode(data.toJson());

class CreateResponse {
  CreateResponse({
    required this.data,
  });

  Data data;

  factory CreateResponse.fromJson(Map<String, dynamic> json) => CreateResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
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
    required this.userEmail,
    required this.userId,
    required this.userName,
    required this.userPhoneNumber,
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
  String userEmail;
  String userId;
  String userName;
  String userPhoneNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        userEmail: json["user_email"],
        userId: json["user_id"],
        userName: json["user_name"],
        userPhoneNumber: json["user_phone_number"],
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
        "user_email": userEmail,
        "user_id": userId,
        "user_name": userName,
        "user_phone_number": userPhoneNumber,
      };
}

// To parse this JSON data, do
//
//     final createBody = createBodyFromJson(jsonString);

import 'dart:convert';

CreateBody createBodyFromJson(String str) =>
    CreateBody.fromJson(json.decode(str));

String createBodyToJson(CreateBody data) => json.encode(data.toJson());

class CreateBody {
  CreateBody({
    required this.address,
    required this.category,
    required this.lendLimit,
    required this.monthlyIncome,
    required this.monthlySpending,
    required this.name,
    required this.nib,
    required this.npwp,
    required this.phoneNumber,
  });

  String address;
  String category;
  double? lendLimit;
  double? monthlyIncome;
  double? monthlySpending;
  String name;
  String nib;
  String npwp;
  String? phoneNumber;

  factory CreateBody.fromJson(Map<String, dynamic> json) => CreateBody(
        address: json["address"],
        category: json["category"],
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
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "category": category,
        "lend_limit": lendLimit == null ? null : lendLimit,
        "monthly_income": monthlyIncome == null ? null : monthlyIncome,
        "monthly_spending": monthlySpending == null ? null : monthlySpending,
        "name": name,
        "nib": nib,
        "npwp": npwp,
        "phone_number": phoneNumber == null ? null : phoneNumber,
      };
}

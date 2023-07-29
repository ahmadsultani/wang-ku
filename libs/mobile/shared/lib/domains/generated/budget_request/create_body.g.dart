// To parse this JSON data, do
//
//     final createBody = createBodyFromJson(jsonString);

import 'dart:convert';

CreateBody createBodyFromJson(String str) =>
    CreateBody.fromJson(json.decode(str));

String createBodyToJson(CreateBody data) => json.encode(data.toJson());

class CreateBody {
  CreateBody({
    required this.requestBudget,
  });

  double requestBudget;

  factory CreateBody.fromJson(Map<String, dynamic> json) => CreateBody(
        requestBudget: json["request_budget"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "request_budget": requestBudget,
      };
}

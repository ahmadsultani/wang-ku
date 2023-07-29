// To parse this JSON data, do
//
//     final readmanyResponse = readmanyResponseFromJson(jsonString);

import 'dart:convert';

ReadmanyResponse readmanyResponseFromJson(String str) =>
    ReadmanyResponse.fromJson(json.decode(str));

String readmanyResponseToJson(ReadmanyResponse data) =>
    json.encode(data.toJson());

class ReadmanyResponse {
  ReadmanyResponse({
    required this.data,
  });

  List<Datum> data;

  factory ReadmanyResponse.fromJson(Map<String, dynamic> json) =>
      ReadmanyResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.businessId,
    required this.businessName,
    required this.createdAt,
    required this.id,
    required this.requestBudget,
    required this.status,
    required this.updatedAt,
  });

  String businessId;
  String businessName;
  int createdAt;
  String id;
  double requestBudget;
  String status;
  int updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        businessId: json["business_id"],
        businessName: json["business_name"],
        createdAt: json["created_at"],
        id: json["id"],
        requestBudget: json["request_budget"].toDouble(),
        status: json["status"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "business_id": businessId,
        "business_name": businessName,
        "created_at": createdAt,
        "id": id,
        "request_budget": requestBudget,
        "status": status,
        "updated_at": updatedAt,
      };
}

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
    required this.businessId,
    required this.createdAt,
    required this.id,
    required this.requestBudget,
    required this.status,
    required this.updatedAt,
  });

  String businessId;
  int createdAt;
  String id;
  double requestBudget;
  String status;
  int updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        businessId: json["business_id"],
        createdAt: json["created_at"],
        id: json["id"],
        requestBudget: json["request_budget"].toDouble(),
        status: json["status"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "business_id": businessId,
        "created_at": createdAt,
        "id": id,
        "request_budget": requestBudget,
        "status": status,
        "updated_at": updatedAt,
      };
}

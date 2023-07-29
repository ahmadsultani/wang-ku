// To parse this JSON data, do
//
//     final verifyResponse = verifyResponseFromJson(jsonString);

import 'dart:convert';

VerifyResponse verifyResponseFromJson(String str) =>
    VerifyResponse.fromJson(json.decode(str));

String verifyResponseToJson(VerifyResponse data) => json.encode(data.toJson());

class VerifyResponse {
  VerifyResponse({
    required this.data,
  });

  Data data;

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => VerifyResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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

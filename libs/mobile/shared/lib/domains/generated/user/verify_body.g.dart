// To parse this JSON data, do
//
//     final verifyBody = verifyBodyFromJson(jsonString);

import 'dart:convert';

VerifyBody verifyBodyFromJson(String str) =>
    VerifyBody.fromJson(json.decode(str));

String verifyBodyToJson(VerifyBody data) => json.encode(data.toJson());

class VerifyBody {
  VerifyBody({
    required this.birthPlace,
    required this.nik,
    required this.picture,
  });

  String birthPlace;
  String nik;
  String? picture;

  factory VerifyBody.fromJson(Map<String, dynamic> json) => VerifyBody(
        birthPlace: json["birth_place"],
        nik: json["nik"],
        picture: json["picture"] == null ? null : json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "birth_place": birthPlace,
        "nik": nik,
        "picture": picture == null ? null : picture,
      };
}

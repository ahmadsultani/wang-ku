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
    required this.lendLimit,
    required this.name,
  });

  double? lendLimit;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        lendLimit:
            json["lend_limit"] == null ? null : json["lend_limit"].toDouble(),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "lend_limit": lendLimit == null ? null : lendLimit,
        "name": name,
      };
}

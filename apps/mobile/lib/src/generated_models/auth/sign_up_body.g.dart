// To parse this JSON data, do
//
//     final signUpBody = signUpBodyFromJson(jsonString);

import 'dart:convert';

SignUpBody signUpBodyFromJson(String str) => SignUpBody.fromJson(json.decode(str));

String signUpBodyToJson(SignUpBody data) => json.encode(data.toJson());

class SignUpBody {
    SignUpBody({
        required this.birthDate,
        required this.email,
        required this.gender,
        required this.name,
        required this.password,
        required this.phoneNumber,
        required this.picture,
    });

    int birthDate;
    String email;
    String gender;
    String name;
    String password;
    String phoneNumber;
    String? picture;

    factory SignUpBody.fromJson(Map<String, dynamic> json) => SignUpBody(
        birthDate: json["birth_date"],
        email: json["email"],
        gender: json["gender"],
        name: json["name"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        picture: json["picture"] == null ? null : json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "birth_date": birthDate,
        "email": email,
        "gender": gender,
        "name": name,
        "password": password,
        "phone_number": phoneNumber,
        "picture": picture == null ? null : picture,
    };
}

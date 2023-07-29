import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/constants/failures.dart';
import 'package:mobile/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  final client = http.Client();

  Future<Either<Failure, void>> signup(
    String name,
    String email,
    String password,
    String phoneNumber,
    int birthdate,
    String gender,
  ) async {
    if (gender == "Laki-laki") {
      gender = "male";
    } else {
      gender = 'female';
    }
    final response = await client.post(
      Uri.parse('${dotenv.env['API_URL']}auth/sign-up'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
        'phone_number': phoneNumber,
        'birth_date': birthdate,
        'picture': '',
      }),
    );

    if (response.statusCode == 201) {
      return const Right(null);
    } else {
      // parse response
      final decodedResponse = jsonDecode(response.body);
      return Left(RegisterFailure(decodedResponse['message']));
    }
  }

  Future<Either<Failure, User>> signin(
    String email,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse('${dotenv.env['API_URL']}auth/sign-in'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final data = decodedResponse['data'];
      // save to local
      final user = User.fromJson(data['user'] as Map<String, dynamic>);
      await prefs.setString('token', data['token'] as String);
      await prefs.setString('user', jsonEncode(user.toJson()));
      return Right(user);
    } else {
      // parse response
      final decodedResponse = jsonDecode(response.body);
      // final data = decodedResponse['data'];
      return Left(RegisterFailure(decodedResponse['message']));
    }
  }

  Future<Either<void, User>> getSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token') as String;

    final response = await client.post(
      Uri.parse('API_URL'),
      body: {
        'token': token,
      },
    );

    if (response.statusCode == 200 && response.statusCode == 300) {
      final user = User.fromJson(jsonDecode(prefs.getString('user') as String));
      return Right(user);
    } else {
      return const Left(null);
    }
  }
}

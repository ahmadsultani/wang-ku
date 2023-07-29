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
    // TODO: HIT API
    final response = await client
        .get(
          Uri.parse('${dotenv.env['API_URL']}'),
          //   headers: {
          //   "content-type": "application/json",
          // },
          // body: jsonEncode({
          //   'name': name,
          //   'email': email,
          //   'password': password,
          //   'gender': gender,
          //   'phone_number': phoneNumber,
          //   'birth_date': birthdate,
          //   'picture': '',
          // }),
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
    // TODO: HIT API
    final response = await client.post(
      Uri.parse('API_URL'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      // save to local
      final user =
          User.fromJson(decodedResponse['user'] as Map<String, dynamic>);
      await prefs.setString('token', decodedResponse['token'] as String);
      await prefs.setString('user', jsonEncode(user.toJson()));
      return Right(user);
    } else {
      // parse response
      final decodedResponse = jsonDecode(response.body);
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
      return Left(null);
    }
  }
}

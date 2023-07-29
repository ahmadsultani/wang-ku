import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/failures.dart';

class VerifyService {
  final client = http.Client();

  Future<Either<Failure, void>> verifyUser(
    String picture,
    String nik,
    String birthplace,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await client.post(
      Uri.parse('${dotenv.env['API_URL']}users/verify'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        'picture': picture,
        'nik': nik,
        'birth_place': birthplace,
      }),
    );
    if (response.statusCode == 201) {
      return const Right(null);
    } else {
      // parse response
      final decodedResponse = jsonDecode(response.body);
      // final data = decodedResponse['data'];
      return Left(BusinessRegisterFailure(decodedResponse['message']));
    }
  }
}

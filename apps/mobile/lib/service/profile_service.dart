import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/entities/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/failures.dart';
import '../entities/dashboard.dart';

class ProfileService {
  final client = http.Client();
  Profile? profile;

  Future<Either<Failure, Profile>> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await client.get(
      Uri.parse('${dotenv.env['API_URL']}users/profile'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final responseTwo = await client.get(
      Uri.parse('${dotenv.env['API_URL']}dashboard'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200 && responseTwo.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final data = decodedResponse['data'];

      final profile = Profile.fromJson(data['user']);
      final decodedResponseTwo = jsonDecode(responseTwo.body);
      final dashboardData = Dashboard.fromJson(decodedResponseTwo['data']);
      profile.lendLimit = dashboardData.lendLimit;
      profile.lendTotal = dashboardData.lendTotal;

      return Right(profile);
    } else {
      // parse response
      final decodedResponse = jsonDecode(response.body);
      // final data = decodedResponse['data'];
      return Left(BusinessRegisterFailure(decodedResponse['message']));
    }
  }
}

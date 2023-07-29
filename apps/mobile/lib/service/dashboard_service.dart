import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/failures.dart';
import '../entities/dashboard.dart';

class DashboardService {
  final client = http.Client();

  Future<Either<Failure, Dashboard>> getDashboardData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await client.get(
      Uri.parse('${dotenv.env['API_URL']}dashboard'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return Right(Dashboard.fromJson(decodedResponse['data']));
    } else {
      // parse response
      final decodedResponse = jsonDecode(response.body);
      // final data = decodedResponse['data'];
      return Left(BusinessRegisterFailure(decodedResponse['message']));
    }
  }
}

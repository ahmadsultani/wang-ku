import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/failures.dart';

class BusinessService {
  final client = http.Client();

  Future<Either<Failure, void>> registerBusiness(
    String name,
    String category,
    String npwp,
    String nib,
    String lendLimit,
    String address,
    String phoneNumber,
    String monthlySpending,
    String monthlyIncome,
  ) async {
    // TODO: HIT API
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.get('token');
    final response = await client.post(
      Uri.parse('${dotenv.env['API_URL']}business'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
          'name': name,
          'category': category,
          'npwp': npwp,
          'nib': nib,
          'lend_limit': lendLimit,
          'address': address,
          'phone_number': phoneNumber,
          'monthly_spending': monthlySpending,
          'monthly_income': monthlyIncome,
      }),
    );
    print(response.statusCode);
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
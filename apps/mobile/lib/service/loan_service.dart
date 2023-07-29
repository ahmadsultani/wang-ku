import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/failures.dart';

class LoanService {
  final client = http.Client();
  
  Future<Either<Failure, void>> registerLoan(
    int requestBudget,
    String accountNumber,
    String bank,
  ) async {
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
        'request_budget': requestBudget,
        'account_number': accountNumber,
        'bank': bank,
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
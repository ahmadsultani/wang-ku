import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/failures.dart';
import '../entities/budget_data.dart';

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
      Uri.parse('${dotenv.env['API_URL']}budget-request'),
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

  Future<Either<Failure, BudgetData>> getBudgetData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.get('token');
    final response = await client.get(
      Uri.parse('${dotenv.env['API_URL']}budget-request'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return Right(
          BudgetData.fromJson(decodedResponse['data'] as Map<String, dynamic>));
    } else {
      // parse response
      final decodedResponse = jsonDecode(response.body);
      // final data = decodedResponse['data'];
      return Left(BusinessRegisterFailure(decodedResponse['message']));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

import '../constants/failures.dart';
import '../entities/budget_data.dart';
import '../service/loan_service.dart';

part 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();
  final service = LoanService();
  LoanCubit() : super(LoanInitial());

  Future<bool> hasConnection() {
    return _connectionChecker.hasConnection;
  }

  void onGetLoan(
    int requestBudget,
    String accountNumber,
    String bank,
  ) async {
    emit(LoanLoading());
    // check internet connection
    if (await hasConnection()) {
      final result =
          await service.registerLoan(requestBudget, accountNumber, bank);

      result.fold(
        (failure) {
          emit(LoanFailed(failure));
        },
        (r) {
          emit(LoanSuccess());
        },
      );
    } else {
      emit(LoanFailed(NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }

  void onGetBudgetLoan() async {
    emit(LoanGetBudgetLoading());
    // check internet connection
    if (await hasConnection()) {
      final result = await service.getBudgetData();
      print('state');

      result.fold(
        (failure) {
          emit(LoanGetBudgetFailed(failure));
        },
        (budget) {
          emit(LoanGetBudgetSuccess(budget));
        },
      );
    } else {
      emit(LoanGetBudgetFailed(NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }
}

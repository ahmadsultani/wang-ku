import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:mobile/service/dashboard_service.dart';

import '../constants/failures.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();
  final service = DashboardService();
  
  DashboardCubit() : super(DashboardInitial());

  Future<bool> hasConnection() {
    return _connectionChecker.hasConnection;
  }

  void onRegisterBusiness(
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
    emit(DashboardLoading());
    // check internet connection
    if (await hasConnection()) {
      final result = await service.getDashboardData();

      result.fold(
        (failure) {
          emit(DashboardFailed(failure));
        },
        (r) {
          emit(DashboardSuccess());
        },
      );
    } else {
      emit(DashboardFailed(
          NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }
}

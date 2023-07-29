import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:mobile/constants/enum.dart';
import 'package:mobile/constants/failures.dart';

import '../service/business_service.dart';
part 'business_state.dart';

class BusinessCubit extends Cubit<BusinessState> {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();
  final service = BusinessService();
  BusinessCubit() : super(BusinessInitial());

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
    emit(BusinessRegisterLoading());
    // check internet connection
    if (await hasConnection()) {
      final result = await service.registerBusiness(
        name,
        convertCategory(category),
        npwp,
        nib,
        lendLimit,
        address,
        phoneNumber,
        monthlySpending,
        monthlyIncome,
      );

      result.fold(
        (failure) {
          emit(BusinessRegisterFailed(failure));
        },
        (r) {
          emit(BusinessRegisterSuccess());
        },
      );
    } else {
      emit(BusinessRegisterFailed(
          NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }
}

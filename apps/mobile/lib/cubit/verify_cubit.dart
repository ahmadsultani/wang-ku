import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:mobile/constants/failures.dart';
import 'package:mobile/service/verify_service.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();
  final service = VerifyService();
  VerifyCubit() : super(VerifyInitial());

  Future<bool> hasConnection() {
    return _connectionChecker.hasConnection;
  }

  void onVerifyUser(
    String picture,
    String nik,
    String birthplace,
  ) async {
    emit(VerifyLoading());
    // check internet connection
    if (await hasConnection()) {
      final result =
          await service.verifyUser(picture, nik, birthplace);

      result.fold(
        (failure) {
          emit(VerifyFailed(failure));
        },
        (r) {
          emit(VerifySuccess());
        },
      );
    } else {
      emit(VerifyFailed(NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }
}

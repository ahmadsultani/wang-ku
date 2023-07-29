import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:mobile/constants/failures.dart';
import 'package:mobile/entities/profile.dart';

import '../service/profile_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();
  final service = ProfileService();
  ProfileCubit() : super(ProfileInitial());

  Future<bool> hasConnection() {
    return _connectionChecker.hasConnection;
  }

  void onGetProfile(
  ) async {
    emit(ProfileGetLoading());
    // check internet connection
    if (await hasConnection()) {
      final result =
          await service.getProfile();

      result.fold(
        (failure) {
          emit(ProfileGetFailed(failure));
        },
        (profile) {
          emit(ProfileGetSuccess(profile));
        },
      );
    } else {
      emit(ProfileGetFailed(NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }
}

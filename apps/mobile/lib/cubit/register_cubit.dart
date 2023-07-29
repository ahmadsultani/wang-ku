import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/constants/failures.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/service/register_service.dart';

import '../entities/user.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();
  final client = http.Client();
  final service = RegisterService();

  RegisterCubit() : super(RegisterInitial());

  late User? currentUser;

  Future<bool> hasConnection() {
    return _connectionChecker.hasConnection;
  }

  void onSignup(
    String name,
    String email,
    String password,
    String phoneNumber,
    int birthdate,
    String gender,
  ) async {
    emit(RegisterSignUpLoading());
    // check internet connection
    if (await hasConnection()) {
      final result = await service.signup(
          name, email, password, phoneNumber, birthdate, gender);

      result.fold(
        (failure) {
          emit(RegisterSignUpFailed(failure));
        },
        (r) {
          emit(RegisterSignUpSuccess());
        },
      );
    } else {
      emit(RegisterSignUpFailed(NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }

  void onSignin(
    String name,
    String email,
    String password,
    String phoneNumber,
    BigInt birthdate,
    String gender,
  ) async {
    emit(RegisterSignInLoading());
    // check internet connection
    if (await hasConnection()) {
      final result = await service.signin(
        email,
        password,
      );

      result.fold(
        (failure) {
          emit(RegisterSignInFailed(failure));
        },
        (user) {
          currentUser = user;
          emit(RegisterSignInSuccess());
        },
      );
    } else {
      emit(RegisterSignInFailed(NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }

  void onGetSession() async {
    emit(RegisterGetSessionLoading());
    // check internet connection
    if (await hasConnection()) {
      final result = await service.getSession();

      result.fold(
        (failure) {
          emit(RegisterGetSessionFailed());
        },
        (user) {
          currentUser = user;
          emit(RegisterGetSessionSuccess());
        },
      );
    } else {
      emit(RegisterSignInFailed(NetworkFailure('Tidak Terhubung ke jaringan')));
    }
  }
}

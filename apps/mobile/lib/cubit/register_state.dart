part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSignUpSuccess extends RegisterState {}

class RegisterSignUpFailed extends RegisterState {
  final Failure failure;

  RegisterSignUpFailed(this.failure);
}

class RegisterSignUpLoading extends RegisterState {}

class RegisterSignInSuccess extends RegisterState {}

class RegisterSignInFailed extends RegisterState {
  final Failure failure;

  RegisterSignInFailed(this.failure);
}

class RegisterSignInLoading extends RegisterState {}

class RegisterGetSessionSuccess extends RegisterState {}
class RegisterGetSessionFailed extends RegisterState {}
class RegisterGetSessionLoading extends RegisterState {}
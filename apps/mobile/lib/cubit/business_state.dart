part of 'business_cubit.dart';

@immutable
abstract class BusinessState {}

class BusinessInitial extends BusinessState {}

class BusinessRegisterLoading extends BusinessState {}

class BusinessRegisterFailed extends BusinessState {
  final Failure failure;

  BusinessRegisterFailed(this.failure);
}

class BusinessRegisterSuccess extends BusinessState {}

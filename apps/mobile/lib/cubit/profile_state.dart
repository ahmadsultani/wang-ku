part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileGetLoading extends ProfileState {}

class ProfileGetSuccess extends ProfileState {
  final Profile profile;

  ProfileGetSuccess(this.profile);
}

class ProfileGetFailed extends ProfileState {
  final Failure failure;

  ProfileGetFailed(this.failure);
}

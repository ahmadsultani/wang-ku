part of 'loan_cubit.dart';

@immutable
abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanLoading extends LoanState {}

class LoanSuccess extends LoanState {}

class LoanFailed extends LoanState {
  final Failure failure;

  LoanFailed(this.failure);
}

part of 'loan_cubit.dart';

@immutable
abstract class LoanState {}

class LoanInitial extends LoanState {}

class LoanLoading extends LoanState {}
class LoanSuccess extends LoanState {}

class LoanGetBudgetLoading extends LoanState {}
class LoanGetBudgetSuccess extends LoanState {
  final BudgetData budget;

  LoanGetBudgetSuccess(this.budget);
}
class LoanGetBudgetFailed extends LoanState {
  final Failure failure;

  LoanGetBudgetFailed(this.failure);

}

class LoanFailed extends LoanState {
  final Failure failure;

  LoanFailed(this.failure);
}


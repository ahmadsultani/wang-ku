class Dashboard {
  final int limit;
  final int income;
  final int outcome;
  final LoanStatus status;
  final bool ktpVerify;
  final bool busenissVerify;

  Dashboard(this.limit, this.income, this.outcome, this.status, this.ktpVerify, this.busenissVerify);
}

enum LoanStatus {
  pending,
  on_process,
  approved,
  denied,
}
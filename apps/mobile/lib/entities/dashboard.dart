class Dashboard {
  final int lendTotal;
  final int lendLimit;
  final int income;
  final int outcome;
  final String lendStatus;
  final bool ktpVerify;
  final bool businessVerify;

  Dashboard({
    required this.lendTotal,
    required this.lendLimit,
    required this.income,
    required this.outcome,
    required this.ktpVerify,
    required this.businessVerify,
    required this.lendStatus,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    bool businessVerif = json['business'] == null ? false : true;
    bool ktpVerif = json['user_verification'] == null ? false : true;
    return Dashboard(
      lendTotal: json['lend_total'] ?? 0,
      lendLimit: json['lend_limit'],
      income: json['monthly_income'],
      outcome: json['monthly_spending'] ?? 0,
      ktpVerify: ktpVerif,
      businessVerify: businessVerif,
      lendStatus: json['last_lend_status'] ?? '',
    );
  }
}

enum LoanStatus {
  pending,
  on_process,
  approved,
  denied,
}

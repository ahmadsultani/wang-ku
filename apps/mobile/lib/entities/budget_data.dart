class BudgetData {
  final String name;
  final int lendLimit;

  BudgetData({
    required this.name,
    required this.lendLimit,
});

  factory BudgetData.fromJson(Map<String, dynamic> json) {
    return BudgetData(
      name: json['name'],
      lendLimit: json['lend_limit'],
    );
  }
}

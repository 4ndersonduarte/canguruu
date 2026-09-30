class FinanceFailure implements Exception {
  const FinanceFailure(this.code, this.message);
  final String code;
  final String message;
  @override
  String toString() => message;
}

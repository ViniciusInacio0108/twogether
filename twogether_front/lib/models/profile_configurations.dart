class ProfileConfigurations {
  static const _minDailySpending = 1.0;
  double _maxDailySpending = 1.0;

  ProfileConfigurations({
    required double maxDailySpending,
  }) {
    setMaxDailySpending(maxDailySpending);
  }

  double get maxDailySpending => _maxDailySpending;

  void setMaxDailySpending(double newMax) {
    if (newMax < _minDailySpending) {
      throw Exception("Limite diário não pode ser negativo.");
    }
  }
}

enum EtransactionTypes {
  income,
  outcome;

  String get value => name;

  static EtransactionTypes fromString(String value) {
    return EtransactionTypes.values.firstWhere(
      (e) => e.name == value,
    );
  }
}

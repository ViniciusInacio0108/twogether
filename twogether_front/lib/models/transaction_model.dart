import 'package:twogether_front/enums/Etransaction_types.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  final String _id;
  final double _value;
  final DateTime _date;
  String ownerId;
  EtransactionTypes type;

  Transaction(
      {required value,
      required this.ownerId,
      required this.type,
      required date})
      : _date = date,
        _value = _checkTransactionValueAndReturnIt(value),
        _id = const Uuid().v4();

  factory Transaction.nowDate({
    required value,
    required ownerId,
    required type,
  }) =>
      Transaction(
        value: value,
        ownerId: ownerId,
        type: type,
        date: DateTime.now(),
      );

  DateTime get date => _date;

  double get value => _value;

  String get id => _id;

  static double _checkTransactionValueAndReturnIt(double value) {
    if (value <= 0) {
      throw Exception("O valor da transação não pode ser menor ou igual a 0!");
    }

    return value;
  }

  DateTime getDayKey() {
    final date = this.date;
    return DateTime(date.year, date.month, date.day);
  }
}

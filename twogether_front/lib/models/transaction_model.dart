import 'package:twogether_front/enums/Etransaction_types.dart';
import 'package:twogether_front/models/user_model.dart';
import 'package:uuid/uuid.dart';

class TransactionModel {
  final String _id;
  final double _value;
  final DateTime _date;
  UserModel owner;
  EtransactionTypes type;

  TransactionModel({
    required value,
    required this.owner,
    required this.type,
  })  : _date = DateTime.now(),
        _value = _checkTransactionValueAndReturnIt(value),
        _id = const Uuid().v4();

  DateTime get date => _date;

  double get value => _value;

  String get id => _id;

  static double _checkTransactionValueAndReturnIt(double value) {
    if (value <= 0) {
      throw Exception("O valor da transação não pode ser menor ou igual a 0!");
    }

    return value;
  }
}

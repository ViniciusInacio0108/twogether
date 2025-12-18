import 'package:twogether_front/enums/Etransaction_types.dart';
import 'package:twogether_front/models/transaction_model.dart';

class BalanceModel {
  double _currentBalance = 0.0;
  Map<String, TransactionModel> _incomesById = {};
  Map<String, TransactionModel> _outcomesById = {};

  BalanceModel();

  double get currentBalance => _currentBalance;
  Map<String, TransactionModel> get incomesById => _incomesById;
  Map<String, TransactionModel> get outcomerById => _outcomesById;

  void addTransaction(TransactionModel transaction) {
    transaction.type == EtransactionTypes.income
        ? _addIncomeTransaction(transaction)
        : _addOutcomeTransaction(transaction);
  }

  void _addIncomeTransaction(TransactionModel transaction) {
    _incomesById.putIfAbsent(
      transaction.id,
      () => transaction,
    );
    _currentBalance += transaction.value;
  }

  void _addOutcomeTransaction(TransactionModel transaction) {
    if (transaction.value > _currentBalance) {
      throw Exception(
          "O valor a ser retirado não pode ser maior que o valor do balanço!");
    }

    _outcomesById.putIfAbsent(
      transaction.id,
      () => transaction,
    );

    _currentBalance -= transaction.value;
  }
}

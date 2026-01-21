import 'package:twogether_front/enums/Etransaction_types.dart';
import 'package:twogether_front/models/transaction_model.dart';

class BalanceModel {
  double _currentBalance = 0.0;
  Map<String, Transaction> _incomesById = {};
  Map<String, Transaction> _outcomesById = {};

  BalanceModel();

  double get currentBalance => _currentBalance;
  Map<String, Transaction> get incomesById => _incomesById;
  Map<String, Transaction> get outcomerById => _outcomesById;

  void addTransaction(Transaction transaction) {
    transaction.type == EtransactionTypes.income
        ? _addIncomeTransaction(transaction)
        : _addOutcomeTransaction(transaction);
  }

  void _addIncomeTransaction(Transaction transaction) {
    _incomesById.putIfAbsent(
      transaction.id,
      () => transaction,
    );
    _currentBalance += transaction.value;
  }

  void _addOutcomeTransaction(Transaction transaction) {
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

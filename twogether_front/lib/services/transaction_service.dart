import 'package:twogether_front/models/transaction_model.dart';
import 'package:twogether_front/repositories/transaction_repository.dart';

class TransactionService {
  final TransactionRepository repository;

  TransactionService(this.repository);

  Future<List<Transaction>> transactionsOfDay(DateTime day) {
    return repository.getByDay(day);
  }

  Future<List<Transaction>> transactionsOfMonth(int year, int month) {
    return repository.getByMonth(year, month);
  }

  Future<List<Transaction>> transactionsOfYear(int year) {
    return repository.getByYear(year);
  }

  Future<void> addTransaction(Transaction transaction) {
    return repository.add(transaction);
  }

  Future<void> updateTransaction(Transaction transaction) {
    return repository.update(transaction);
  }

  Future<void> removeTransaction(String transactionId) {
    return repository.remove(transactionId);
  }
}

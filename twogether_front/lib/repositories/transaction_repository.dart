import 'package:twogether_front/daos/transaction_dao.dart';
import 'package:twogether_front/enums/Etransaction_types.dart';
import 'package:twogether_front/models/transaction_model.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getByDay(DateTime day);
  Future<List<Transaction>> getByMonth(int year, int month);
  Future<List<Transaction>> getByYear(int year);

  Future<void> add(Transaction transaction);
  Future<void> update(Transaction transaction);
  Future<void> remove(String transactionId);
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDao dao;
  final TransactionMapper mapper;

  TransactionRepositoryImpl(this.dao, this.mapper);

  @override
  Future<List<Transaction>> getByDay(DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));

    final result = await dao.findByPeriod(
      start.millisecondsSinceEpoch,
      end.millisecondsSinceEpoch,
    );

    return result.map(mapper.fromMap).toList();
  }

  @override
  Future<List<Transaction>> getByMonth(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end =
        (month == 12) ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);

    final result = await dao.findByPeriod(
      start.millisecondsSinceEpoch,
      end.millisecondsSinceEpoch,
    );

    return result.map(mapper.fromMap).toList();
  }

  @override
  Future<List<Transaction>> getByYear(int year) async {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year + 1, 1, 1);

    final result = await dao.findByPeriod(
      start.millisecondsSinceEpoch,
      end.millisecondsSinceEpoch,
    );

    return result.map(mapper.fromMap).toList();
  }

  @override
  Future<void> add(Transaction transaction) async {
    await dao.insert(mapper.toMap(transaction));
  }

  @override
  Future<void> update(Transaction transaction) async {
    await dao.update(
      transaction.id,
      mapper.toMap(transaction),
    );
  }

  @override
  Future<void> remove(String transactionId) async {
    await dao.delete(transactionId);
  }
}

class TransactionMapper {
  Transaction fromMap(Map<String, dynamic> map) {
    return Transaction(
      value: map['value'],
      date: DateTime.fromMillisecondsSinceEpoch(
        map['transaction_date'],
      ),
      ownerId: map['owner_id'],
      type: EtransactionTypes.fromString(map['type']),
    );
  }

  Map<String, dynamic> toMap(Transaction tx) {
    return {
      'id': tx.id,
      'value': tx.value,
      'transaction_date': tx.date.millisecondsSinceEpoch,
      'owner_id': tx.ownerId,
      'type': tx.type.value,
    };
  }
}

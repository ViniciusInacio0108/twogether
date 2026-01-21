import 'package:flutter/foundation.dart';
import 'package:twogether_front/models/transaction_model.dart';
import 'package:twogether_front/services/transaction_service.dart';

class MonthlyTransactionsController extends ChangeNotifier {
  final TransactionService service;

  final int _year;
  final int _month;

  /// Agrupado por dia (00:00)
  final Map<DateTime, List<Transaction>> _byDay = {};

  /// Índice auxiliar: transactionId -> dayKey
  final Map<String, DateTime> _txDayIndex = {};

  Map<DateTime, List<Transaction>> get byDay => _byDay;

  MonthlyTransactionsController(
    this.service,
    this._year,
    this._month,
  );

  // ---------------- LOAD ----------------

  Future<void> loadMonth() async {
    final list = await service.transactionsOfMonth(_year, _month);

    _byDay.clear();
    _txDayIndex.clear();

    for (final tx in list) {
      _insert(tx);
    }

    notifyListeners();
  }

  // ---------------- ADD ----------------

  Future<void> addTransaction(Transaction tx) async {
    await service.addTransaction(tx);

    if (_belongsToCurrentMonth(tx.date)) {
      _insert(tx);
      notifyListeners();
    }
  }

  // ---------------- UPDATE ----------------

  Future<void> updateTransaction(Transaction updated) async {
    await service.updateTransaction(updated);

    final oldDay = _txDayIndex[updated.id];

    if (oldDay != null) {
      _removeFromDay(updated.id, oldDay);
    }

    if (_belongsToCurrentMonth(updated.date)) {
      _insert(updated);
    }

    notifyListeners();
  }

  // ---------------- REMOVE ----------------

  Future<void> removeTransaction(String id) async {
    await service.removeTransaction(id);

    final day = _txDayIndex[id];
    if (day != null) {
      _removeFromDay(id, day);
      notifyListeners();
    }
  }

  // ---------------- HELPERS ----------------

  void _insert(Transaction tx) {
    final dayKey = tx.getDayKey();

    _byDay.putIfAbsent(dayKey, () => []).add(tx);
    _txDayIndex[tx.id] = dayKey;
  }

  void _removeFromDay(String txId, DateTime dayKey) {
    final list = _byDay[dayKey];
    if (list == null) return;

    list.removeWhere((tx) => tx.id == txId);

    if (list.isEmpty) {
      _byDay.remove(dayKey);
    }

    _txDayIndex.remove(txId);
  }

  bool _belongsToCurrentMonth(DateTime date) {
    return date.year == _year && date.month == _month;
  }
}

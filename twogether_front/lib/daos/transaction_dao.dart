import 'package:sqflite/sqflite.dart';
import 'package:twogether_front/configs/app_database.dart';

class TransactionDao {
  Future<Database> get _db async => AppDatabase.instance;

  Future<List<Map<String, dynamic>>> findByPeriod(
    int start,
    int end,
  ) async {
    final db = await _db;

    return db.query(
      'transactions',
      where: 'transaction_date >= ? AND transaction_date < ?',
      whereArgs: [start, end],
      orderBy: 'transaction_date ASC',
    );
  }

  Future<void> insert(Map<String, dynamic> data) async {
    final db = await _db;
    await db.insert(
      'transactions',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(
    String id,
    Map<String, dynamic> data,
  ) async {
    final db = await _db;
    await db.update(
      'transactions',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(String id) async {
    final db = await _db;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

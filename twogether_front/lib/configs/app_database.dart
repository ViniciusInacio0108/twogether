import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get instance async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'finance.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        value REAL NOT NULL,
        transaction_date INTEGER NOT NULL,
        owner_id TEXT NOT NULL,
        type TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_date
      ON transactions (transaction_date);
    ''');
  }
}

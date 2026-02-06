import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FinanceDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'finance_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            typeAccount INTEGER,
            codePAN TEXT,
            name TEXT,
            nameMoney TEXT,
            symbolMoney TEXT,
            amount TEXT,
            isLogout INTEGER
          )
        ''');
      },
    );
  }
}

import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'user_transactions.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_transactions(id TEXT PRIMARY KEY, title TEXT, amount TEXT, date TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
      },
      version: 1,
    );
  }

  static Future<sql.Database> currencyDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'currency.db'),
      onCreate: (db, version) {
        return db.execute('CREATE TABLE currency(id TEXT PRIMARY KEY)');
      },
      version: 1,
    );
  }

  static Future<void> insertCurrency(
    String table,
    Map<String, Object> data,
  ) async {
    final db = await DBHelper.currencyDatabase();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<void> loadcurrency() async {}

  static Future<void> insert(
    String table,
    Map<String, Object> data,
  ) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, Object>>> getcur(String table) async {
    final db = await DBHelper.currencyDatabase();
    return db.query(table);
  }

  static Future<int> delete(String table, String id) async {
    final db = await DBHelper.database();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}

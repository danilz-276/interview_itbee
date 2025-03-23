import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Hàm lấy database (khởi tạo nếu chưa có)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Khởi tạo database
  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Tạo bảng
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE languages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT NOT NULL,
        name TEXT NOT NULL,
        is_selected INTEGER DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE theme (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        is_dark_mode INTEGER NOT NULL DEFAULT 0
      );
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        status INTEGER DEFAULT 0,
        due_date TEXT,
        start_date TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
      );
    ''');
  }

  // Đóng database
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}

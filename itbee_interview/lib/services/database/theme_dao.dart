import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class ThemeDao {
  Future<Database> get _db async => await DatabaseHelper.instance.database;

  Future<bool> getCurrentTheme() async {
    final db = await _db;
    final result = await db.query("theme");

    if (result.isNotEmpty) {
      return result.first["is_dark_mode"] == 1;
    }
    return false;
  }

  Future<void> setTheme(bool isDark) async {
    final db = await _db;
    final result = await db.query("theme");

    if (result.isEmpty) {
      await db.insert("theme", {"is_dark_mode": isDark ? 1 : 0});
    } else {
      await db.update("theme", {"is_dark_mode": isDark ? 1 : 0});
    }
  }
}

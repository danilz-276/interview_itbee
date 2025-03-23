import 'package:sqflite/sqflite.dart';

import '../../model/base/language.dart';
import 'database_helper.dart';

class LanguageDao {
  // Không lưu database vào biến `final db`
  Future<Database> get _db async => await DatabaseHelper.instance.database;

  // Thêm ngôn ngữ mới
  Future<int> insertLanguage(Language language) async {
    final db = await _db;
    return await db.insert("languages", language.toJson());
  }

  // Lấy danh sách ngôn ngữ
  Future<List<Language>> getAllLanguages() async {
    final db = await _db;
    final result = await db.query("languages", orderBy: "id ASC");
    return result.map((json) => Language.fromJson(json)).toList();
  }

  // Cập nhật thông tin ngôn ngữ
  Future<int> updateLanguage(Language language) async {
    final db = await _db;
    return await db.update(
      "languages",
      language.toJson(),
      where: "code = ?",
      whereArgs: [language.code],
    );
  }

  // Xóa ngôn ngữ
  Future<int> deleteLanguage(int id) async {
    final db = await _db;
    return await db.delete("languages", where: "id = ?", whereArgs: [id]);
  }

  // Lấy ngôn ngữ hiện tại (nếu có)
  Future<Language?> getCurrentLanguage() async {
    final db = await _db;
    final result = await db.query(
      "languages",
      where: "is_selected = ?",
      whereArgs: [1],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return Language.fromJson(result.first);
    }
    return null;
  }

  // Đặt ngôn ngữ hiện tại
  Future<void> setCurrentLanguage(int id) async {
    final db = await _db;
    await db.update("languages", {"is_selected": 0});
    await db.update(
      "languages",
      {"is_selected": 1},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

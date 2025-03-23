import 'package:sqflite/sqflite.dart';

import '../../model/base/task.dart';
import 'database_helper.dart';

class TaskDao {
  Future<Database> get _db async => await DatabaseHelper.instance.database;

  // Thêm công việc mới
  Future<int> insertTask(Task task) async {
    final db = await _db;
    return await db.insert("tasks", task.toJson());
  }

  // Lấy danh sách tất cả công việc
  Future<Map<String, dynamic>> getTasksWithPaging({
    int page = 1,
    int limit = 10,
    int? status, // Trạng thái có thể null (lấy tất cả)
  }) async {
    final db = await _db;
    final offset = (page - 1) * limit;

    // Điều kiện WHERE nếu có status
    String whereClause = status != null ? "WHERE status = ?" : "";
    List<dynamic> whereArgs = status != null ? [status] : [];

    // Lấy danh sách task theo phân trang và status
    final tasks = await db.rawQuery(
      "SELECT * FROM tasks $whereClause ORDER BY due_date ASC LIMIT ? OFFSET ?",
      [...whereArgs, limit, offset],
    );

    // Lấy tổng số task với cùng điều kiện
    int totalCount =
        Sqflite.firstIntValue(
          await db.rawQuery(
            "SELECT COUNT(*) FROM tasks $whereClause",
            whereArgs,
          ),
        ) ??
        0;

    return {
      "tasks": tasks.map((json) => Task.fromJson(json)).toList(),
      "totalCount": totalCount,
    };
  }

  Future<List<Task>> getTasksByStatus(int status) async {
    final db = await _db;
    final result = await db.query(
      "tasks",
      where: "status = ?",
      whereArgs: [status],
      orderBy: "due_date ASC",
    );
    return result.map((json) => Task.fromJson(json)).toList();
  }

  // Cập nhật công việc
  Future<int> updateTask(Task task) async {
    final db = await _db;
    return await db.update(
      "tasks",
      task.toJson(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  // Đánh dấu công việc hoàn thành / chưa hoàn thành
  Future<int> updateTaskStatus(int id, int status) async {
    final db = await _db;
    return await db.update(
      "tasks",
      {"status": status},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Xóa công việc
  Future<int> deleteTask(int id) async {
    final db = await _db;
    return await db.delete("tasks", where: "id = ?", whereArgs: [id]);
  }

  Future<Task?> getTaskById(int id) async {
    final db = await _db;
    final result = await db.query(
      "tasks",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return Task.fromJson(result.first);
    }
    return null; // Trả về null nếu không tìm thấy công việc
  }

   /// Tìm kiếm task theo tên
  Future<List<Task>> searchTasks(String query) async {
    final db = await _db;
    final result = await db.query(
      "tasks",
      where: "title LIKE ?",
      whereArgs: ['%$query%'], // Tìm kiếm với ký tự đại diện (%)
    );
    return result.map((json) => Task.fromJson(json)).toList();
  }
}

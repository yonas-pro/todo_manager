import 'package:sqflite/sqflite.dart';
import 'package:todo_manager/models/task_model.dart';

class DatabaseHelper {
  static Database? database;
  static int version = 1;
  static String tableName = 'tasks_table';

  static initDatabase() async {
    if (database != null) return;

    String dbFilePath = await getDatabasesPath() + 'tasks.db';
    database = await openDatabase(
      dbFilePath,
      version: version,
      onCreate: (database, version) {
        database.execute(
          'CREATE TABLE $tableName('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title STRING, description TEXT, date STRING, '
          'startTime STRING, endTime STRING, '
          'remind INTEGER, repeat STRING, '
          'taskTheme INTEGER, '
          'isCompleted INTEGER)',
        );
      },
    );
  }

  static saveTask(TaskModel taskModel) async {
    return await database!.insert(
      tableName,
      taskModel.toJson(),
    );
  }
}

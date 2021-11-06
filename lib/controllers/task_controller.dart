import 'package:get/get.dart';
import 'package:todo_manager/database/database_helper.dart';
import 'package:todo_manager/models/task_model.dart';

class TaskController extends GetxController {
  addTask(TaskModel taskModel) async {
    return await DatabaseHelper.saveTask(taskModel);
  }
}

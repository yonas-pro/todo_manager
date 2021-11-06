import 'package:get/get.dart';
import 'package:todo_manager/database/database_helper.dart';
import 'package:todo_manager/models/task_model.dart';

class TaskController extends GetxController {
  var taskList = <TaskModel>[].obs;
  addTask(TaskModel taskModel) async {
    return await DatabaseHelper.saveTask(taskModel);
  }

  getTask() async {
    List<Map<String, dynamic>> tasks = await DatabaseHelper.query();
    taskList.assignAll(
      tasks.map((data) => TaskModel.fromJson(data)).toList(),
    );
  }
}

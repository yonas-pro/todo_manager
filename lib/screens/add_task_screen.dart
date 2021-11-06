import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_manager/widgets/custom_app_bar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: customAppBar(
          title: 'Task Detail',
          icon: Icons.close,
          context: context,
          onPressed: () => Get.back(),
        ),
      ),
    );
  }
}

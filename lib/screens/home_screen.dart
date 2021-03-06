import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_manager/constants/app_colors.dart' as my_color;
import 'package:todo_manager/constants/app_styles.dart';
import 'package:todo_manager/controllers/task_controller.dart';
import 'package:todo_manager/screens/add_task_screen.dart';
import 'package:todo_manager/services/theme_service.dart';
import 'package:todo_manager/widgets/custom_app_bar.dart';
import 'package:todo_manager/widgets/custom_task_tile.dart';
import 'package:todo_manager/widgets/custom_toast_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final toast = FToast();
  DateTime _selectedDate = DateTime.now();
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    toast.init(context);
    taskController.getTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Today',
        icon: Get.isDarkMode ? Icons.lightbulb_outline : Icons.lightbulb,
        context: context,
        onPressed: _changeTheme,
      ),
      body: Column(
        children: [
          _buildDatePicker(),
          const SizedBox(height: 10),
          _buildTaskListView(),
        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  _changeTheme() {
    ThemeService().changeTheme();
    _showBottomToast(
      'Theme changed!',
      Icons.threesixty_sharp,
      my_color.blue.withOpacity(0.2),
    );
  }

  _showBottomToast(String message, IconData icon, Color color) {
    toast.showToast(
      child: CustomToastMessage(message: message, icon: icon, color: color),
      gravity: ToastGravity.BOTTOM,
      fadeDuration: 400,
      toastDuration: const Duration(milliseconds: 1500),
    );
  }

  _buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: DatePicker(
        DateTime.now(),
        height: 78,
        width: 48,
        initialSelectedDate: DateTime.now(),
        selectionColor: my_color.blue,
        selectedTextColor: my_color.white,
        dateTextStyle: datePickerStyle.copyWith(fontSize: 20),
        monthTextStyle: datePickerStyle,
        dayTextStyle: datePickerStyle,
        onDateChange: (newDate) => _selectedDate = newDate,
      ),
    );
  }

  _buildFAB() {
    return FloatingActionButton(
      onPressed: () async {
        await Get.to(
          () => const AddTaskScreen(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeIn,
        );
        taskController.getTask();
      },
      backgroundColor: my_color.blue,
      child: const Icon(Icons.post_add_outlined, color: my_color.white),
    );
  }

  _buildTaskListView() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: taskController.taskList.length,
          itemBuilder: (_, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      CustomTaskTile(taskController.taskList[index]),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_manager/constants/app_color.dart' as my_color;
import 'package:todo_manager/screens/add_task_screen.dart';
import 'package:todo_manager/services/theme_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final toast = FToast();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildDatePicker(),
        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  _buildAppBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Today',
            style: TextStyle(
                color: Get.isDarkMode ? my_color.white : my_color.black),
          ),
          const SizedBox(height: 5),
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            style: TextStyle(
              color: Get.isDarkMode
                  ? Colors.grey[500]
                  : Colors.grey.withOpacity(0.8),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: _changeTheme,
          icon: Icon(
            Get.isDarkMode ? Icons.lightbulb_outline : Icons.lightbulb,
            color: my_color.blue,
          ),
        ),
      ],
    );
  }

  _changeTheme() {
    ThemeService().changeTheme();
    _showBottomToast(
      'Theme changed!',
      Icons.home,
      my_color.blue.withOpacity(0.2),
    );
  }

  _showBottomToast(String message, IconData icon, Color color) {
    toast.showToast(
      child: _buildToast(message, icon, color),
      gravity: ToastGravity.BOTTOM,
      fadeDuration: 400,
      toastDuration: const Duration(milliseconds: 1200),
    );
  }

  _buildToast(String message, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Get.isDarkMode ? my_color.black : my_color.white),
          const SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(
              color: Get.isDarkMode ? my_color.black : my_color.white,
            ),
          ),
        ],
      ),
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
        dateTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
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
      },
      backgroundColor: my_color.blue,
      child: const Icon(Icons.post_add_outlined),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_manager/constants/app_colors.dart' as my_color;
import 'package:todo_manager/widgets/custom_app_bar.dart';
import 'package:todo_manager/widgets/custom_text_field.dart';
import 'package:todo_manager/widgets/custom_toast_message.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String startingTime = DateFormat('hh:mm a').format(DateTime.now());
  String endingTime = '12:00 PM';
  int selectedRemindMinute = 5;
  List<int> remindMinuteList = [5, 10, 15, 20, 30];
  String selectedRepeatMode = 'One-Time';
  List<String> repeatModeList = ['One-Time', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = Random().nextInt(3);

  final toast = FToast();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: 'Title',
                  hintText: 'What\'s on your mind ...',
                  controller: titleController,
                ),
                CustomTextField(
                  labelText: 'Description',
                  hintText: 'You can leave it as it is.',
                  controller: descriptionController,
                ),
                CustomTextField(
                  hintText: DateFormat.yMMMMd().format(_selectedDate),
                  widget: IconButton(
                    onPressed: () => _getDateFromUser(),
                    icon: const Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  text: 'Due Date',
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        text: 'Starting Time',
                        hintText: startingTime,
                        widget: IconButton(
                          onPressed: () => _getTimeFromUser(true),
                          icon: const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        text: 'Ending Time',
                        hintText: endingTime,
                        widget: IconButton(
                          onPressed: () => _getTimeFromUser(false),
                          icon: const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  text: 'Remind me',
                  hintText: '$selectedRemindMinute minutes earlier.',
                  widget: DropdownButton(
                    icon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    underline: const SizedBox(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRemindMinute = int.parse(newValue!);
                      });
                    },
                    items: remindMinuteList
                        .map<DropdownMenuItem<String>>((selectedValue) {
                      return DropdownMenuItem<String>(
                        child: Text('$selectedValue'),
                        value: '$selectedValue',
                      );
                    }).toList(),
                  ),
                ),
                CustomTextField(
                  text: 'Repeat',
                  hintText: selectedRepeatMode,
                  widget: DropdownButton(
                    icon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    underline: const SizedBox(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRepeatMode = newValue!;
                      });
                    },
                    items: repeatModeList
                        .map<DropdownMenuItem<String>>((selectedValue) {
                      return DropdownMenuItem<String>(
                        child: Text(selectedValue),
                        value: selectedValue,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 25),
                _buildColorPalette(),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildFAB(),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2060),
    );

    if (datePicker != null && datePicker != _selectedDate) {
      setState(() {
        _selectedDate = datePicker;
      });
    }
  }

  _getTimeFromUser(bool bool) async {
    var pickedTime = await _showTimePicker();
    String formatPickedTime = pickedTime!.format(context);
    if (bool == true) {
      setState(() => startingTime = formatPickedTime);
    }
    if (bool == false) {
      setState(() => endingTime = formatPickedTime);
    }
  }

  _showTimePicker() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(startingTime.split(':')[0]),
        minute: int.parse(startingTime.split(':')[1].split(' ')[0]),
      ),
      initialEntryMode: TimePickerEntryMode.input,
    );
  }

  _buildColorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(
              'Task Theme',
              style: TextStyle(
                color: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              onTap: () => setState(() => _selectedColor = index),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: index == 0
                      ? my_color.blue
                      : index == 1
                          ? my_color.pink
                          : my_color.yellow,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.radio_button_checked,
                          color: my_color.white,
                          size: 12,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.4),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildFAB() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: FloatingActionButton(
        onPressed: () => dataValidator(),
        backgroundColor: my_color.blue,
        child: const Icon(Icons.check, color: my_color.white),
      ),
    );
  }

  dataValidator() async {
    if (titleController.text.isNotEmpty) {
      // _addTaskToDB();
      Get.back();
      await Future.delayed(const Duration(milliseconds: 600));
      _showBottomToast(
        message: 'Task created successfully',
        icon: Icons.check,
        color: my_color.blue,
      );
    } else if (titleController.text.isEmpty) {
      _showBottomToast(
        message: 'Title can not be empty',
        icon: Icons.warning_amber_outlined,
        color: my_color.pink,
      );
    }
  }

  _showBottomToast({
    required String message,
    required IconData icon,
    required Color color,
  }) {
    toast.showToast(
      child: CustomToastMessage(message: message, icon: icon, color: color),
      gravity: ToastGravity.BOTTOM,
      fadeDuration: 400,
      toastDuration: const Duration(milliseconds: 1500),
    );
  }
}

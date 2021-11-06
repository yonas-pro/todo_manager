import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_manager/constants/app_colors.dart' as my_color;

AppBar customAppBar({
  required String title,
  required IconData icon,
  required BuildContext context,
  required VoidCallback onPressed,
}) {
  return AppBar(
    backgroundColor: context.theme.backgroundColor,
    automaticallyImplyLeading: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: Get.isDarkMode ? my_color.white : my_color.black,
          ),
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
        onPressed: onPressed,
        icon: Icon(icon, color: my_color.blue),
      ),
    ],
  );
}

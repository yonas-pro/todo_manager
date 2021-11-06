import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_manager/constants/app_colors.dart' as my_color;

class CustomToastMessage extends StatelessWidget {
  const CustomToastMessage({
    Key? key,
    this.message,
    this.color,
    this.icon,
  }) : super(key: key);

  final String? message;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
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
            message ?? '',
            style: TextStyle(
              color: Get.isDarkMode ? my_color.black : my_color.white,
            ),
          ),
        ],
      ),
    );
  }
}

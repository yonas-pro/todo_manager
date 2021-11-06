import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_manager/constants/app_colors.dart' as my_color;

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.widget,
    this.hintText,
    this.text,
    this.controller,
  }) : super(key: key);
  final String? labelText;
  final Widget? widget;
  final String? hintText;
  final String? text;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        widget == null
            ? const SizedBox()
            : Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    text!,
                    style: TextStyle(
                      color:
                          Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 5),
        SizedBox(
          height: 45,
          child: TextFormField(
            controller: controller,
            readOnly: widget == null ? false : true,
            decoration: InputDecoration(
              labelText: widget == null ? labelText : null,
              labelStyle: const TextStyle(color: Colors.grey),
              hintText: hintText ?? '',
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Get.isDarkMode
                      ? my_color.black.withOpacity(0.5)
                      : my_color.black.withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Get.isDarkMode
                      ? my_color.blue.withOpacity(0.3)
                      : my_color.blue.withOpacity(0.6),
                ),
              ),
              suffixIcon: widget ?? const SizedBox(),
            ),
            style: TextStyle(
              color: Get.isDarkMode ? Colors.grey : Colors.grey[700],
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

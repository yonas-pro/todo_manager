import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_manager/constants/app_color.dart' as color;
import 'package:todo_manager/services/theme_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            ThemeService().changeTheme();
          },
          icon: Icon(
            Icons.lightbulb,
            color: Get.isDarkMode ? color.white : color.black,
          ),
        ),
      ),
      body: const Center(
        child: Text('Testing'),
      ),
    );
  }
}

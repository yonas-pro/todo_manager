import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_manager/screens/home_screen.dart';
import 'package:todo_manager/services/theme_service.dart';
import 'package:todo_manager/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo manager',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().currentTheme,
      home: const HomeScreen(),
    );
  }
}

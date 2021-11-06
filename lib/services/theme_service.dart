import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final GetStorage localStorage = GetStorage();
  final String themeKey = '';

  bool getThemeFromLocalStorage() {
    return localStorage.read(themeKey) ?? false;
  }

  ThemeMode get currentTheme {
    return getThemeFromLocalStorage() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(
      getThemeFromLocalStorage() ? ThemeMode.light : ThemeMode.dark,
    );
    saveNewThemeMode(!getThemeFromLocalStorage());
  }

  Future<void> saveNewThemeMode(bool themeStatus) {
    return localStorage.write(themeKey, themeStatus);
  }
}

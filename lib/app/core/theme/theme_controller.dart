import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppThemeController extends GetxService {
  late GetStorage themeBox;

  Rx<ThemeMode?> currentThemeMode = Rx(ThemeMode.system);

  final String _themeBoxName = 'themeBoxName';
  final String _currThemeMode = 'currentTheme';

  setUpDb() async {
    themeBox = GetStorage(_themeBoxName);
    await fetchCurrentTheme();
  }

  fetchCurrentTheme() {
    String? selected = themeBox.read<String>(_currThemeMode);

    switch (selected) {
      case 'ThemeMode.light':
        currentThemeMode.value = ThemeMode.light;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        currentThemeMode.value = ThemeMode.dark;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark
              .copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        currentThemeMode.value = ThemeMode.system;
        return ThemeMode.system;
      default:
        currentThemeMode.value = ThemeMode.light;
        return ThemeMode.light;
    }
  }

  toggleTheme(ThemeMode themeMode) async {
    // print('currentThemeMode: $currentThemeMode');

    if (themeMode == currentThemeMode.value) {
      // print('same theme');
      return;
    }

    currentThemeMode.value = themeMode;

    Get.changeThemeMode(themeMode);

    if (currentThemeMode.value == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark,
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light,
      );
    }

    themeBox.write(_currThemeMode, currentThemeMode.value.toString());
  }
}

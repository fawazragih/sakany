import 'package:flutter/material.dart';

class LightThemeAppColors {
  LightThemeAppColors._();

  /// light theme colors
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color primaryColorLight = Color(0xFFEAF4FF);
  // static const Color primaryColorLight = Color(0xFF2c6ae3);
  static const Color primaryColorDark = Color(0xFFD18546);

  static const Color scaffoldBgColor = Color(0xFFF7F7F9);

  /// Scheme colors
  // static const Color primaryScheme = Color(0xFF0971CE);
  // static const Color primaryScheme = Color(0xffa8ad92);
  static const Color primaryScheme = Color(0xFFD18546);
  static const Color secondaryScheme = Color(0xffe3f1ff);

  // static const Color secondaryScheme = Color(0xFFec9b25);
  static const Color cardColor = Color(0xFFFFFFFF);
  static Color dividerColor = Colors.grey.shade300;
  static Color newGreyColor100 = Colors.grey.shade100;
  // static const Color surfaceScheme = Color(0xff000000);
  // static const Color surfaceTintScheme = Color(0xff545454);
  // static const Color primaryContainer = Color(0xfffff0cc);
  // static const Color secondaryContainer = Color(0xfffbe0dc);
  // static const Color surfaceVariant = Color(0xfffed390);
  // static const Color surfaceTintScheme = Color(0xff000000);
  // static const Color surfaceTintScheme = Color(0xff6c6d70);
  // static const Color backGroundScheme = Color(0xfffedaa9);

  ///..
  // static const Color iconColor = Color(0xFF000000);

  static const Color iconColor = primaryColorDark;

  ///..
  static const Color green = Color(0xff027548);
  static const Color greenLight = Color(0xffD9F2F3);

  ///...
  static const Color disabledColor = Color(0xff666C73);

  /// hint colors
  static const Color hintColor = Color(0xffacb8c2);

  ///...
  // static const Color secondaryHeaderColor = Color(0xFF8A86E2);

  ///... text colors
  static const Color mainTextColor = Color(0xFF000000);

  // static const Color captionTextColor = primaryScheme;

  ///... input fill colors
  static const Color inputFillColor = Color(0xFFF5F6F6);

  /// light theme colors .....................................................

  ///...changing Color functions
  static Color changeColorHue(Color color, {double value = 0.5}) =>
      HSLColor.fromColor(color).withHue(value).toColor();

  static Color changeColorSaturation(Color color, {double value = 0.5}) =>
      HSLColor.fromColor(color).withSaturation(value).toColor();

  static Color changeColorLightness(Color color, {double value = 0.9}) =>
      HSLColor.fromColor(color).withLightness(value).toColor();
}

class DarkThemeAppColors {
  DarkThemeAppColors._();

  /// dark theme colors
  static const Color mainDark = Color(0xFF202738);
  static const Color secondDark = Color(0xFF2B3347);
  static const Color thirdDark = Color(0xff566F8C);
  static const Color buttonDark = Color(0xFF174272);

  /// Scheme colors
  static const Color primaryScheme = Color(0xFF0971CE);
  static const Color secondaryScheme = Color(0xffe3f1ff);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFFFFFFF);

  ///..
  static const Color green = Color(0xff027548);
  static const Color greenLight = Color(0xffD9F2F3);

  ///...
  static const Color disabledColor = Color(0xff666C73);
}

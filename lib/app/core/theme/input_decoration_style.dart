import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/core/theme/app_themes_helper.dart';

import 'app_colors.dart';

class AppInputDecorationStyle {
  /// inputs style
  static const EdgeInsets inputFromWidgetPadding = EdgeInsets.all(14.0);
  // static const EdgeInsets? inputFromWidgetPadding = null;
  static const double inputFromWidgetRadius = 12.0;
  static const bool isFill = true;
  static const bool isBorder = false;
  static const Color iconColor = LightThemeAppColors.iconColor;

  static TextStyle get textStyle => Get.textTheme.titleSmall!.copyWith(
        height: 1.5,
        // fontFamily: SharedStyle.inputFontFamily,
        // color: Get.theme.primaryColorLight,
      );

  static TextStyle get hintStyle => Get.textTheme.titleSmall!.copyWith(
        // height: 1.5,
        fontFamily: AppThemesHelper.appFontFamily,
        color: Get.theme.hintColor,
      );

  static TextStyle get labelStyle => Get.textTheme.titleSmall!.copyWith(
        height: 1.5,
        fontSize: 14,
        color: Get.theme.hintColor,
      );

  static BorderSide borderSide = BorderSide(
    color: Get.theme.colorScheme.primary.withOpacity(0.2),
    width: 0.5,
  );

  // static const String inputFontFamily = AppFonts.cairo;

  // /// initial border
  static InputBorder focusedBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Get.theme.colorScheme.primary,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(inputFromWidgetRadius),
  );

  static InputBorder normalBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Get.theme.dividerColor,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(inputFromWidgetRadius),
  );

  // ///.. focused border
  // static InputBorder focusedBorder = OutlineInputBorder(
  //   borderSide: const BorderSide(
  //     color: AppColors.secondaryScheme,
  //   ),
  //   borderRadius: BorderRadius.circular(inputFromWidgetRadius),
  // );

  ///.. theme border
  static get theme => InputDecorationTheme(
        fillColor: LightThemeAppColors.inputFillColor,
        // enabledBorder: enabledBorder,
        // focusedBorder: focusedBorder,
        border: normalBorder,
        enabledBorder: normalBorder,
        focusedBorder: focusedBorder,
        hintStyle: hintStyle,
        // errorBorder: UnderlineInputBorder(
        //   borderRadius: BorderRadius.circular(inputFromWidgetRadius),
        //   borderSide: BorderSide(
        //     color: Colors.red.shade900,
        //   ),
        // ),
        // iconColor: AppColors.secondaryScheme,
        iconColor: iconColor,
        // prefixIconColor: AppColors.surfaceTintScheme.withOpacity(0.5),
        prefixIconColor: iconColor,
        // suffixIconColor: AppColors.surfaceTintScheme.withOpacity(0.5),
        suffixIconColor: iconColor,
      );
}

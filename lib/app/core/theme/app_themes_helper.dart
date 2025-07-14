import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../global_widget/app_ui_helper/shared_style.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'input_decoration_style.dart';

class AppThemesHelper {
  static String appFontFamily = AppFonts.appFontFamily;

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: appFontFamily,
    primaryColor: LightThemeAppColors.primaryColor,
    canvasColor: LightThemeAppColors.primaryColor,
    primaryColorLight: LightThemeAppColors.primaryColorLight,
    primaryColorDark: LightThemeAppColors.primaryColorDark,
    // scaffoldBackgroundColor: LightThemeAppColors.scaffoldBgColor,
    // secondaryHeaderColor: AppColors.secondaryHeaderColor,
    // highlightColor: AppColors.highlightColor,
    disabledColor: LightThemeAppColors.disabledColor,
    // highlightColor: AppColors.lightAccent,
    // toggleableActiveColor: AppColors.secondaryScheme,
    // dividerTheme: DividerThemeData(
    //   color: AppColors.primaryScheme.withOpacity(0.1),
    // ),
    dividerColor: LightThemeAppColors.dividerColor,
    dividerTheme: DividerThemeData(
      color: LightThemeAppColors.dividerColor,
    ),
    // dialogBackgroundColor: AppColors.lightThemePrimaryColorDark,
    dialogTheme: DialogThemeData(
      // backgroundColor: AppColors.lightThemePrimaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    shadowColor: Colors.grey.withOpacity(0.5),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(LightThemeAppColors.green),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: LightThemeAppColors.disabledColor),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
          bottom: Radius.circular(18),
        ),
      ),
      backgroundColor: LightThemeAppColors.primaryColorDark,
      foregroundColor: LightThemeAppColors.primaryColor,
    ),
    iconTheme: const IconThemeData(
      color: LightThemeAppColors.iconColor,
    ),
    primaryIconTheme: const IconThemeData(
      color: LightThemeAppColors.iconColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 28.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),

    brightness: Brightness.light,
    focusColor: LightThemeAppColors.primaryScheme,
    inputDecorationTheme: AppInputDecorationStyle.theme,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LightThemeAppColors.primaryScheme,
      ),
    ),
    hintColor: LightThemeAppColors.hintColor,
    bottomSheetTheme: const BottomSheetThemeData(
      clipBehavior: Clip.antiAlias,
      backgroundColor: LightThemeAppColors.primaryColorLight,
      modalBackgroundColor: LightThemeAppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            24,
          ),
        ),
      ),
    ),
    // textSelectionTheme: const TextSelectionThemeData(
    //   cursorColor: AppColors.mainLight,
    //   selectionHandleColor: AppColors.mainLight,
    //   // selectionColor: AppColors.grey4,
    // ),
    cardColor: LightThemeAppColors.cardColor,
    cardTheme: const CardThemeData(
      elevation: 0.0,
      color: LightThemeAppColors.cardColor,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: SharedStyle.contentCardBorderRadius,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w300,
      ),
      displayMedium: TextStyle(
        fontSize: 60.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w300,
      ),
      displaySmall: TextStyle(
        fontSize: 48.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 34.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0.sp,
        color: Colors.black,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0.sp,
        color: LightThemeAppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w300,
      ),
      labelSmall: TextStyle(
        fontSize: 10.0.sp,
        // color: AppColors.mainTextColor,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: const ColorScheme.light(
      // seedColor: LightThemeAppColors.primaryScheme,
      primary: LightThemeAppColors.primaryScheme,
      secondary: LightThemeAppColors.secondaryScheme,
      // surface: LightThemeAppColors.primaryColor,
      // // surfaceTint: AppColors.surfaceTintScheme,
      // primaryContainer: LightThemeAppColors.primaryColor,
      // secondaryContainer: LightThemeAppColors.primaryColor,
      // // surfaceVariant: AppColors.surfaceVariant,
      // // tertiary: AppColors.green
      // background: LightThemeAppColors.primaryColor,
    ),
  );

  ///.... dark theme ....................................
  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    fontFamily: appFontFamily,
    primaryColor: DarkThemeAppColors.mainDark,
    primaryColorLight: DarkThemeAppColors.secondDark,
    primaryColorDark: DarkThemeAppColors.secondDark,
    canvasColor: DarkThemeAppColors.mainDark,
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
    ),
    shadowColor: DarkThemeAppColors.primaryScheme.withOpacity(0.2),
    dialogTheme: DialogThemeData(
      backgroundColor: DarkThemeAppColors.mainDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(DarkThemeAppColors.green),
    ),
    appBarTheme: lightTheme.appBarTheme.copyWith(
      iconTheme: const IconThemeData(color: DarkThemeAppColors.disabledColor),
      elevation: 0.0,
      backgroundColor: DarkThemeAppColors.mainDark,
      centerTitle: true,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.vertical(bottom: Radius.circular(18))),
      titleTextStyle: const TextStyle(color: DarkThemeAppColors.disabledColor),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    inputDecorationTheme: AppInputDecorationStyle.theme,
    scaffoldBackgroundColor: DarkThemeAppColors.mainDark,
    cardColor: DarkThemeAppColors.mainDark,
    applyElevationOverlayColor: true,
    dividerColor: DarkThemeAppColors.primaryScheme.withOpacity(0.1),
    focusColor: DarkThemeAppColors.primaryScheme,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DarkThemeAppColors.primaryScheme,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 96.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w300,
      ),
      displayMedium: TextStyle(
        fontSize: 60.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w300,
      ),
      displaySmall: TextStyle(
        fontSize: 48.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 34.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0.sp,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w300,
      ),
      labelSmall: TextStyle(
        fontSize: 10.0.sp,
        color: Colors.white,
        height: AppFonts.fontHeight,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: DarkThemeAppColors.primaryScheme,
      // surface: AppColors.secondDark,
      surface: DarkThemeAppColors.mainDark,
      secondary: DarkThemeAppColors.primaryScheme,
      primaryContainer: DarkThemeAppColors.primaryContainer,
    ) /*.copyWith(
      surface: DarkThemeAppColors.mainDark,
    )*/
    ,
  );
}

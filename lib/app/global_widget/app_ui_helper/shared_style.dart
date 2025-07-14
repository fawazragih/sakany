import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SharedStyle {
  SharedStyle._();

  /// textStyles
  static TextStyle mainTitleText({
    Color? color,
    bool light = false,
    bool headline4 = false,
    bool headline5 = true,
    bool bold = false,
    double? fontSize,
    double? height,
    double? letterSpacing,
  }) {
    if (headline4) {
      return Get.textTheme.headlineMedium!.copyWith(
        color: color ??
            (!light
                ? Get.textTheme.headlineSmall!.color
                : Get.theme.primaryColor),
        fontWeight: bold ? FontWeight.bold : null,
        fontSize: fontSize ?? 34.sp,
        height: height ?? 1.5,
        letterSpacing: letterSpacing,
      );
    }
    return Get.textTheme.headlineSmall!.copyWith(
      color: color ??
          (!light
              ? Get.textTheme.headlineSmall!.color
              : Get.theme.primaryColor),
      fontWeight: bold ? FontWeight.bold : null,
      fontSize: fontSize ?? 24.sp,
      height: height ?? 1.5,
    );
  }

  static TextStyle? subtitle2({
    bool bold = false,
    bool light = false,
    double? fontSizeWithSp,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? textDecoration,
  }) {
    return Get.textTheme.titleSmall?.copyWith(
      height: height ?? 1.0,
      fontSize: fontSizeWithSp ?? 12.sp,
      wordSpacing: wordSpacing ?? 0,
      letterSpacing: letterSpacing,
      decoration: textDecoration,
      color: color ?? (light ? Get.theme.scaffoldBackgroundColor : null),
      fontWeight: fontWeight ?? (bold ? FontWeight.bold : null),
    );
  }

  static TextStyle? bodyTextStyle({
    bool bold = false,
    bool light = false,
    double? fontSize,
  }) {
    return Get.textTheme.bodyMedium?.copyWith(
      // color: Get.theme.primaryColorLight,
      height: 1.5,
      fontSize: fontSize,
      color: light ? Get.theme.scaffoldBackgroundColor : null,
      fontWeight: bold ? FontWeight.bold : null,
    );
  }

  // static BoxDecoration containerGradient({
  //   AlignmentGeometry? end,
  //   AlignmentGeometry? begin,
  //   double? opacity,
  //   Color? color1,
  //   Color? color2,
  // }) {
  //   return BoxDecoration(
  //     gradient: LinearGradient(
  //       end: end ?? AlignmentDirectional.centerStart,
  //       begin: begin ?? AlignmentDirectional.centerEnd,
  //       colors: [
  //         color1 ?? Colors.grey.shade300.withOpacity(opacity ?? 1.0),
  //         color2 ?? Colors.grey.shade50.withOpacity(opacity ?? 1.0),
  //       ],
  //     ),
  //   );
  // }

  static double get horizontalScreenPadding =>
      Get.context!.isPhone ? 16.w : 40.w;

  static double get verticalScreenPadding => Get.context!.isPhone ? 16.w : 40.w;

  static EdgeInsetsGeometry get bottomNavigationPadding => EdgeInsets.symmetric(
        horizontal: horizontalScreenPadding,
        vertical: 12.0.h,
      );

  static EdgeInsetsGeometry singleChildScrollViewHorizontalPadding =
      EdgeInsets.symmetric(
    horizontal: horizontalScreenPadding,
    // vertical: horizontalScreenPadding,
  );

  /// shadow color
  static Color shadowColor = const Color(0xffa1d4ff).withOpacity(0.5);

  ///....
  static RoundedRectangleBorder get bottomSheetShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0.r)),
      );

  static RoundedRectangleBorder roundedRectangleBorder({
    double? radius,
    BorderRadiusGeometry? borderRadiusGeometry,
  }) {
    return RoundedRectangleBorder(
      borderRadius: borderRadiusGeometry ??
          BorderRadius.circular(
            radius ?? 16.0,
          ),
    );
  }

  static var inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.withOpacity(0.6)),
    borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
  );

  ///...border radius
  static const double radiusValue = 16.0;
  static const BorderRadius dialogBorderRadius = BorderRadius.all(
    Radius.circular(
      40,
    ),
  );

  static SmoothBorderRadius bottomSheetShapeBorderRadius =
      const SmoothBorderRadius.vertical(
    top: SmoothRadius(
      cornerRadius: 32,
      cornerSmoothing: 1,
    ),
  );

  static const BorderRadius contentCardBorderRadius = BorderRadius.all(
    Radius.circular(
      radiusValue,
    ),
  );
  static const BorderRadius settingsIconPadding = BorderRadius.all(
    Radius.circular(
      10.0,
    ),
  );

  static Decoration getCardDecoration({
    Color? color,
    bool hasBorder = true,
    double? cornerRadius,
    double? cornerSmoothing,
    double? borderWidth,
    Color? borderColor,
    Gradient? gradient,
    SmoothBorderRadius? borderRadius,
  }) =>
      ShapeDecoration(
        shape: SmoothRectangleBorder(
          borderRadius: borderRadius ??
              SmoothBorderRadius(
                cornerRadius: cornerRadius ?? 20.r,
                cornerSmoothing: cornerSmoothing ?? 1,
              ),
          side: hasBorder
              ? BorderSide(
                  width: borderWidth ?? 2.r,
                  color: borderColor ?? Get.theme.primaryColor,
                )
              : BorderSide.none,
        ),
        color: gradient != null ? null : color ?? Get.theme.cardColor,
        gradient: gradient,
      );

  // static const BorderRadiusGeometry mainContainerBorderRadius =
  //     BorderRadius.only(
  //         topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0),);

  ///..
  static EdgeInsetsGeometry dialogMargin = EdgeInsets.symmetric(
    horizontal: Get.context!.isPhone ? 24.w : 0.25.sw,
  );

  ///....
  /// padding
  ///
  static EdgeInsetsGeometry contentContainerPadding =
      EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h);

  ///
  static EdgeInsetsGeometry mainContainerElementsPadding =
      EdgeInsets.only(right: 15.0.w, left: 15.0.w, top: 25.0.h, bottom: 10.h);
  static EdgeInsetsGeometry containerElementsPadding =
      EdgeInsets.only(right: 15.0.w, left: 15.0.w, top: 0.0, bottom: 10.h);

  static EdgeInsetsGeometry drawerPadding =
      EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 10.0.h);
  static EdgeInsets requestItemPadding = EdgeInsets.symmetric(vertical: 10.0.h);
  static EdgeInsets cardPadding =
      EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w);
}

// import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UiHelper {
  UiHelper._();

  static final Size appBarSize = AppBar().preferredSize;

  //...
  static SizedBox verticalSpaceVeryTiny = SizedBox(height: 2.0.h);
  static SizedBox verticalSpaceTiny = SizedBox(height: 4.0.h);
  static SizedBox verticalSpaceSmall = SizedBox(height: 8.0.h);
  static SizedBox verticalSpaceSmallMedium = SizedBox(height: 12.0.h);
  static SizedBox verticalSpaceMedium = SizedBox(height: 16.0.h);

  static SizedBox verticalSpaceLarge = SizedBox(height: 24.0.h);
  static SizedBox verticalSpaceMassive = SizedBox(height: 32.0.h);

  static SizedBox verticalSpace(double height) => SizedBox(height: height.h);

  //...
  static SizedBox horizontalSpaceVeryTiny = SizedBox(width: 2.0.w);
  static SizedBox horizontalSpaceTiny = SizedBox(width: 4.0.w);
  static SizedBox horizontalSpaceSmall = SizedBox(width: 8.0.w);
  static SizedBox horizontalSpaceSmallMedium = SizedBox(width: 12.0.w);
  static SizedBox horizontalSpaceMedium = SizedBox(width: 16.0.w);
  static SizedBox horizontalSpaceLarge = SizedBox(width: 24.0.w);
  static SizedBox horizontalSpaceMassive = SizedBox(width: 32.0.w);

  static SizedBox horizontalSpace(double width) => SizedBox(width: width.w);



  static Widget spaceDivider(
      {double? verticalPadding = 0, double? horizontalPadding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? 0),
      child: Divider(
          color: Get.isDarkMode ? Colors.blueGrey.shade600 : Colors.black26,
          thickness: 0.5.h,
          height: 5.0),
    );
  }

  // static Widget loadingAnimation() {
  //   return Center(
  //     child: Container(
  //         child: Lottie.asset('assets/animation/loading.json',
  //             fit: BoxFit.cover, width: 60, height: 60)),
  //   );
  // }

  static Widget spinKitProgressIndicator({double? size, Color? color}) {
    return LoadingAnimationWidget.inkDrop(
      color: color ?? Get.theme.colorScheme.primary,
      size: size ?? 50,
    );
    // return SpinKitRipple(
    //   color: color ?? Get.theme.colorScheme.primary,
    //   size: size ?? 50.r,
    // );
  }

  static Widget horizontalSpaceSpinKitProgressIndicator(
      {double? size, Color? color}) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? Get.theme.colorScheme.primary,
      size: size ?? 50,
    );
    // return SpinKitRipple(
    //   color: color ?? Get.theme.colorScheme.primary,
    //   size: size ?? 50.r,
    // );
  }

// static final RandomColor _randomColor = RandomColor();
//
// static Color getRandomColor({List<ColorHue>? colorHues}) {
//   return _randomColor.randomColor(
//     colorBrightness: ColorBrightness.dark,
//     colorHue: ColorHue.multiple(
//       colorHues: colorHues ??
//           [
//             ColorHue.purple,
//             // ColorHue.red,
//             ColorHue.pink,
//             ColorHue.orange,
//             ColorHue.yellow,
//           ],
//       // random: Random(290),
//     ),
//     // colorHue: ColorHue.custom(Range(270, 300)),
//     // colorHue: ColorHue.purple,
//     colorSaturation: ColorSaturation.highSaturation,
//   );
// }
}

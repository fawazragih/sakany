import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/language_and_localization/app_strings.dart';
import 'app_ui_helper/ui_helpers.dart';

class LoadingProgressBar extends StatelessWidget {
  const LoadingProgressBar({
    super.key,
    this.color,
    this.size = 45,
    this.inHorizontal = false,
    this.withLoadingText = true,
    this.text,
  });

  final Color? color;
  final bool inHorizontal;
  final double size;
  final bool withLoadingText;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        inHorizontal
            ? UiHelper.horizontalSpaceSpinKitProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
                size: size,
              )
            : UiHelper.spinKitProgressIndicator(
                color: color ?? Theme.of(context).colorScheme.primary,
                size: size,
              ),
        if (withLoadingText && !inHorizontal) ...[
          UiHelper.verticalSpaceMassive,
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                text ?? AppStrings.loading.tr.capitalizeFirst!,
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                colors: [
                  color ?? Get.theme.colorScheme.primary,
                  Colors.white30,
                  Colors.white24,
                ],
              ),
              ColorizeAnimatedText(
                AppStrings.pleaseWait.tr.capitalizeFirst!,
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                colors: [
                  color ?? Get.theme.colorScheme.primary,
                  Colors.white30,
                  Colors.white24,
                ],
              ),
            ],
            pause: const Duration(microseconds: 100),
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ],
      ],
    );
  }
}

class AppProgressDialogWidget extends StatelessWidget {
  final Widget? progressIcon;

  const AppProgressDialogWidget({
    super.key,
    required this.progressMessage,
    this.progressIcon,
  });

  final RxString progressMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 0.08.sh,
      width: 0.2.sw,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.verticalSpaceLarge,
          progressIcon ?? UiHelper.spinKitProgressIndicator(size: 50),
          // SpinKitDoubleBounce(
          //   color: Get.theme.colorScheme.primary,
          //   size: 100,
          //   // lineWidth: 4,
          // ),
          UiHelper.verticalSpaceLarge,
          Obx(() {
            return AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  progressMessage.value,
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Get.theme.colorScheme.primary,
                    Colors.white30,
                    Colors.white24,
                  ],
                ),
                ColorizeAnimatedText(
                  AppStrings.pleaseWait.tr.capitalizeFirst!,
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Get.theme.primaryColorDark,
                    Colors.white30,
                    Colors.white24,
                  ],
                ),
              ],
              pause: const Duration(microseconds: 100),
              isRepeatingAnimation: true,
              repeatForever: true,
            );
          }),
          UiHelper.verticalSpaceLarge,
        ],
      ),
    );
  }
}

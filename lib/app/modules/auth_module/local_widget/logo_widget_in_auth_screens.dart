import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/assets_helpers/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';

class LogoWidgetInAuthScreens extends StatelessWidget {
  final bool isSignUp;
  const LogoWidgetInAuthScreens({
    super.key,
    this.isSignUp = false,
  });

  // double get headLineFontSize => Get.context!.isTablet ? 32.sp : 24.sp;
  double get headLineFontSize => 24.sp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BounceInDown(
        delay: const Duration(milliseconds: 800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                AppImages.logoPng,
              ),
            ),
            UiHelper.verticalSpaceMassive,
            // Text(
            //   AppStrings.heyWelcomeBack.tr.capitalizeFirst!,
            //   textAlign: TextAlign.start,
            //   style: SharedStyle.subtitle2(
            //     height: 1,
            //     letterSpacing: 2,
            //     bold: true,
            //     fontSizeWithSp: headLineFontSize,
            //   ),
            // ),
            // UiHelper.verticalSpaceMedium,
            // Text(
            //   AppStrings.pleaseFillInHereDetailsToGetToYourAccount.tr
            //       .capitalizeFirst!,
            //   textAlign: TextAlign.start,
            //   style: SharedStyle.subtitle2(
            //     height: 1,
            //     fontSizeWithSp: 14.sp,
            //   ),
            // ),

            if (isSignUp) ...[
              Text.rich(
                TextSpan(
                  text: AppStrings.hey.tr.capitalizeFirst!,
                  style: SharedStyle.subtitle2(
                    height: 1,
                    fontSizeWithSp: headLineFontSize,
                  ),
                  children: [
                    TextSpan(
                      text: ',',
                      style: SharedStyle.subtitle2(
                        fontSizeWithSp: headLineFontSize,
                        height: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: AppStrings.signUpNow.tr.capitalizeFirst!,
                  style: SharedStyle.subtitle2(
                    fontSizeWithSp: headLineFontSize,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: '.',
                      style: SharedStyle.subtitle2(
                        fontSizeWithSp: headLineFontSize,
                        height: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
             Text.rich(
                TextSpan(
                  text: AppStrings.hey.tr.capitalizeFirst!,
                  style: SharedStyle.subtitle2(
                    height: 1,
                    fontSizeWithSp: headLineFontSize,
                  ),
                  children: [
                    TextSpan(
                      text: ',',
                      style: SharedStyle.subtitle2(
                        fontSizeWithSp: headLineFontSize,
                        height: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: AppStrings.loginNow.tr.capitalizeFirst!,
                  style: SharedStyle.subtitle2(
                    fontSizeWithSp: headLineFontSize,
                    height: 1.3,
                  ),
                  children: [
                    TextSpan(
                      text: '.',
                      style: SharedStyle.subtitle2(
                        fontSizeWithSp: headLineFontSize,
                        height: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              // UiHelper.verticalSpaceLarge,
              // Row(
              //   children: [
              //     AutoSizeText(
              //       AppStrings.ifYouAreNew.tr.capitalizeFirst!,
              //       style: SharedStyle.subtitle2(
              //         fontSizeWithSp: 16.sp,
              //       ),
              //     ),
              //     UiHelper.horizontalSpaceTiny,
              //     InkWell(
              //       onTap: () => Get.toNamed(
              //         SignupScreen.routeName,
              //       ),
              //       child: AutoSizeText(
              //         AppStrings.signup.tr.capitalize!,
              //         style: SharedStyle.subtitle2(
              //           fontSizeWithSp: 16.sp,
              //           color: Theme.of(context).colorScheme.primary,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../signup_screen/signup_screen.dart';

class DoNotAndAlreadyHaveAccountWidget extends StatelessWidget {
  final bool inSignUpScreen;

  const DoNotAndAlreadyHaveAccountWidget({
    super.key,
    this.inSignUpScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          inSignUpScreen
              ? AppStrings.alreadyHaveAnAccount.tr.capitalizeFirst!
              : AppStrings.doNotHaveAnAccount.tr.capitalizeFirst!,
          style: Get.textTheme.titleSmall!.copyWith(
            height: 1.0,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () =>
              inSignUpScreen ? Get.back() : Get.toNamed(SignupScreen.routeName),
          child: Text(
            inSignUpScreen
                ? AppStrings.login.tr.capitalizeFirst!
                : AppStrings.signup.tr.capitalizeFirst!,
            style: Get.textTheme.titleSmall!.copyWith(
              color: Get.theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              height: 3,
            ),
          ).paddingSymmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
        ),
      ],
    );
  }
}

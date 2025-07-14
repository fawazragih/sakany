import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widget/action_buttons/action_button.dart';
import '../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';
import '../login_screen/login_view.dart';

class SuccessSentForgetPassEmail extends StatelessWidget {
  const SuccessSentForgetPassEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 16.0,
          ).copyWith(bottom: 20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          child: Text(
            AppStrings.resetNewPasswordSentToYourEmail.tr.capitalizeFirst!,
            textAlign: TextAlign.justify,
            style: SharedStyle.subtitle2(
              fontSizeWithSp: 14.0.sp,
              height: 1.5,
              bold: true,
            ),
          ),
        ),
        UiHelper.verticalSpaceSmall,
        ActionButton(
          text: AppStrings.backToLogin.tr.capitalizeFirst!,
          onPressed: () => Get.until(
            ModalRoute.withName(LoginScreen.routeName),
          ),
        ),
      ],
    );
  }
}

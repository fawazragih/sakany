import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widget/action_buttons/action_button.dart';
import '../../../global_widget/bottome_sheet_widgets/bottom_sheet_title.dart';
import '../../../global_widget/all_form_widgets/password_input.dart';
import '../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';
import 'reset_password_controller.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            54,
          ),
        ),
      ),
      margin: SharedStyle.singleChildScrollViewHorizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetTitle(
              title: AppStrings.changePassword.tr.capitalizeFirst!,
            ),
            UiHelper.verticalSpaceLarge,
            // UiHelper.verticalSpaceLarge,
            GetBuilder<ResetPasswordController>(
              init: ResetPasswordController(),
              builder: (controller) {
                return FormBuilder(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PasswordInput(
                        keyName: AppStrings.currentPassword,
                        hintText:
                            AppStrings.currentPassword.tr.capitalizeFirst!,
                        labelText:
                            AppStrings.currentPassword.tr.capitalizeFirst,
                        confirmHintText:
                            AppStrings.currentPasswordHint.tr.capitalizeFirst!,
                        isSignUp: false,
                      ),
                      UiHelper.verticalSpaceMedium,
                      PasswordInput(
                        keyName: AppStrings.newPassword,
                        hintText: AppStrings.newPassword.tr.capitalizeFirst!,
                        labelText: AppStrings.newPassword.tr.capitalizeFirst,
                        confirmHintText: AppStrings
                            .newPasswordConfirmHint.tr.capitalizeFirst!,
                        confirmLabelText:
                            AppStrings.newPasswordConfirm.tr.capitalizeFirst!,
                        confirmKeyName: AppStrings.newPasswordConfirm,
                        isSignUp: true,
                      ),
                      UiHelper.verticalSpaceLarge,
                      ActionButton(
                        btnController: controller.btnController,
                        text: AppStrings.confirmAndSend.tr.capitalizeFirst,
                        onPressed: controller.onSBTab,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ).paddingSymmetric(
          horizontal: 48,
          vertical: 54,
        ),
      ),
    );
  }
}

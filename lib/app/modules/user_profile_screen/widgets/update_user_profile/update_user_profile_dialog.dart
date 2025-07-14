import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/user_login_response.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../../global_widget/app_ui_helper/ui_helpers.dart';
import '../../../../global_widget/loading_progress_bar.dart';
import '../../../../global_widget/my_card_design.dart';
import 'update_user_profile_controller.dart';

class UpdateUserProfileDialog extends StatelessWidget {
  final CustomerInfo? initialValue;

  const UpdateUserProfileDialog({
    super.key,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: SharedStyle.dialogMargin,
            shape: const RoundedRectangleBorder(
              borderRadius: SharedStyle.dialogBorderRadius,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiHelper.verticalSpaceMassive,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.updateProfile.tr.capitalizeFirst!,
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    UiHelper.horizontalSpaceMedium,
                    AppCard(
                      color: Theme.of(context).primaryColorLight,
                      onTap: () {
                        Get.close(1);
                      },
                      child: Icon(
                        Icons.close,
                        // size: 24.r,
                      ),
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 24,
                ),
                UiHelper.verticalSpaceLarge,
                GetBuilder<UpdateUserProfileController>(
                  init: UpdateUserProfileController(),
                  builder: (controller) {
                    return controller.isUploadingData
                        ? LoadingProgressBar(
                            text: controller.isUploadingData
                                ? AppStrings.loading.tr.capitalizeFirst!
                                : null,
                          ).paddingOnly(
                            bottom: 12,
                          )
                        : UpdateUserProfileForm(
                            controller: controller,
                            initialValue: initialValue,
                          );
                  },
                ).marginSymmetric(
                  horizontal: 24,
                  vertical: 8.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateUserProfileForm extends StatelessWidget {
  const UpdateUserProfileForm({
    super.key,
    required this.controller,
    this.initialValue,
  });

  final CustomerInfo? initialValue;
  final UpdateUserProfileController controller;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        /*children: [
          ImagePickerFormBuilderField(
            keyName: AppStrings.imageToUpload,
            shape: ImagePickerWidgetShape.circle,
            initialImage: initialValue?.imageUrl,
          ),
          UiHelper.verticalSpaceMedium,
          InputTextFieldWidget(
            keyName: AppStrings.name,
            labelText: AppStrings.name.tr.capitalizeFirst,
            hintText: AppStrings.name.tr.capitalizeFirst,
            initialValue: initialValue?.firstName,
          ),
          UiHelper.verticalSpaceMedium,
          FutureBuilder(
            future: initialValue?.phone == null
                ? null
                : PhoneNumber.getRegionInfoFromPhoneNumber(
                    initialValue!.phone!.trim()),
            builder: (context, AsyncSnapshot<PhoneNumber> snapshot) {
              var initialPhoneNum = snapshot.data;
              return PhoneInputWidget(
                // key: UniqueKey(),
                keyName: AppStrings.phoneNum,
                isRequired: true,
                fillColor: Get.theme.primaryColor,
                // inputBorder: SharedStyle.inputBorder,
                hintText: AppStrings.phoneNumHint.tr.capitalizeFirst!,
                initialValue: initialPhoneNum,
              );
            },
          ),
          UiHelper.verticalSpaceLarge,
          CancelOrSubmitDialogRowWidget(
            onSubmit: controller.onSubmit,
            submitText: initialValue == null
                ? null
                : AppStrings.update.tr.capitalizeFirst!,
          ),
        ],*/
      ),
    );
  }
}

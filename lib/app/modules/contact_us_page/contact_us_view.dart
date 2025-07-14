import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import 'contact_us_controller.dart';

class ContactUsPage extends GetView<ContactUsController> {
  static const String routeName = '/app/contact-us';

  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.MORE_CONTACT_US.translate,
      ),
      body: GetBuilder<ContactUsController>(builder: (controller) {
        return ScreenStatusWidgets(
          controller: controller,
          isEmpty: controller.formData == null,
          onRetry: controller.fetchFormData,
          dataWidget: SingleChildScrollView(
            padding: SharedStyle.singleChildScrollViewHorizontalPadding.add(
              EdgeInsets.symmetric(
                vertical: SharedStyle.verticalScreenPadding,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      InputTextFieldWidget(
                        keyName: ConstStrings.CONTACT_US_FULLNAME,
                        labelText: ConstStrings.CONTACT_US_FULLNAME.translate,
                        hintText: ConstStrings.CONTACT_US_FULLNAME.translate,
                        keyboardType: TextInputType.name,
                        requiredValidatorText:
                            ConstStrings.CONTACT_US_REQUIRED_FULLNAME.translate,
                        onChanged: (value) =>
                            controller.formData?.fullName = value,
                        onSaved: (value) =>
                            controller.formData?.fullName = value,
                        initialValue: controller.formData?.fullName ?? '',
                        textInputAction: TextInputAction.next,
                      ),
                      InputTextFieldWidget(
                        keyName: ConstStrings.CONTACT_US_EMAIL,
                        labelText: ConstStrings.CONTACT_US_EMAIL.translate,
                        hintText: ConstStrings.CONTACT_US_EMAIL.translate,
                        keyboardType: TextInputType.emailAddress,
                        requiredValidatorText:
                            ConstStrings.CONTACT_US_REQUIRED_EMAIL.translate,
                        onChanged: (value) =>
                            controller.formData?.email = value,
                        onSaved: (value) => controller.formData?.email = value,
                        initialValue: controller.formData?.email ?? '',
                        textInputAction: TextInputAction.next,
                      ),
                      if (controller.formData?.subjectEnabled == true)
                        InputTextFieldWidget(
                          keyName: ConstStrings.CONTACT_US_SUBJECT,
                          labelText: ConstStrings.CONTACT_US_SUBJECT.translate,
                          hintText: ConstStrings.CONTACT_US_SUBJECT.translate,
                          keyboardType: TextInputType.text,
                          onChanged: (value) =>
                              controller.formData?.subject = value,
                          onSaved: (value) =>
                              controller.formData?.subject = value,
                          initialValue: controller.formData?.subject ?? '',
                          textInputAction: TextInputAction.next,
                          // decoration: inputDecor(ConstStrings.CONTACT_US_SUBJECT, true,context),
                        ),
                      InputTextFieldWidget(
                        keyName: ConstStrings.CONTACT_US_ENQUIRY,
                        labelText: ConstStrings.CONTACT_US_ENQUIRY.translate,
                        hintText: ConstStrings.CONTACT_US_ENQUIRY.translate,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        requiredValidatorText:
                            ConstStrings.CONTACT_US_REQUIRED_ENQUIRY.translate,
                        onChanged: (value) =>
                            controller.formData?.enquiry = value,
                        onSaved: (value) =>
                            controller.formData?.enquiry = value,
                        initialValue: controller.formData?.enquiry ?? '',
                        textInputAction: TextInputAction.next,
                        // decoration: inputDecor(ConstStrings.CONTACT_US_ENQUIRY, true,context),
                      ),
                    ].withSpaceBetween(
                      height: 16.0.h,
                      includeBeforFirst: true,
                      includeAfterLast: true,
                    ),
                  ),
                ),
                UiHelper.verticalSpaceMedium,
                ActionButton(
                  text: ConstStrings.CONTACT_US_BUTTON.translate.toUpperCase(),
                  onPressed: controller.postEnquiry,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

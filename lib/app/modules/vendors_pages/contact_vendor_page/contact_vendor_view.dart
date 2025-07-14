import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';
import 'package:sakani/app/routes/app_routs_and_pages.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import 'contact_vendor_controller.dart';

class ContactVendorPage extends GetView<ContactVendorController> {
  const ContactVendorPage({super.key});

  static const String routeName = '/app/contact-vendor/:vendorId';

  static String navToRoute(String vendorId) =>
      '${routeName.removeParams}/$vendorId';

  @override
  Widget build(BuildContext context) {
    // _enquiryTextController.text = (formData.enquiry ?? '');

    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.VENDOR_CONTACT_VENDOR.translate,
      ),
      body: SingleChildScrollView(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding.add(
          EdgeInsets.symmetric(
            vertical: SharedStyle.verticalScreenPadding,
          ),
        ),
        child: GetBuilder<ContactVendorController>(
          builder: (controller) {
            return ScreenStatusWidgets(
              controller: controller,
              onRetry: controller.fetchFormData,
              isEmpty: controller.formData == null,
              dataWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        InputTextFieldWidget(
                          keyName: ConstStrings.VENDOR_REQUIRED_FULLNAME,
                          keyboardType: TextInputType.name,
                          autoFocus: false,
                          requiredValidatorText:
                              ConstStrings.VENDOR_REQUIRED_FULLNAME.translate,
                          onChanged: (value) =>
                              controller.formData?.fullName = value,
                          onSaved: (value) =>
                              controller.formData?.fullName = value,
                          initialValue: controller.formData?.fullName ?? '',
                          textInputAction: TextInputAction.next,
                          labelText: ConstStrings.VENDOR_FULLNAME.translate,
                          hintText: ConstStrings.VENDOR_FULLNAME.translate,
                          isRequired: true,
                          // decoration: inputDecor(
                          //     ConstStrings.VENDOR_FULLNAME, true, context),
                        ),
                        InputTextFieldWidget(
                          keyName: ConstStrings.VENDOR_EMAIL,
                          labelText: ConstStrings.VENDOR_EMAIL.translate,
                          hintText: ConstStrings.VENDOR_EMAIL.translate,
                          keyboardType: TextInputType.emailAddress,
                          autoFocus: false,
                          requiredValidatorText:
                              ConstStrings.VENDOR_REQUIRED_EMAIL.translate,
                          onChanged: (value) =>
                              controller.formData?.email = value,
                          onSaved: (value) =>
                              controller.formData?.email = value,
                          initialValue: controller.formData?.email ?? '',
                          textInputAction: TextInputAction.next,
                          // decoration: inputDecor(ConstStrings.VENDOR_EMAIL, true, context),
                        ),
                        if (controller.formData?.subjectEnabled == true)
                          InputTextFieldWidget(
                            keyName: ConstStrings.VENDOR_SUBJECT,
                            labelText: ConstStrings.VENDOR_SUBJECT.translate,
                            hintText: ConstStrings.VENDOR_SUBJECT.translate,
                            keyboardType: TextInputType.text,
                            autoFocus: false,
                            requiredValidatorText: ConstStrings
                                .VENDOR_REQUIRED_SUBJECT.translate,
                            onChanged: (value) =>
                                controller.formData?.subject = value,
                            onSaved: (value) =>
                                controller.formData?.subject = value,
                            initialValue: controller.formData?.subject ?? '',
                            textInputAction: TextInputAction.next,
                            // decoration: inputDecor(ConstStrings.VENDOR_SUBJECT, true, context),
                          ),
                        InputTextFieldWidget(
                          keyName: ConstStrings.VENDOR_ENQUIRY,
                          labelText: ConstStrings.VENDOR_ENQUIRY.translate,
                          hintText: ConstStrings.VENDOR_ENQUIRY.translate,
                          autoFocus: false,
                          // controller: _enquiryTextController,
                          initialValue: controller.formData?.enquiry ?? '',
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          requiredValidatorText:
                              ConstStrings.VENDOR_REQUIRED_ENQUIRY.translate,
                          onChanged: (value) =>
                              controller.formData?.enquiry = value,
                          onSaved: (value) =>
                              controller.formData?.enquiry = value,
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                  ),
                  UiHelper.verticalSpaceSmallMedium,
                  ActionButton(
                    text:
                        ConstStrings.CONTACT_US_BUTTON.translate.toUpperCase(),
                    onPressed: controller.submit,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    return Scaffold();
  }
}

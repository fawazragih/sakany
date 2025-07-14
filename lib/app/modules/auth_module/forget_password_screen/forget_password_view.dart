import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'success_sent_forget_pass_email.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widget/action_buttons/action_button.dart';
import '../../../global_widget/all_form_widgets/input_text_field_widget.dart';
import '../../../global_widget/app_bar_widgets/custom_app_bar.dart';
import '../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';
import '../../../global_widget/logo_widget.dart';
import 'forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = '/auth/ForgetPasswordScreen';

  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        // showLogoutIcon: false,
      ),
      body: GetBuilder<ForgetPasswordScreenController>(
        init: ForgetPasswordScreenController(),
        builder: (controller) {
          return Center(
            child: SingleChildScrollView(
              padding: SharedStyle.singleChildScrollViewHorizontalPadding,
              clipBehavior: Clip.antiAlias,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  controller.showSuccessEmailSent
                      ? const SuccessSentForgetPassEmail()
                      : EnterYourEmailWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EnterYourEmailWidget extends StatelessWidget {
  EnterYourEmailWidget({
    super.key,
  });

  final controller = Get.find<ForgetPasswordScreenController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideInUp(
          child: LogoWidget(
            text: AppStrings.forgetPassword.tr.capitalizeFirst!,
          ),
        ),
        UiHelper.verticalSpaceMassive,
        SlideInUp(
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                UiHelper.verticalSpaceSmall,
                InputTextFieldWidget(
                  keyName: AppStrings.email,
                  hintText: AppStrings.emailHint.tr.capitalizeFirst,
                  labelText: AppStrings.email.tr.capitalizeFirst,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                  isEmail: false,
                  isRequired: true,
                  isNumeric: false,
                ),
                UiHelper.verticalSpaceLarge,
                // PhoneInputWidget(
                //   keyName: DrOfferAppStrings.phoneNum,
                //   hintText: DrOfferAppStrings.phoneNum.tr.capitalizeFirst!,
                // ),
                // UiHelper.verticalSpaceMassive,
                ActionButton(
                  btnController: controller.btnController,
                  text: AppStrings.submit.tr.capitalizeFirst!,
                  onPressed: controller.onSBTab,
                  backgroundColor: Theme.of(context).primaryColorDark,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

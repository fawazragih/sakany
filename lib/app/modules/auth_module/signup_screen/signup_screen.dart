import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/empty_data_widget.dart';
import 'package:tamoily/app/global_widget/loading_progress_bar.dart';
import 'package:tamoily/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:tamoily/app/modules/auth_module/local_widget/logo_widget_in_auth_screens.dart';
import 'package:tamoily/app/modules/auth_module/signup_screen/signup_controller.dart';
import 'package:tamoily/app/modules/auth_module/signup_screen/widgets/register_form.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

class SignupScreen extends GetView<SignupController> {

  const SignupScreen({super.key});
  static const String routeName = '/auth/signup-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.TITLE_REGISTER.translate),
      body: GetBuilder<SignupController>(
        builder: (controller) {
          return controller.busy
              ? const Center(
            child: LoadingProgressBar(),
          )
              : controller.showRetryButton
              ? RetryWidget(
            errorMessage: controller.errorMessage,
            onRetry: controller.fetchRegisterFormData,
          )
              : controller.registerFormData == null
              ? const EmptyDataWidget()
              : SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.w,
              vertical: 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LogoWidgetInAuthScreens(
                  isSignUp: true,
                ),
                RegisterForm(
                  controller: controller,
                  formData: controller.registerFormData!,
                ),
                UiHelper.verticalSpaceSmall,
                // const DoNotAndAlreadyHaveAccountWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*
class SignUpForm extends StatelessWidget {
  final controller = Get.find<SignupController>();

  double get headLineFontSize => 32.sp;

  SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      from: 150.h,
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 1200),
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (controller.isSigningUp) ...[
              UiHelper.verticalSpaceLarge,
              Row(
                children: [
                  AutoSizeText(
                    AppStrings.ifYouHaveAccount.tr.capitalizeFirst!,
                    style: SharedStyle.subtitle2(
                      fontSizeWithSp: 16.sp,
                    ),
                  ),
                  UiHelper.horizontalSpaceTiny,
                  InkWell(
                    onTap: () => Get.back(),
                    child: AutoSizeText(
                      AppStrings.login.tr.capitalize!,
                      style: SharedStyle.subtitle2(
                        fontSizeWithSp: 16.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
              UiHelper.verticalSpaceLarge,
            ],
            // UiHelper.verticalSpaceSmall,
            InputTextFieldWidget(
              keyName: AppStrings.userName,
              hintText: AppStrings.userName.tr.capitalizeFirst,
              initialValue:
                  controller.userAuthController.currentUser?.firstName,
              prefixIcon: const Icon(
                FontAwesomeIcons.user,
              ),
            ),
            UiHelper.verticalSpaceMedium,
            InputTextFieldWidget(
              keyName: AppStrings.email,
              hintText: AppStrings.emailHint.tr.capitalizeFirst,
              initialValue: controller.userAuthController.currentUser?.email,
              isEmail: true,
              prefixIcon: const Icon(
                CupertinoIcons.mail,
              ),
            ),
            if (controller.isSigningUp) ...[
              UiHelper.verticalSpaceMedium,
              PasswordInput(
                keyName: AppStrings.password,
                // confirmKeyName: MamaMiaAppStrings.passwordConfirm,
                // labelText: MamaMiaAppStrings.password.tr.capitalizeFirst!,
                hintText: AppStrings.passwordHint.tr.capitalizeFirst!,
                confirmHintText:
                    AppStrings.passwordConfirmHint.tr.capitalizeFirst,
                confirmLabelText: AppStrings.passwordConfirm.tr.capitalizeFirst,
                isSignUp: true,
                requiredMinLength: 6,
                // isSignUp: true,
              )
            ],
            UiHelper.verticalSpaceMassive,

            ActionButton(
              btnController: controller.btnController,
              backgroundColor: Theme.of(context).primaryColorDark,
              text: AppStrings.signup.tr.capitalizeFirst!,
              onPressed: controller.onSBTab,
            ),
            // UiHelper.verticalSpaceMedium,
            // if (controller.isSigningUp)
            //   GoogleAuthActionButton(
            //     onTap: controller.onLoginWithGoogle,
            //   ),
          ],
        ),
      ),
    );
  }
}
*/

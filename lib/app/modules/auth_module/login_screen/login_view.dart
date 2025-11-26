import 'package:animate_do/animate_do.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/screen_status_widgets.dart';
import 'package:tamoily/app/modules/auth_module/forget_password_screen/forget_password_view.dart';
import 'package:tamoily/app/modules/auth_module/local_widget/or_widget.dart';
import 'package:tamoily/app/modules/auth_module/signup_screen/arguments/registration_screen_arguments.dart';
import 'package:tamoily/app/modules/auth_module/signup_screen/signup_screen.dart';
import 'package:tamoily/app/modules/tabs_screen/tabs_screen_view.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme/input_decoration_style.dart';
import '../../../global_widget/action_buttons/action_button.dart';
import '../../../global_widget/all_form_widgets/input_text_field_widget.dart';
import '../../../global_widget/all_form_widgets/password_input.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';
import '../local_widget/logo_widget_in_auth_screens.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  static const String routeName = '/auth';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<LoginController>(
          builder: (controller) {
            return ScreenStatusWidgets(
              onRetry: controller.fetchLoginFormData,
              controller: controller,
              dataWidget: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LogoWidgetInAuthScreens(),
                      LoginForm(
                        controller: controller,
                      ),
                      UiHelper.verticalSpaceSmall,
                      // const DoNotAndAlreadyHaveAccountWidget(),
                    ],
                  )),
              isEmpty: controller.formData == null,
            );
          },
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final LoginController controller/*= Get.find<LoginController>()*/;

  const LoginForm({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      // key: UniqueKey(),
      // from: HelpersMethods.isDirectionRTL ? -500 : 500,
      from: 150.h,
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 1200),
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            UiHelper.verticalSpaceLarge,

            (controller.formData?.usernamesEnabled == true)
                ? InputTextFieldWidget(
                    keyName: AppStrings.userName,
                    keyboardType: TextInputType.name,
                    autoFocus: false,
                    isRequired: true,
                    initialValue: kDebugMode ? controller.testUserName : null,
                    onChanged: (value) => controller.formData?.username = value,
                    hintText: ConstStrings.USERNAME.translate,
                    textInputAction: TextInputAction.next,
                  )
                : InputTextFieldWidget(
                    keyName: AppStrings.email,
                    isEmail: true,
                    prefixIcon: const Icon(Icons.person),
                    initialValue: kDebugMode ? controller.testUserName : null,
                    hintText: ConstStrings.LOGIN_EMAIL.translate,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
            UiHelper.verticalSpaceMedium,
            PasswordInput(
              keyName: AppStrings.password,
              requiredMinLength: 6,
              initialValue: kDebugMode ? controller.testPassword : null,
              hintText: ConstStrings.LOGIN_PASS.translate,
              textInputAction: TextInputAction.done,
            ),
            UiHelper.verticalSpaceTiny,

            Row(
              children: [
                ///...
                // const EnableBiometricLogin(),
                // Spacer(),

                //region nav to register screen
                if (controller.formData?.registrationType != 4 &&
                    controller.formData?.registrationType
                            .toString()
                            .toLowerCase() !=
                        'disabled') // 4 means registration disabled
                  ...[
                  TextButton(
                    child: Text(
                      ConstStrings.LOGIN_NEW_CUSTOMER.translate,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          .withBoldFont
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    onPressed: () {
                      Get.toNamed(
                        SignupScreen.routeName,
                        parameters:
                            RegistrationScreenArguments(getCustomerInfo: false)
                                .toJson(),
                      );
                    },
                  ),
                  const Spacer(),
                ],
                //endregion

                //region forgetPassword text button
                TextButton(
                  child: Text(
                    ConstStrings.LOGIN_FORGOT_PASS.translate,
                    style: Theme.of(context).textTheme.labelMedium.withBoldFont,
                  ),
                  onPressed: () => Get.toNamed(ForgetPasswordScreen.routeName),
                )
                //endregion
              ],
            ),
            UiHelper.verticalSpaceMedium,
            ActionButton(
              btnController: controller.btnController,
              radius: AppInputDecorationStyle.inputFromWidgetRadius,
              text: ConstStrings.LOGIN_LOGIN_BTN.translate.toUpperCase(),
              backgroundColor: Theme.of(context).primaryColorDark,
              onPressed: controller.onSubmit,
            ),

            OrWidget(
                    // key: UniqueKey(),
                    )
                .paddingSymmetric(
              vertical: 16.0.h,
            ),

            ActionButton(
              isOutLined: true,
              radius: AppInputDecorationStyle.inputFromWidgetRadius,
              text: AppStrings.continueAsGuest.tr.capitalizeFirst!,
              fontSize: 12.sp,
              backgroundColor: Colors.transparent,
              borderColor: Theme.of(context).primaryColorDark,
              onPressed: () => Get.offNamed(TabsScreenView.routeName),
            ),

            /// login with biometric widget only show when user
            /// hasLoggedIn before and has an authorize
            // Obx(() {
            //   if (Get.find<SettingAppService>().enabledBiometric.value &&
            //       controller.userAuthController.hasLoggedIn) {
            //     return Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         OrContinueWithWidget(
            //           text: AppStrings.orContinueWithBiometric.tr.capitalize!,
            //         ),
            //         UiHelper.verticalSpaceLarge,
            //         const BiometricView(),
            //       ],
            //     );
            //   }
            //   return const SizedBox.shrink();
            // }),
          ],
        ),
      ),
    );
  }
}

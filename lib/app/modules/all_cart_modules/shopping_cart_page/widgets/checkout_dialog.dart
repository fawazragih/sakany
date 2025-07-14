import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/modules/auth_module/login_screen/login_view.dart';
import 'package:sakani_mobile_app/app/modules/auth_module/signup_screen/arguments/registration_screen_arguments.dart';
import 'package:sakani_mobile_app/app/modules/auth_module/signup_screen/signup_screen.dart';
import 'package:sakani_mobile_app/app/modules/checkout_page/checkout_view.dart';
import 'package:sakani_mobile_app/app/services/bas_service_configs/bas_service.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

class CheckoutDialog extends StatelessWidget {
  const CheckoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          ConstStrings.CHECKOUT_AS_GUEST_TITLE.translate,
        ),
      ),
      content: Wrap(
        children: [
          Column(
            children: [
              Text(
                ConstStrings.REGISTER_AND_SAVE_TIME.translate,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                ConstStrings.CREATE_ACCOUNT_LONG_TEXT.translate,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                child: Text(
                  ConstStrings.CHECKOUT_AS_GUEST.translate,
                ),
                onPressed: () {
                  Get.toNamed(CheckoutPage.routeName);
                },
              ),
              ActionButton(
                text: ConstStrings.REGISTER_BUTTON.translate,
                onPressed: () {
                  Get.offNamed(
                    SignupScreen.routeName,
                    arguments: RegistrationScreenArguments(
                      getCustomerInfo: false,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                ConstStrings.RETURNING_CUSTOMER.translate,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                child: Text(
                  ConstStrings.LOGIN_LOGIN_BTN.translate,
                ),
                onPressed: () {
                  if (BasService.instance.inBasApp) {
                    //TODO byMe call BasSuperAppFlow.loginFlow;
                    logger.d('TODO');
                    // BasSuperAppFlow.loginFlow(AuthBloc(), context);
                  } else {
                    Get.offNamed(LoginScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

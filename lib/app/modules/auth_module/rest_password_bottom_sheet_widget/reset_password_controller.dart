import 'package:get/get.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';

import '../../../base_controllers_and_listeners/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api_providers/auth_api.dart';
import '../login_screen/login_view.dart';

class ResetPasswordController extends BaseController {
  final AuthApi _authApi = AuthApi();

  onSBTab() async {
    if (formKey.currentState?.validate() ?? false) {
      if (noInternetConnection) {
        return await onNOInternetConnection();
      }

      formKey.currentState?.save();
      Map<String, dynamic>? allValues = formKey.currentState?.value;

      btnController.start();

      String oldPassword = allValues![AppStrings.currentPassword];
      // String newPassword = allValues[AppStrings.newPassword];
      String passwordConfirm = allValues[AppStrings.newPasswordConfirm];

      SuccessOrError result = await _authApi.changePassword(
        oldPassword,
        passwordConfirm,
      );

      if (result.success) {
        Get.offAllNamed(
          LoginScreen.routeName,
        );
        buildSuccessSnackBar(
          msg: AppStrings
              .newPasswordChangeWithSuccessPleaseReLogin.tr.capitalizeFirst!,
        );
      } else {
        btnController.error();
        buildErrorSnackBar(
          msg: result.toString(),
        );
        btnController.reset();
      }
    } else {
      toastMessage(
        AppStrings.fillAllField.tr.capitalizeFirst!,
      );
    }
  }
}

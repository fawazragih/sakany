import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';

import '../../../base_controllers_and_listeners/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api_providers/auth_api.dart';

class ForgetPasswordScreenController extends BaseController {
  bool showSuccessEmailSent = false;
  final AuthApi _authApi = AuthApi();

  onSBTab() async {
    if (formKey.currentState?.validate() ?? false) {
      if (noInternetConnection) {
        return await onNOInternetConnection();
      }

      formKey.currentState?.save();
      Map<String, dynamic> allValues = formKey.currentState!.value;

      btnController.start();
      SuccessOrError result =
          await _authApi.forgetPassword(allValues[AppStrings.email]);

      if (result.success) {
        btnController.success();
        buildSuccessSnackBar(
          msg: AppStrings.resetNewPasswordSentToYourEmail.tr.capitalizeFirst!,
        );
        showSuccessEmailSent = true;
        update();
        // Get.toNamed(page)
      } else {
        return buildErrorSnackBar(
          msg: result.toString(),
        );
      }
    } else {
      toastMessage(AppStrings.fillAllField.tr.capitalizeFirst!);
    }
  }
}

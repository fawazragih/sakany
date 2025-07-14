import 'dart:io';

import 'package:get/get.dart';

import '../../../../base_controllers_and_listeners/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/models/app_user_model.dart';
import '../../repository/user_profile_reposiotry.dart';

class UpdateUserProfileController extends BaseController {
  final UserProfileRepository _repository = UserProfileRepository.instance;

  bool _isUploadingData = false;

  bool get isUploadingData => _isUploadingData;

  set isUploadingData(bool value) {
    _isUploadingData = value;
    update();
  }

  // final AppUser? initialValue;

  UpdateUserProfileController();

  onSubmit() async {
    Get.focusScope?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      if (noInternetConnection) {
        return await onNOInternetConnection();
      }

      isUploadingData = true;
      formKey.currentState?.save();

      Map<String, dynamic> allValues = formKey.currentState!.value;

      AppUser userModel = AppUser(
        imageFile: allValues[AppStrings.imageToUpload] is File
            ? allValues[AppStrings.imageToUpload]
            : null,
        name: allValues[AppStrings.name],
        phone: allValues[AppStrings.phoneNum]?.completeNumber,
      );

      var result = await _repository.updateProfile(userModel);

      if (result.success) {
        isUploadingData = false;
        if (Get.isDialogOpen ?? false) {
          Get.back(result: true);
        }
        buildSuccessSnackBar();
      } else {
        isUploadingData = false;
        buildErrorSnackBar(msg: result.toString());
        return;
      }
    }
  }
}

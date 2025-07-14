import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';

class AboutAppController extends BaseController {
//   final AppConfigAndSettingsRepository _repository =
//   AppConfigAndSettingsRepository();
//
//   List<AppSetting?> appSettingList = [];
//
//   AppSetting? appSetting;
//
//   @override
//   void onInit() {
//     super.onInit();
//     startGetData();
//   }
//
//   startGetData() async {
//     return ;
//     setBusy(true);
//
//     var result = await _repository.getAppSettings();
//
//     if (result != null && result is GeneralResponseModel && result.success) {
//       appSettingList = result.data;
//       appSetting = appSettingList.first;
//       // logger.d(chefProfile.isFollowedByCurrentUser);
//       setBusy(false);
//     } else {
//       setShowRetryButton(true);
//       buildErrorSnackBar(msg: result.toString());
//     }
//   }
//
//   onPhonesTap() {
//     String? separator = appSetting?.phones?.replaceAll(RegExp('[0-9]'), '');
//
//     logger.d(separator);
//
//     final List<String>? phones = appSetting?.phones?.split(separator ?? '-');
//
//     logger.d(phones);
//
//     if (phones.isNullOrEmpty) {
//       return toastMessage(AppStrings.noItems.tr.capitalizeFirst!);
//     }
//     Get.bottomSheet(
//       PhonesListView(phones: phones!),
//     );
//
//   }
}

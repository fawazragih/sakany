import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/helpers_methods.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/repositories/settings_repository.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import '../../modules/splash_screen/splash_screen.dart';

class AppLanguageController extends GetxService with HelpersMethods {
  final String languageCodeKey = 'languageCode';

  // AppLanguage._();

  late Rx<Locale> appLocale = Rx<Locale>(
    const Locale('en', 'US'),
  );

  late GetStorage appLangBox;

  final String _appLangBoxName = 'appLangBoxName';

  setUpDB() async {
    appLangBox = GetStorage(_appLangBoxName);
    await appLangBox.initStorage;
    await fetchLocale();
  }

  fetchLocale() async {
    if (appLangBox.read(languageCodeKey) == null) {
      //get deviceLocale
      /*final String defaultLocale = Platform.localeName;
      // final String defaultLocale = Get.deviceLocale?.languageCode;
      if (defaultLocale.contains('ar')) {
        appLocale.value = const Locale('ar');
        debugPrint('-------current lang is system default ar');
        return;
      }*/

      appLocale.value = const Locale('ar');
      logger.d('-------return default lang as ar');
      return;
    }

    appLocale.value = Locale(appLangBox.read(languageCodeKey));
    logger.d(' appLocale lang is ${appLocale.value}');
    return;
  }

  changeLanguage(String langCode, int languageId) async {
    showProgressDialog();

    SuccessOrError response =
        await SettingsRepository.instance.changeLanguage(languageId);
    hideProgressDialog();
    if (response.success) {
      if (appLocale.value.languageCode == langCode) {
        return;
      }

      appLangBox.write(languageCodeKey, langCode);

      appLocale.value = Locale(langCode);
      Get.updateLocale(appLocale.value);

      // Get.rootController.restartApp();
      Get.offAllNamed(SplashPage.routeName);
    } else {
      buildErrorSnackBar(
          msg: response.error?.message ?? response.error?.toString());
    }
  }

// String toApi() {
//   if (appLocale.value.languageCode.contains('en')) {
//     return 'en';
//   }
//   return 'ar';
// }
}

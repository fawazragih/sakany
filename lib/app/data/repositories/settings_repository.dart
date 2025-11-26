import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:tamoily/app/data/api_providers/app_settings_api.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import '../models/requestbody/app_start_req_body.dart';

class SettingsRepository {
  SettingsRepository._();
  static SettingsRepository get instance =>   SettingsRepository._();

  ///..............

  final AppSettingsApi _api = AppSettingsApi();

  Future<SuccessOrError> fetchAppLandingSettings() async {
    return await _api.getAppLanding();
  }

  ////TODO byMe postFcmToken
  Future<SuccessOrError> postFcmToken(String fcmToken) async {
    int deviceTypeId;

    if (!kIsWeb && Platform.isAndroid) {
      deviceTypeId = 10;
    } else if (!kIsWeb && Platform.isIOS) {
      deviceTypeId = 5;
    } else {
      deviceTypeId = 20;
    }
    return await _api.postFcmToken(
      AppStartData(
        deviceTypeId: deviceTypeId.toInt(), // Android
        subscriptionId: fcmToken,
      ),
    );
  }

  Future<SuccessOrError> changeLanguage(int languageId) async {
    return _api.changeLanguage(languageId);
  }

  Future<SuccessOrError> changeCurrency(int currencyId) async {
    return _api.changeCurrency(currencyId);
  }
}

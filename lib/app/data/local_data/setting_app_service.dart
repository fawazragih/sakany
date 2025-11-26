import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamoily/app/core/assets_helpers/app_json.dart';
import 'package:tamoily/app/data/models/app_landing_response.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';

import '../models/slider_aspect_ratio.dart';

class AppSettingService extends GetxService {
  late GetStorage _settingsBox;

  setUpDb() async {
    _settingsBox = GetStorage('app_settings');
    await _settingsBox.initStorage;
    await getAppLandingData();
    await checkEnableBiometric();
    await checkShowIntroPage();
    await getSliderAspectRatio();
  }

  //region biometric settings
  final String _enableBiometric = 'enableBiometric';
  RxBool enabledBiometric = RxBool(false);

  checkEnableBiometric() async {
    if (_settingsBox.read(_enableBiometric) != null &&
        (_settingsBox.read(_enableBiometric) == true)) {
      enabledBiometric.value = true;
    }
  }

  toggleBiometricState(bool value) async {
    enabledBiometric.value = value;
    await _settingsBox.write(_enableBiometric, value);
  }

  //endregion

  //region show intro page settings
  final String _showIntroPage = 'showIntroPage';
  RxBool showIntroPage = RxBool(true);

  checkShowIntroPage() async {
    if (_settingsBox.read(_showIntroPage) != null &&
        (_settingsBox.read(_showIntroPage) == false)) {
      return showIntroPage.value = false;
    }
    return showIntroPage.value = true;
  }

  toggleShowIntroPage(bool value) async {
    showIntroPage.value = value;
    // logger.i('showIntroPage==> ${showIntroPage.value}');
    await _settingsBox.write(_showIntroPage, value);
    checkShowIntroPage();
  }

  //endregion

  //region appLandingData settings
  final String _appLandingDataKey = 'appLandingData';

  AppLandingData? _appLandingData;

  AppLandingData? get appLandingData => _appLandingData;

  setAppLandingData(AppLandingData value, {bool notify = true}) async {
    _appLandingData = value;
    // logger.i('setAppLandingData=>${appLandingData?.toJson()}');
    await _settingsBox.write(_appLandingDataKey, jsonEncode(value.toJson()));
    if (notify) {
      Get.forceAppUpdate();
    }
  }

  getAppLandingData() async {
    logger.i('getAppLandingData From LocalData');
    if (_settingsBox.read(_appLandingDataKey) != null) {
      var data = jsonDecode(_settingsBox.read(_appLandingDataKey));
      _appLandingData = AppLandingData.fromJson(data);
      logger.i('1=>${appLandingData?.toJson()}');
    } else {
      logger.i('getAppLanding From AppJsonAsset');
      String data = await rootBundle.loadString(AppJsonAsset.defaultAppLanding);
      // logger.i(data);
      var jsonResult = json.decode(data);
      _appLandingData = AppLandingData.fromJson(jsonResult);
    }
  }

  // deleteAppLandingData() {
  //   _appLandingData = null;
  //   if (_settingsBox.read(_appLandingDataKey) != null) {
  //     _settingsBox.remove(_appLandingDataKey);
  //   }
  // }

  //endregion

  //region getSliderAspectRatio
  final String _appSliderAspectRatioKey = 'appSliderAspectRatio';
  SliderAspectRatio? _appSliderAspectRatio;

  SliderAspectRatio get appSliderAspectRatio =>
      _appSliderAspectRatio ?? SliderAspectRatio.defaultData();

  void setSliderAspectRatio(SliderAspectRatio value) async {
    _appSliderAspectRatio = value;
    await _settingsBox.write(
        _appSliderAspectRatioKey, jsonEncode(value.toJson()));
  }

  Future<SliderAspectRatio?> getSliderAspectRatio() async {
    if (_settingsBox.read(_appSliderAspectRatioKey) != null) {
      var data = jsonDecode(_settingsBox.read(_appSliderAspectRatioKey));
      _appSliderAspectRatio = SliderAspectRatio.fromJson(data);
    }
    return null;
  }

  deleteSliderAspectRatio() {
    _appSliderAspectRatio = null;
    if (_settingsBox.read(_appSliderAspectRatioKey) != null) {
      _settingsBox.remove(_appSliderAspectRatioKey);
    }
  }
//endregion
}

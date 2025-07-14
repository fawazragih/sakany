import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/local_data/setting_app_service.dart';
import 'package:sakani/app/data/models/app_landing_response.dart';
import 'package:sakani/app/data/repositories/settings_repository.dart';
import 'package:sakani/app/modules/all_cart_modules/cart_helper/cart_init_and_check_helper.dart';
import 'package:sakani/app/modules/error_screen/error_screen.dart';
import 'package:sakani/app/services/bas_service_configs/bas_service.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';
import 'package:sakani/app/utils/utility.dart';

import '../../data/api_providers/base_configs/handling_dio_response.dart';
import '../../utils/api_env_config/api_env_setter.dart';
import '../store_closed_page/store_closed_view.dart';

class AppStartLogic {
  AppStartLogic._();

  static final AppStartLogic _instance = AppStartLogic._();

  static AppStartLogic get instance => _instance;

  startInitData() async {
    if (kIsWeb) {
      await BasService.instance.initAndStartCheckIfIsInBasSuperApp();
    }
    getAppLandingData();
  }

  final SettingsRepository _repository = SettingsRepository.instance;

  Future getAppLandingData() async {
    // if (Get.find<AppSettingService>().appLandingData != null && kDebugMode) {
    //   return;
    // }

    SuccessOrError appLandingResponse = await _repository.fetchAppLandingSettings();

    if (appLandingResponse.success &&
        appLandingResponse.response?.data is AppLandingData) {
      AppLandingData appLandingData = appLandingResponse.response!.data;

      Get.find<AppSettingService>().setAppLandingData(appLandingData);
      logger.w('totalShoppingCartProducts=>${appLandingData.totalShoppingCartProducts}'
          '\ntotalWishListProducts=>${appLandingData.totalWishListProducts}');

      CartCheckAndInitHelper.instance.cartCount.value = appLandingData.totalShoppingCartProducts ?? 0;

      logger.w('cartCount=>${CartCheckAndInitHelper.instance.cartCount.value}'
          '\nwishListCount=>${CartCheckAndInitHelper.instance.wishListCount.value}');
      CartCheckAndInitHelper.instance.wishListCount.value =
          appLandingData.totalWishListProducts ?? 0;

      if (kIsWeb) {
        return;
      } else {
        if (appLandingData.storeClosed == true) {
          Get.offNamed(StoreClosedPage.routeName);
          return;
        }

        //region handle force update
        if (appLandingData.andriodForceUpdate == true && Platform.isAndroid) {
          var forceUpdateNeeded = appLandingData.androidVersion == null
              ? false
              : await isRemoteVersionHigherThatLocal(
                  appLandingData.androidVersion!,
                  BuildEnvironment.instance.appVersion);

          if (forceUpdateNeeded == true &&
              (appLandingData.playStoreUrl ?? '').isNotEmpty) {
            showForceUpdateDialog(appLandingData.playStoreUrl!);
          }
        } else if (appLandingData.iOSForceUpdate == true && Platform.isIOS) {
          var forceUpdateNeeded = appLandingData.iOSVersion == null
              ? false
              : await isRemoteVersionHigherThatLocal(appLandingData.iOSVersion!,
                  BuildEnvironment.instance.appVersion);
          if (forceUpdateNeeded == true &&
              (appLandingData.appStoreUrl ?? '').isNotEmpty) {
            showForceUpdateDialog(appLandingData.appStoreUrl!);
          }
        }
        //endregion
      }
    } else {
      final shouldReload = await Get.toNamed(
        ErrorScreen.routeName,
        parameters: ErrorScreenArguments(
          errorMsg: appLandingResponse.error.toString(),
          // errorCode: error is AppException ? error.getErrorCode() : 0,
          errorCode: appLandingResponse.error?.statusCode,
        ).toJson(),
      );

      if (shouldReload == 'retry') {
        getAppLandingData();
      } else {
        !kIsWeb && Platform.isIOS ? exit(0) : SystemNavigator.pop();
      }
      return;
    }
  }

  void showForceUpdateDialog(String url) {
    //TODO byMe
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (ctx) => AlertDialog(
    //     title: Text(_global.getString(Const.FORCE_UPDATE_TITLE)),
    //     content: Text(_global.getString(Const.FORCE_UPDATE_CONTENT)),
    //     actions: <Widget>[
    //       TextButton(
    //         onPressed: () =>
    //             !kIsWeb && Platform.isIOS ? exit(0) : SystemNavigator.pop(),
    //         child: Container(
    //           padding: EdgeInsets.all(14.r),
    //           child: Text(_global.getString(Const.FORCE_UPDATE_EXIT_BTN)),
    //         ),
    //       ),
    //       TextButton(
    //         onPressed: () => _launchUrl(url),
    //         child: Container(
    //           padding: EdgeInsets.all(14.r),
    //           child: Text(_global.getString(Const.FORCE_UPDATE_UPDATE_BTN)),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

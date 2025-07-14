import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/local_data/setting_app_service.dart';
import 'package:sakani/app/modules/splash_screen/app_start_logic.dart';
import 'package:sakani/app/utils/api_env_config/api_env_setter.dart';
import 'package:sakani/app/utils/deep_uni_link_listener.dart';
import '../../base_controllers_and_listeners/base_controller.dart';
import '../../services/connectivity_service/connectivity_controller.dart';
import '../../services/notification_service/fcm_service.dart';
import '../auth_module/login_screen/login_view.dart';
import '../tabs_screen/tabs_screen_view.dart';

class SplashController extends BaseController {
  // late VideoPlayerController videoController;

  bool isLocalhostFlavor = BuildEnvironment.instance.isLocalhostFlavor;

  @override
  void onInit() async {
    super.onInit();
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (Get.context!.isTablet) {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else if (Get.context!.isPhone) {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  onReady() {
    super.onReady();
    if (!isLocalhostFlavor) {
      startInitData();
    }
  }

  startInitData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AppStartLogic.instance.startInitData();
      await Get.put(AppSettingService(), permanent: true).setUpDb();
      DeepUniLinkListener.instance.init();
      Get.find<ConnectivityController>().checkWhenStreamIsNull();
      PushNotificationService.instance.initialise();
      handleNavigation();
    });
  }

  handleNavigation() async {
    await Future.delayed(const Duration(seconds: 1));
    // if (Get.find<SettingAppService>().showIntroPage.value) {
    //   return Get.offNamed(IntroGuidesScreen.routeName);
    // }
    return Get.offNamed(TabsScreenView.routeName);
    if (userAuthController.authenticated.value) {
      return Get.offNamed(TabsScreenView.routeName);
    } else {
      return Get.offNamed(LoginScreen.routeName);
    }
  }
}

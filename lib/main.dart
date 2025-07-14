import 'dart:async';
import 'dart:io';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/firebase_options.dart';
import 'app/base_controllers_and_listeners/user_auth_controller.dart';
import 'app/core/language_and_localization/app_language_controller.dart';
import 'app/core/theme/theme_controller.dart';
import 'app/data/local_data/session_service.dart';
import 'app/data/local_data/setting_app_service.dart';
import 'app/data/models/app_landing_response.dart';
import 'app/services/connectivity_service/connectivity_controller.dart';
import 'app/utils/api_env_config/api_env_setter.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';
import 'start_app.dart';
import 'web_helpers/mobile_worker.dart'
if (dart.library.html) 'web_helpers/web_worker.dart' as web_helpers;



AppLandingData? get appLanding => Get.find<AppSettingService>().appLandingData;

void main() async {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      // usePathUrlStrategy();
      web_helpers.setPathUrlStrategy();
    }
    await FastCachedImageConfig.init();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await BuildEnvironment.instance.setBuildEnvironment();
    await ScreenUtil.ensureScreenSize();
    // HttpOverrides.global = MyHttpOverrides();
    await initAppGetControllers();
    await initAppFirebase();
    runApp(
      const StartApp(),
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const StartApp(),
      // ),
    );
  }, (error, stackTrace) {
    logger.e("caught error global at $stackTrace");
    logger.e("$error");
    // logger.e("$stackTrace");
    // if (!Singleton.IsWeb && !Platform.isWindows) {
    //   FirebaseCrashlytics.instance.recordError(error, stackTrace);
    // }
  });
}

initAppGetControllers() async {
  await SessionServiceWithSecureStorage.instance.setupDb();

  Get.put(UserAuthController(), permanent: true);

  Get.put(ConnectivityController(), permanent: true);

  // await Get.put(AppSettingService(), permanent: true).setUpDb();

  await Get.put(AppThemeController()).setUpDb();

  await Get.put(AppLanguageController()).setUpDB();

  // await Get.put(CartLocalData(), permanent: true).setUpDb();
}

initAppFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  ///. Firebase Crashlytics
  //enable FirebaseCrashlytics only in releaseMode
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  // End Of Firebase Crashlytics
}

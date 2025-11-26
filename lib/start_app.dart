import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'app/core/language_and_localization/app_language_controller.dart';
import 'app/core/language_and_localization/app_strings.dart';
import 'app/core/language_and_localization/app_translation.dart';
import 'app/core/theme/app_themes_helper.dart';
import 'app/core/theme/theme_controller.dart';
import 'app/modules/splash_screen/splash_screen.dart';
import 'app/routes/app_routs_and_pages.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ///..my phone
      // designSize: const Size(360.0, 758.0),
      // designSize: const Size(411.4, 867.4),
      designSize: const Size(375, 812),
      // designSize: const Size(360, 690),

      // designSize: MediaQuery.sizeOf(context),
      ///..tablet emulator
      // : const Size(1280.0, 840.0),
      // designSize: context.mediaQuerySize,
      // minTextAdapt: false,
      // minTextAdapt: true,
      minTextAdapt: false,
      // splitScreenMode: true,
      // enableScaleWH: ()=>false,
      // enableScaleText: ()=>false,
      // useInheritedMediaQuery: false,
      ensureScreenSize: true,
      builder: (context, widget) {

        return GetMaterialApp(
          builder: (context, widget) {
            // ScreenUtil.init(context, designSize: const Size(375,812));
            // final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
            // return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)), child: widget!,);
            ///wrapAppToStopTextScaleFactor
            final scale = MediaQuery.of(context)
                .textScaler
                .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0);
            // return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: scale), child: widget!);

            ///wrapAppToRemoveFirstAndLastLineHeight
            return DefaultTextHeightBehavior(
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
              ),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: scale),
                child: widget!,
              ),
            );
          },
          translations: AppTranslation(),
          defaultTransition: Transition.cupertino,
          title: AppStrings.appName.tr.capitalizeFirst!,
          locale: Get.find<AppLanguageController>().appLocale.value,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', 'YE'),
          ],
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // navigatorObservers: [FirebaseAnalyticsObserver(analytics: Singleton.analytics)],
          fallbackLocale: const Locale('en', 'US'),
          theme: AppThemesHelper.lightTheme,
          darkTheme: AppThemesHelper.darkTheme,
          themeMode: Get.find<AppThemeController>().currentThemeMode.value!,
          color: Colors.white,
          debugShowCheckedModeBanner: false,
          getPages: AppRoutsAndPages.allRoutes,
          initialRoute: SplashPage.routeName,

          // initialRoute: HomeWebViewScreen.routeName,
          // home:  AddImagesAndVideosPage(),
        );
      },
    );
    // return GetMaterialApp(
    //   builder: (context, widget) {
    //     ScreenUtil.init(context, designSize: const Size(375,812));
    //     // final scale = MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3);
    //     // return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(scale)), child: widget!,);
    //     ///wrapAppToStopTextScaleFactor
    //     final scale = MediaQuery.of(context)
    //         .textScaler
    //         .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.0);
    //     // return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: scale), child: widget!);
    //
    //     ///wrapAppToRemoveFirstAndLastLineHeight
    //     return DefaultTextHeightBehavior(
    //       textHeightBehavior: TextHeightBehavior(
    //         applyHeightToFirstAscent: true,
    //         applyHeightToLastDescent: true,
    //       ),
    //       child: MediaQuery(
    //         data: MediaQuery.of(context).copyWith(textScaler: scale),
    //         child: widget!,
    //       ),
    //     );
    //   },
    //   translations: AppTranslation(),
    //   defaultTransition: Transition.cupertino,
    //   title: AppStrings.appName.tr.capitalizeFirst!,
    //   locale: Get.find<AppLanguageController>().appLocale.value,
    //   supportedLocales: const [
    //     Locale('en', 'US'),
    //     Locale('ar', ''),
    //   ],
    //   localizationsDelegates: const [
    //     FormBuilderLocalizations.delegate,
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //     GlobalCupertinoLocalizations.delegate,
    //   ],
    //   // navigatorObservers: [FirebaseAnalyticsObserver(analytics: Singleton.analytics)],
    //   fallbackLocale: const Locale('en', 'US'),
    //   theme: AppThemesHelper.lightTheme,
    //   darkTheme: AppThemesHelper.darkTheme,
    //   themeMode: Get.find<AppThemeController>().currentThemeMode.value!,
    //   color: Colors.white,
    //   debugShowCheckedModeBanner: false,
    //   getPages: AppRoutsAndPages.allRoutes,
    //   initialRoute: SplashPage.routeName,
    //
    //   // initialRoute: HomeWebViewScreen.routeName,
    //   // home:  AddImagesAndVideosPage(),
    // );
  }
}

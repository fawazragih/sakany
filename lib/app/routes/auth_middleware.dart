import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/user_auth_controller.dart';
import 'package:sakani/app/modules/auth_module/forget_password_screen/forget_password_view.dart';
import 'package:sakani/app/modules/auth_module/login_screen/login_view.dart';
import 'package:sakani/app/modules/auth_module/signup_screen/signup_screen.dart';
import 'package:sakani/app/modules/intro_guides_page/intro_guides_view.dart';
import '../data/local_data/setting_app_service.dart';
import '../modules/tabs_screen/tabs_screen_view.dart';
import '../utils/api_env_config/app_logger_config.dart';

class AuthMiddleware extends GetMiddleware {
  final userAuthController = Get.find<UserAuthController>();

  /// these routes was added with [AuthMiddleware]
  /// BUT if you want to except some of them
  /// for example: some apps allow browse the [MainHome] as a guest.
  List<String> authExceptionRoutes = [
    // TabsScreenView.routeName,
    LoginScreen.routeName,
    SignupScreen.routeName,
    ForgetPasswordScreen.routeName,
  ];

  List<String> guestRoutes = [
    TabsScreenView.routeName,
  ];

  @override
  RouteSettings? redirect(String? route) {
    bool authenticated = userAuthController.authenticated.value;
    // bool authenticated = true;
    bool firstOpen = Get.find<AppSettingService>().showIntroPage.value;

    // logger.d('route: $route');

    var uri = Uri.tryParse(route ?? '');
    var path = uri?.path;

    logger.d(
      'route:$route'
      '\nfirstOpen:$firstOpen'
      '\nauthenticated:$authenticated',
    );

    /*   bool isAuthRoute = authExceptionRoutes.any((e) {
      return route?.startsWith(e) == true;
    });*/

    /*  if(isAuthRoute){
      //## ALL AUTH ROUTES ## //
      // check all auth route if user is already authenticated
      // then nav him to app home screen;
      // else
      // only check if first open or not;
      if (authenticated) {
        return const RouteSettings(name: TabsScreenView.routeName);
      } else {
        return firstOpen
            ? const RouteSettings(name: IntroGuidesScreen.routeName)
            : null;
      }
    }else{
      // if path is Exception from auth then
      // ...only check if this is the first time to open
      // ...and if so nav to IntroGuidesScreen Or nav to to that excepted route;
      // else
      // must check if authenticated on not cuz this route required to be authenticated;

      // Check if the route matches any of the exception routes
      bool isGuestRoute = guestRoutes.any((gRoute) {
        return route?.startsWith(gRoute) == true;
      });
      if (isGuestRoute) {
        return firstOpen
            ? const RouteSettings(name: IntroGuidesScreen.routeName)
            : null;
      } else {
        return authenticated
            ? null
            : const RouteSettings(name: LoginScreen.routeName);
      }
    }*/

    switch (path) {
      case IntroGuidesScreen.routeName:
        return firstOpen
            ? null
            : const RouteSettings(name: TabsScreenView.routeName);

      //## ALL AUTH ROUTES ## //
      // check all auth route if user is already authenticated
      // then nav him to app home screen;
      // else
      // only check if first open or not;
      case LoginScreen.routeName:
      case SignupScreen.routeName:
      case ForgetPasswordScreen.routeName:
        logger.d('authRoutes: true');
        // if (authenticated) {
        //   return const RouteSettings(name: TabsScreenView.routeName);
        // } else {
          return firstOpen
              ? const RouteSettings(name: IntroGuidesScreen.routeName)
              : null;
        // }

      default:
        // if path is Guest Routes then
        // ...only check if this is the first time to open
        // ...and if so nav to IntroGuidesScreen Or nav to to that excepted route;
        // else
        // must check if authenticated on not cuz this route required to be authenticated;

        // Check if the route matches any of the guestRoutes routes
        bool isGuestRoute = guestRoutes.any((gRoute) {
          return route?.startsWith(gRoute) == true;
        });

        if (isGuestRoute) {
          return firstOpen
              ? const RouteSettings(name: IntroGuidesScreen.routeName)
              : null;
        } else {
          return authenticated
              ? null
              : const RouteSettings(name: LoginScreen.routeName);
        }
    }
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    // logger.d('>>> Page ${page?.name} called');
    // logger.d(message)('>>> User authenticated ${appController.authenticated} logged);
    return page;
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // This function will be called right before the Bindings are initialize,
    // then bindings is null
    // bindings = [OtherBinding()];
    return bindings;
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    // logger.d('Bindings of ${page.toString()} are ready');
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    // logger.d('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    // logger.d('PageDisposed');
  }
}

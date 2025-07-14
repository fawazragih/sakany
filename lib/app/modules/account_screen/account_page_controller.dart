import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/modules/auth_module/signup_screen/signup_screen.dart';
import '../../services/bas_service_configs/bas_service.dart';
import '../../utils/api_env_config/app_logger_config.dart';
import '../auth_module/login_screen/login_view.dart';

class AccountPageController extends BaseController {
  bool get isLoggedIn => userAuthController.authenticated.value;

  String? get fullName =>
      '${userAuthController.currentUser?.firstName ?? ''} ${userAuthController.currentUser?.lastName ?? ''}'
          .trim();

  String? get email => userAuthController.currentUser?.email;

  performLogout() async {
    // logoutResponseSink.add(ApiResponse.loading(
    //     GlobalService().getString(Const.COMMON_PLEASE_WAIT)));
    //
    // try {
    //   String response = await _repository.performLogout();
    //   logoutResponseSink.add(ApiResponse.completed(response));
    // } catch (e) {
    //   logoutResponseSink.add(ApiResponse.error(e.toString()));
    //   print(e.toString());
    // }
  }

  goto(String routeName,
      {bool loginRequired = true, Map<String, String>? args}) {
    if (loginRequired && !isLoggedIn) {
      if (BasService.instance.inBasApp) {
        //TODO byMe call  BasSuperAppFlow.loginFlow
        logger.d('TODO byMe call  BasSuperAppFlow.loginFlow');
        // BasSuperAppFlow.loginFlow(_bloc, context);
      } else {
        Get.toNamed(LoginScreen.routeName);
      }
    } else {
      Get.toNamed(
        routeName,
        parameters: args,
      )?.then((value) {
        if (routeName == SignupScreen.routeName) {
          //TODO byMe check refresh name & email section
          logger.d('TODO');

          // to refresh name & email section
          update();
        }
      });
    }
  }

  // void loginOrOutTap() {
  //   if (isLoggedIn) {
  //     logout();
  //   } else {
  //     if (BasService.instance.inBasApp) {
  //       // BasSuperAppFlow.loginFlow(_bloc, context);
  //       //TODO byMe call  BasSuperAppFlow.loginFlow
  //       logger.d('TODO byMe call  BasSuperAppFlow.loginFlow');
  //     } else {
  //       goto(
  //         LoginScreen.routeName,
  //         loginRequired: false,
  //       );
  //     }
  //   }
  // }
}

import 'package:get/get.dart';
import '../base_controllers_and_listeners/user_auth_controller.dart';
import '../modules/auth_module/login_screen/login_view.dart';

class AppSharedDataManager {
  AppSharedDataManager._();

  static final AppSharedDataManager _instance = AppSharedDataManager._();

  static AppSharedDataManager get instance => _instance;
  final UserAuthController authController = Get.find<UserAuthController>();

  // TabFile? tabFile;

  setSharedData(data) async {
    if (!authController.authenticated.value) {
      Get.toNamed(LoginScreen.routeName);
    } else {
      // if (data['src'] != null && data['fileId'] != null) {
      //   // tabFile = TabFile.fromJson(data);
      // }
    }
  }
}

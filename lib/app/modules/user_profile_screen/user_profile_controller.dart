import 'package:get/get.dart';
import 'package:sakani/app/data/models/app_landing_response.dart';
import '../../base_controllers_and_listeners/base_controller.dart';
import '../../services/bas_service_configs/bas_service.dart';
import '../../utils/api_env_config/app_logger_config.dart';
import '../auth_module/login_screen/login_view.dart';
import 'repository/user_profile_reposiotry.dart';
import 'widgets/update_user_profile/update_user_profile_dialog.dart';

class UserProfileController extends BaseController {
  final UserProfileRepository _repository = UserProfileRepository.instance;

  bool get isLoggedIn => userAuthController.authenticated.value;

  String? get fullName =>
      '${userAuthController.currentUser?.firstName ?? ''} ${userAuthController.currentUser?.lastName ?? ''}'
          .trim();

  String? get email => userAuthController.currentUser?.email;


  List<AvailableLanguages> get langList => appLandingData
      ?.languageNavSelector
      ?.availableLanguages ??
      List.empty();

  @override
  void onInit() {
    super.onInit();
    getUserProfileData();
  }

  getUserProfileData() async {
    // setBusy(true);

    // var result = await _repository.getUserProfile();
    // if (result != null &&
    //     result is GeneralResponseModel &&
    //     result.success &&
    //     result.data is AppUser) {
    //   AppUser newUserData = result.data;
    //
    //   userAuthController.currentAuthData!.user = newUserData;
    //
    //   await userAuthController.saveUserToLocalStorage(
    //     userAuthController.currentAuthData!,
    //   );
    //
    //   setBusy(false);
    // } else {
    //   setShowRetryButton(true);
    //   buildErrorSnackBar(msg: result.toString());
    // }
  }

  void onUpdateUserProfile() async {
    await Get.dialog(
      UpdateUserProfileDialog(
        initialValue: userAuthController.currentUser,
      ),
    ).then((value) {
      if (value != null && value is bool) {
        getUserProfileData();
      }
    });
  }

  void loginOrOutTap() {
    if (isLoggedIn) {
      logout();
    } else {
      if (BasService.instance.inBasApp) {
        // BasSuperAppFlow.loginFlow(_bloc, context);
        //TODO byMe call  BasSuperAppFlow.loginFlow
        logger.d('TODO byMe call  BasSuperAppFlow.loginFlow');
      } else {
        Get.toNamed(LoginScreen.routeName);
      }
    }
  }
}

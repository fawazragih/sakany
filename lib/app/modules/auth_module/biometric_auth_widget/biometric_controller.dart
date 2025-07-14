import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';

import '../../../base_controllers_and_listeners/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';

class BiometricController extends BaseController {
  /// variables
  final LocalAuthentication auth = LocalAuthentication();
  bool supportState = false;
  // UserRepository _userRepository = LocatorHelper.locator<UserRepository>();
  // final AuthApi _authApi = AuthApi();

  /// Getx methods
  @override
  void onInit() {
    super.onInit();
    // auth.isDeviceSupported().then((isSupported) => supportState = isSupported);
    checkAuthSupportingState();
    // getAvailableBiometrics();
  }

  Future<bool> checkAuthSupportingState() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = await auth.isDeviceSupported();

      supportState = canAuthenticateWithBiometrics || canAuthenticate;

      // logger
      //     .d('canAuthenticateWithBiometrics => $canAuthenticateWithBiometrics');
      // logger.d('canAuthenticate => $canAuthenticate');

      return canAuthenticate;
    } catch (e) {
      // buildErrorSnackBar(
      //   msg: e.toString(),
      // );
      logger.e("error biometrics $e");
      return false;
    }
  }

  // getAvailableBiometrics() async {
  //   List<BiometricType> availableBiometrics = [];
  //   try {
  //     availableBiometrics = await auth.getAvailableBiometrics();
  //   } catch (e) {
  //     logger.e("error enumerate biometrics $e");
  //     buildErrorSnackBar(
  //       msg: e.toString(),
  //     );
  //   }
  //
  //   logger.d("following biometrics are available");
  //   if (availableBiometrics.isNotEmpty) {
  //     for (var ab in availableBiometrics) {
  //       logger.d("Avalible Biomatrics: $ab");
  //     }
  //   } else {
  //     logger.d("no biometrics are available");
  //   }
  //
  //   return availableBiometrics;
  // }

  /// repository methods
  // biometricAuthenticate() async {
  //   if (!supportState) {
  //     buildErrorSnackBar(
  //       msg: AppStrings.notSupportBiometricMessage.tr.capitalizeFirst,
  //     );
  //     return;
  //   }
  //   if (!Get.find<SettingAppService>().enabledBiometric.value) {
  //     toastMessage(
  //       AppStrings.notEnableBiometricMessage.tr.capitalizeFirst!,
  //     );
  //     return;
  //   }
  //   if (!userAuthController.hasLoggedIn) {
  //     toastMessage(
  //       AppStrings.pleaseLoginFirst.tr.capitalizeFirst!,
  //     );
  //     return;
  //   }
  //   if (noInternetConnection()) {
  //     await onNOInternetConnection();
  //     return;
  //   }
  //
  //   bool isAuthenticate = await authenticate();
  //   logger.d(isAuthenticate);
  //   if (isAuthenticate) {
  //     DifferentDialogs.showProgressDialog();
  //
  //     var result = await _authApi.getAccessToken(
  //       accessToken: userAuthController.currentAuthData!.token!.accessToken!,
  //       refreshToken: userAuthController.currentAuthData!.token!.refreshToken!,
  //     );
  //
  //     if (result != null &&
  //         result is GeneralResponseModel &&
  //         result.success &&
  //         result.data is AppAuthData) {
  //       await userAuthController.saveUserToLocalStorage(result.data);
  //       DifferentDialogs.hideProgressDialog();
  //       Get.offAllNamed(TabsScreenView.routeName);
  //     } else {
  //       DifferentDialogs.hideProgressDialog();
  //       buildErrorSnackBar(
  //         msg: result.toString(),
  //       );
  //     }
  //   } else {
  //     buildErrorSnackBar(
  //       msg: AppStrings.biometricAuthenticationFailed.tr.capitalizeFirst!,
  //     );
  //   }
  // }

  /// biometric methods
  Future<bool> authenticate() async {
    try {
      if (!(await auth.canCheckBiometrics)) {
        return false;
      }
      return await auth.authenticate(
        localizedReason: AppStrings.chooseAuthenticationMethod.tr.capitalizeFirst!,
/*        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,*/
      );
    } catch (e) {
      // logger.d("Error - ${e.toString()}");
      return false;
    }
  }
}

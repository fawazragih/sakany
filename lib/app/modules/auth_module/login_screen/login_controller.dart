import 'package:app_extensions/app_extensions.dart';
import 'package:bas_sdk/bas_sdk.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/bas_settings_response.dart';
import 'package:tamoily/app/data/models/custom_properties.dart';
import 'package:tamoily/app/data/models/login_form_response.dart';
import 'package:tamoily/app/data/models/requestbody/user_login_req_body.dart';
import 'package:tamoily/app/data/models/user_login_response.dart';
import 'package:tamoily/app/modules/auth_module/signup_screen/signup_screen.dart';
import 'package:tamoily/app/modules/intro_guides_page/intro_guides_view.dart';
import 'package:tamoily/app/modules/splash_screen/splash_screen.dart';
import 'package:tamoily/app/services/bas_service_configs/bas_service.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../base_controllers_and_listeners/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api_providers/auth_api.dart';
import '../../tabs_screen/tabs_screen_view.dart';
import '../signup_screen/arguments/registration_screen_arguments.dart';

class LoginController extends BaseController {
  final AuthApi _authApi = AuthApi();

  // String testUserName = 'admin';
  // String testUserName = 'mush@gm.com';
  // String testPassword = '123123';
  String testUserName = 'ysf@gd.cim';

  String testPassword = 'ysf@gd.cim';

  String? previousRoute;

  @override
  onInit() {
    super.onInit();
    previousRoute = Get.previousRoute;
    fetchLoginFormData();
  }

  LoginFormData? formData;

  fetchLoginFormData() async {
    setBusy(true);
    SuccessOrError result = await _authApi.fetchLoginFormData();
    if (result.success) {
      formData = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  onSubmit() async {
    // // logger.d(Get.hi);
    // return logger.d(previousRoute);

    Get.focusScope?.unfocus();

    // if (_formKey.currentState?.validate() ?? false) {
    //   removeFocusFromInputField(context);
    //   if (formData != null) _bloc.postLoginFormData(formData);
    // }

    if (formKey.currentState?.validate() ?? false) {
      if (noInternetConnection) {
        return await onNOInternetConnection();
      }

      if (btnController.currentState == ButtonState.loading) {
        return;
      }
      formKey.currentState?.save();

      Map<String, dynamic> allValues = formKey.currentState!.value;

      LoginFormData loginFormData = LoginFormData(
        email: allValues[AppStrings.email],
        password: allValues[AppStrings.password],
        username: allValues[AppStrings.userName],
        // fcmToken: await PushNotificationService.instance.getToken(),
      );
      postLoginAndHandleResponse(loginFormData);
      // SuccessOrError result = await _authApi.login(UserLoginReqBody(data: loginFormData));
      //
      // btnController.stop();
      //
      // logger.d(result.toJson);
      //
      // if (result.success && result.response?.data is UserLoginData) {
      //   UserLoginData userLoginData = result.response!.data;
      //   printBasResult('start handle post login response');
      //   onSuccess(userLoginData);
      // } else {
      //   btnController.error();
      //   buildErrorSnackBar(msg: result.toString());
      //   return;
      // }
    }
  }

  postLoginWithBasAuth() async {
    try {
      // loginResponseSink.add(ApiResponse.loading(GlobalService().getString(Const.COMMON_PLEASE_WAIT)));
      showProgressDialog();

      ///..1- get bas settings
      SuccessOrError basSettingsResult = await _authApi.getBasSettings();
      hideProgressDialog();

      if (basSettingsResult.success == false) {
        // loginResponseSink.add(ApiResponse.error(basSettingsResult.message ?? 'bas settings can not be null'));
        buildErrorSnackBar(
            msg: basSettingsResult.error?.message ??
                'bas settings can not be null');
      }

      ///..2- pass bas settings to get auth code from [BasService.getBasAuthCode]
      BasSettingsData basSettingsData = basSettingsResult.response?.data;
      var (AuthCodeData? auth, String? err) =
          await BasService.instance.getBasAuthCode(basSettingsData.clientId!);
      if (err.isNotNullOrEmpty) {
        // logger.e('err from callBasLogin=>$err');
        printBasResult('err from callBasLogin=>$err');
        // loginResponseSink.add(ApiResponse.error(err));
        buildErrorSnackBar(msg: err);
      } else {
        printBasResult('start postLoginFormData=>');
        /*SuccessOrError result = await _authApi.login(
          UserLoginReqBody(
            data: LoginFormData(
              customProperties: CustomProperties(
                customerBASAuthCode: auth!.authId,
              ),
            ),
          ),
        );
        printBasResult('UserLoginResponse=>${result.toJson}');
        // loginResponseSink.add(ApiResponse.completed(userLoginResponse.data));
        if (result.success && result.response?.data is UserLoginData) {
          UserLoginData userLoginData = result.response!.data;
          printBasResult('start handle post login response');
          onSuccess(userLoginData);
        } else {
          buildErrorSnackBar(msg: result.toString());
          return;
        }*/
        postLoginAndHandleResponse(LoginFormData(
          customProperties: CustomProperties(customerBASAuthCode: auth!.authId),
        ));
      }
    } catch (e) {
      logger.e(e.toString());
      printBasResult('postLoginWithBasAuthError=>${e.toString()}');
      // loginResponseSink.add(ApiResponse.error(e.toString()));
      buildErrorSnackBar(msg: e.toString());
      // print(e.toString());
    }
  }

  postLoginAndHandleResponse(LoginFormData loginFormData) async {
    btnController.start();
    SuccessOrError result =
        await _authApi.login(UserLoginReqBody(data: loginFormData));

    btnController.stop();

    logger.d(result.toJson);

    if (result.success && result.response?.data is UserLoginData) {
      UserLoginData userLoginData = result.response!.data;
      printBasResult('start handle post login response');
      onSuccess(userLoginData);
      btnController.stop();
    } else {
      btnController.error();
      buildErrorSnackBar(msg: result.toString());
      btnController.stop();
      return;
    }
  }

  onSuccess(UserLoginData userLoginData) async {
    //region needToRegister when app is in basSuperApp
    if (userLoginData.needToRegister == true &&
        userLoginData.basUserInfo != null) {
      // logger.d('needToRegister=>${event.data?.needToRegister}');
      printBasResult('needToRegister=>${userLoginData.needToRegister}');
      printBasResult('basUserInfo=>${userLoginData.basUserInfo?.toJson()}');
      // DialogBuilder(context).hideLoader();
      Get.toNamed(
        SignupScreen.routeName,
        parameters: RegistrationScreenArguments(
          getCustomerInfo: false,
          completeRegisterWithBasUserData: true,
          basUserInfo: userLoginData.basUserInfo,
        ).toJson(),
      )?.then((value) {
        printBasResult('login after register with value=>$value');
        if (value is Map) {
          printBasResult('value is Map');
          postLoginWithBasAuth();
        }
      });
      return;
    }
    //endregion

    // save user session & goto home
    if (userLoginData.token != null && userLoginData.customerInfo != null) {
      await userAuthController.saveUserToLocalStorage(
        userLoginData.token!,
        userLoginData.customerInfo!,
      );

      // if (previousRoute == CartScreen.routeName) {
      //   Get.back();
      // } else {
      //   Get.offAllNamed(TabsScreenView.routeName);
      // }

      // final from = Get.arguments?['from'] ?? "!";
      // logger.d("from: $from");
      if (previousRoute == SplashPage.routeName ||
          previousRoute == IntroGuidesScreen.routeName) {
        Get.offNamed(TabsScreenView.routeName);
        return;
      }
      if (previousRoute.isNotNullOrEmpty) {
        logger.f(previousRoute);
        Get.until(
          (route) =>
              route.settings.name?.startsWith(previousRoute!) == true ||
              route.settings.name == TabsScreenView.routeName,
        );
      }
    } else {
      logger.e(
          'userLoginData.token is null OR userLoginData.customerInfo is null');
    }
  }

  @override
  void onClose() {
    // logger.d('loginClosed');
    super.onClose();
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:bas_sdk/bas_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/available_option.dart';
import 'package:sakani/app/data/models/bas_settings_response.dart';
import 'package:sakani/app/data/models/custom_properties.dart';
import 'package:sakani/app/data/models/get_states_response.dart';
import 'package:sakani/app/data/models/register_form_response.dart';
import 'package:sakani/app/data/models/requestbody/form_value.dart';
import 'package:sakani/app/modules/auth_module/signup_screen/arguments/registration_screen_arguments.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:sakani/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';
import '../../../base_controllers_and_listeners/base_controller.dart';
import '../../../data/api_providers/auth_api.dart';
import '../../../data/models/requestbody/registration_req_body.dart';
import '../../../services/bas_service_configs/bas_service.dart';

class SignupController extends BaseController {
  final AuthApi _authApi = AuthApi();

  final PageController pageController = PageController(initialPage: 0);

  bool get isSigningUp => !userAuthController.authenticated.value;

  RegistrationScreenArguments? arguments;

  bool get completeRegisterWithBasUserData =>
      arguments?.completeRegisterWithBasUserData ?? false;

  RegisterFormData? registerFormData;

  late CustomAttributeManager attributeManager;

  @override
  void onInit() {
    super.onInit();
    arguments = RegistrationScreenArguments.fromJson(Get.parameters);
    fetchRegisterFormData();
    attributeManager = CustomAttributeManager(
      context: Get.context,
      onClick: (priceAdjNeeded) {
        // updating UI to show selected attribute values
        update();
      },
    );
  }

  fetchRegisterFormData() async {
    setBusy(true);

    SuccessOrError result = await _authApi.getRegisterFormData();

    if (result.success) {
      registerFormData = result.response?.data;
      if(kDebugMode){
        registerFormData?.firstName = 'm';
        registerFormData?.lastName = 'm';
        registerFormData?.username = 'm';
        registerFormData?.email = 'mush@g.com';
        registerFormData?.confirmEmail = 'mush@g.com';
        registerFormData?.confirmEmail = 'mush@g.com';
        registerFormData?.gender = 'M';
        registerFormData?.password = 'Abc@123';
        registerFormData?.confirmPassword = 'Abc@123';
      }
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  postRegisterFormData(
      RegisterFormData data, List<FormValue> formValues) async {
    RegistrationReqBody reqBody = RegistrationReqBody(
        data: data.copyWith(availableStates: []), formValues: formValues);
    postRegisterAndHandleResponse(reqBody);
  }

  postRegisterWithBasAuth(
    RegisterFormData data,
    List<FormValue> formValues,
  ) async {
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
    // var (AuthCodeData? auth, String? err) = await BasService.instance.getBasAuthCode(basSettingsResult.data!.clientId!);
    BasSettingsData basSettingsData = basSettingsResult.response?.data;
    var (AuthCodeData? auth, String? err) =
        await BasService.instance.getBasAuthCode(basSettingsData.clientId!);
    if (err.isNotNullOrEmpty) {
      // logger.e('err from callBasLogin=>$err');
      printBasResult('err from callBasLogin=>$err');
      // loginResponseSink.add(ApiResponse.error(err));
      buildErrorSnackBar(msg: err);
    } else {
      printBasResult('postRegisterFormData=${data.toJson()}');
      RegistrationReqBody reqBody = RegistrationReqBody(
        data: data.copyWith(
          availableStates: [],
          customProperties: CustomProperties(
            customerBASAuthCode: auth?.authId,
          ),
        ),
        formValues: formValues,
      );
      printBasResult('postRegisterFormData.reqBody=>${reqBody.toJson()}');
      printBasResult('postRegisterFormData.customProperties=>${reqBody.data?.customProperties?.toJson()}');
      postRegisterAndHandleResponse(reqBody);
    }
  }

  postRegisterAndHandleResponse(RegistrationReqBody reqBody) async {
    showProgressDialog();
    SuccessOrError result = await _authApi.postRegisterFormData(reqBody);
    hideProgressDialog();
    if (result.success) {
      RegisterFormData data = result.response?.data;
      printBasResult('// completeRegisterWithBasUserData=.$completeRegisterWithBasUserData');
      // showSnackBar(context, message ?? '', false);
      // close the screen
      await Future.delayed(const Duration(microseconds: 250));
      Get.back(
        result: completeRegisterWithBasUserData
            ? {
                'email': data.email,
                'pass': data.password,
              }
            : null,
      );
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  Future<void> onSBTab() async {
    // return Get.toNamed(TabsScreenView.routeName);
    Get.focusScope?.unfocus();
    if (formKey.currentState?.validate() ?? false) {
      if (noInternetConnection) {
        return await onNOInternetConnection();
      }

      btnController.start();
      formKey.currentState?.save();

      Map<String, dynamic> allValues = formKey.currentState!.value;

      // AppUser user = AppUser(
      //   name: allValues[AppStrings.userName],
      //   email: allValues[AppStrings.email],
      //   password: allValues[AppStrings.password],
      //   fcmToken: await PushNotificationService.instance.getToken(),
      // );
      //
      // SuccessOrError result = await _authApi.postRegisterFormData(user);
      //
      // logger.i(result.toJson);
      // btnController.stop();

      /*if (result.success && result.response?.data is AppAuthData) {
        await userAuthController.saveUserToLocalStorage(result.response?.data);
        return Get.offAllNamed(
          TabsScreenView.routeName,
        );
      } else {
        buildErrorSnackBar(msg: result.toString());
        return;
      }*/
    }
  }

  onSubmit(RegisterFormData formData) async{
    Get.focusScope?.unfocus();
    if (noInternetConnection) {
      return await onNOInternetConnection();
    }
    String attrErrorMsg = attributeManager
        .checkRequiredAttributes(formData.customerAttributes ?? []);
    String gdprErrorMsg = '';

    formData.gdprConsents?.forEach((element) {
      if (element.isRequired == true && element.accepted == false) {
        gdprErrorMsg = '$gdprErrorMsg${element.requiredMessage ?? ''}\n';
      }
    });
    gdprErrorMsg.trimRight();
    if (attrErrorMsg.isNotNullOrEmpty) {
      // showSnackBar(context, attrErrorMsg, true);
      buildErrorSnackBar(msg: attrErrorMsg);
      return;
    } else if ((formData.acceptPrivacyPolicyEnabled) &&
        !(formData.acceptPrivacyPolicyPopup)) {
      buildErrorSnackBar(msg: ConstStrings.REGISTER_ACCEPT_PRIVACY.translate);
      return;
    } else if (gdprErrorMsg.isNotNullOrEmpty) {
      buildErrorSnackBar(msg: gdprErrorMsg.translate);
      return;
    } else {
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState?.save();

        if (completeRegisterWithBasUserData) {
          postRegisterWithBasAuth(
              formData,
              attributeManager.getSelectedAttributes('customer_attribute') ??
                  []);
        } else {
          postRegisterFormData(
              formData,
              attributeManager.getSelectedAttributes('customer_attribute') ??
                  []);
        }
      }
    }
  }

  //region States logic
  @override
  RxBool loadingStates = RxBool(false);

  // RxList<AvailableOption> statesList = RxList();
  fetchStatesByCountryId(int countryId) async {
    if (countryId == -1) return;
    loadingStates.value = true;

    SuccessOrError response = await _authApi.getStatesByCountry(countryId);

    if (response.success) {
      List<AvailableStates> availableStates = response.response?.data ?? [];
      // statesList.value = availableStates.map((e) => AvailableOption(text: e.name, value: e.id.toString())).toList();
      registerFormData?.availableStates = availableStates
          .map((e) => AvailableOption(text: e.name, value: e.id.toString()))
          .toList();
    } else {
      registerFormData?.availableStates = List<AvailableOption>.empty();
      buildErrorSnackBar(msg: response.error.toString());
    }

    loadingStates.value = false;
  }
//endregion
}

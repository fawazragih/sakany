import 'package:app_extensions/app_extensions.dart';
import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/api_providers/auth_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/get_avatar_response.dart';
import 'package:sakani/app/data/models/register_form_response.dart';
import 'package:sakani/app/data/models/requestbody/form_value.dart';
import 'package:sakani/app/data/models/user_login_response.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:sakani/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';

import '../../../data/models/requestbody/registration_req_body.dart';
import '../../../utils/api_env_config/app_logger_config.dart';

class UpdateUserProfileController extends BaseController {
  final AuthApi _authApi = AuthApi();

  RegisterFormData? registerFormData;

  bool get fetchAvatar => appLandingData?.allowCustomersToUploadAvatars == true;

  late CustomAttributeManager attributeManager;

  @override
  void onInit() {
    super.onInit();

    fetchCustomerInfo();

    attributeManager = CustomAttributeManager(
      context: Get.context,
      onClick: (priceAdjNeeded) {
        // updating UI to show selected attribute values
        update();
      },
    );

    // _bloc.deleteAccountStream.listen((event) {
    //   if (event.status == Status.COMPLETED) {
    //     DialogBuilder(context).hideLoader();
    //     // Move to home page
    //     DialogBuilder(context).hideLoader();
    //     SessionData().clearUserSession().then((value) =>
    //         Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false));
    //   } else if (event.status == Status.ERROR) {
    //     DialogBuilder(context).hideLoader();
    //     showSnackBar(context, event.message ?? '', true);
    //   } else if (event.status == Status.LOADING) {
    //     DialogBuilder(context).showLoader();
    //   }
    // });
  }

  fetchCustomerInfo() async {
    setBusy(true);
    SuccessOrError result = await _authApi.getCustomerInfo();
    if (result.success) {
      registerFormData = result.response?.data;
      setInitiallySelectedItems(registerFormData);
      if (fetchAvatar) {
        fetchCustomerAvatar();
      } else {
        setBusy(false);
      }
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  setInitiallySelectedItems(RegisterFormData? formData) {
    //TODO byMe
    logger.d('TODO');
    // if (selectedCountry != null ||
    //     selectedState != null ||
    //     selectedTimeZone != null ||
    //     formData == null) return;
    //
    // selectedCountry = formData.availableCountries?.safeFirstWhere(
    //       (element) => element.selected ?? false,
    //   orElse: () => formData.availableCountries?.safeFirst(),
    // );
    //
    // selectedState = formData.availableStates?.safeFirstWhere(
    //       (element) => element.selected ?? false,
    //   orElse: () => formData.availableStates?.safeFirst(),
    // );
    //
    // selectedTimeZone = formData.availableTimeZones?.safeFirstWhere(
    //       (element) => element.selected ?? false,
    //   orElse: () => formData.availableTimeZones?.safeFirst(),
    // );
    //
    // if (formData.dateOfBirthDay == null ||
    //     formData.dateOfBirthMonth == null ||
    //     formData.dateOfBirthYear == null) {
    //   userDob = null;
    // } else {
    //   userDob = DateTime(formData.dateOfBirthYear!, formData.dateOfBirthMonth!,
    //       formData.dateOfBirthDay!);
    // }
    //
    // privacyAccepted = false;
  }

  GetAvatarData? avatarData;

  fetchCustomerAvatar() async {
    SuccessOrError result = await _authApi.fetchAvatar();
    if (result.success) {
      avatarData = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
    //TODO ui
    //     StreamBuilder<ApiResponse<GetAvatarData>>(
    //         stream: _bloc.avatarStream,
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData &&
    //               snapshot.data?.status == Status.COMPLETED) {
    //             return CircleAvatar(
    //               backgroundImage:
    //               (snapshot.data?.data?.avatarUrl?.isNotEmpty ??
    //                   false) ==
    //                   true
    //                   ? NetworkImage(
    //                   snapshot.data?.data?.avatarUrl ?? '')
    //                   : const AssetImage('assets/user.png')
    //               as ImageProvider,
    //               backgroundColor: Colors.grey[200],
    //               radius: 50,
    //               child: Align(
    //                 alignment: Alignment.bottomCenter,
    //                 child: PopupMenuButton(
    //                   icon: const Icon(Icons.edit_outlined),
    //                   itemBuilder: (context) {
    //                     return [
    //                       PopupMenuItem(
    //                         value: 1,
    //                         child: Text(_globalService
    //                             .getString(Const.COMMON_UPLOAD)),
    //                       ),
    //                       if (snapshot.data?.data?.avatarUrl
    //                           ?.isNotEmpty ==
    //                           true)
    //                         PopupMenuItem(
    //                           value: 2,
    //                           child: Text(_globalService.getString(
    //                               Const.ACCOUNT_REMOVE_AVATAR)),
    //                         )
    //                     ];
    //                   },
    //                   onSelected: (int index) async {
    //                     if (index == 1) {
    //                       // upload
    //                       FilePickerResult? result =
    //                       await FilePicker.platform.pickFiles(
    //                         // type: FileType.image,
    //                         allowMultiple: false,
    //                       );
    // //TODO: edit default max value to the appropriate value
    //                       var maxSize = _globalService
    //                           .getAppLandingData()
    //                           ?.avatarMaximumSizeBytes ??
    //                           0;
    //
    //                       if (result != null &&
    //                           result.files.single.size > maxSize) {
    //                         var msg =
    //                         _globalService.getStringWithNumber(
    //                             Const.ACCOUNT_AVATAR_SIZE,
    //                             _globalService
    //                                 .getAppLandingData()
    //                                 ?.avatarMaximumSizeBytes ??
    //                                 50);
    //                         showSnackBar(context, msg, true);
    //                       } else if (result != null &&
    //                           result.files.single.size < maxSize) {
    //                         _bloc.uploadAvatar(
    //                             result.files.single.path ?? '');
    //                       }
    //                     } else if (index == 2) {
    //                       // remove
    //                       _bloc.removeAvatar();
    //                     }
    //                   },
    //                 ),
    //               ),
    //             );
    //           } else {
    //             return const SizedBox.shrink();
    //           }
    //         }),
  }

  posCustomerInfo(RegisterFormData data, List<FormValue> formValues) async {
    RegistrationReqBody reqBody = RegistrationReqBody(
      data: data.copyWith(availableStates: []),
      formValues: formValues,
    );

    showProgressDialog();
    SuccessOrError result = await _authApi.updateCustomerInfo(reqBody);

    if (result.success) {
      RegisterFormData data = result.response?.data;
      // Save updated info to disk
      // var info = await SessionData().getCustomerInfo();
      CustomerInfo? info = userAuthController.currentUser;
      info
        ?..firstName = data.firstName ?? ''
        ..lastName = data.lastName ?? ''
        ..email = data.email ?? ''
        ..username = data.username ?? '';

      if (info != null) {
        // SessionData().setCustomerInfo(info);
        userAuthController.saveUserToLocalStorage(
            userAuthController.currentAuthToken!, info);
      }
      hideProgressDialog();
      buildSuccessSnackBar(msg: ConstStrings.UPDATED_SUCCESSFULLY.translate);
    } else {
      hideProgressDialog();
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  onSubmit(RegisterFormData formData) {
    Get.focusScope?.unfocus();

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
        posCustomerInfo(formData,
            attributeManager.getSelectedAttributes('customer_attribute'));
      }
    }
  }
}

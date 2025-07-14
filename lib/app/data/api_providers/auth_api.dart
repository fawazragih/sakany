import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/api_providers/share_api.dart';
import 'package:sakani_mobile_app/app/data/models/bas_settings_response.dart';
import 'package:sakani_mobile_app/app/data/models/get_avatar_response.dart';
import 'package:sakani_mobile_app/app/data/models/register_form_response.dart';
import 'package:sakani_mobile_app/app/data/models/requestbody/registration_req_body.dart';

import '../models/login_form_response.dart';
import '../models/requestbody/user_login_req_body.dart';
import '../models/user_login_response.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class AuthApi extends BaseApi with SharedApi {
  Future<SuccessOrError> fetchLoginFormData() async {
    return await dio
        .get(
          ApiEndpoints.userLogin,
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<LoginFormData, LoginFormData>.fromJson(
            json: data,
            serialize: LoginFormData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> login(UserLoginReqBody user) async {
    return await dio
        .post(
          ApiEndpoints.userLogin,
          data: user.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<UserLoginData, UserLoginData>.fromJson(
            json: data,
            serialize: UserLoginData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getRegisterFormData() async {
    return await dio.get(ApiEndpoints.userRegister).mapFromResponse(
          (data) =>
              GeneralResponseModel<RegisterFormData, RegisterFormData>.fromJson(
            json: data,
            serialize: RegisterFormData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> postRegisterFormData(
      RegistrationReqBody reqBody) async {
    return await dio
        .post(
          ApiEndpoints.userRegister,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<RegisterFormData, RegisterFormData>.fromJson(
            json: data,
            serialize: RegisterFormData.fromJson,
          ),
        );
  }

  ///...

  forgetPassword(String email) async {
    //TODO
  }

  Future<SuccessOrError> changePassword(String oldPass, String newPass) async {
    return await dio.post(
      ApiEndpoints.passwordChange,
      data: {
        "oldPassword": oldPass,
        "password": newPass,
      },
    ).mapFromResponse(
      (data) => GeneralResponseModel(
        success: true,
        message: data['message'],
      ),
    );
  }

  ///
  Future<SuccessOrError> performLogout() async {
    return await dio
        .get(
          ApiEndpoints.userLogout,
        )
        .mapFromResponse(
          (data) => GeneralResponseModel.fromJson(json: data),
        );
  }

  @override
  Future<SuccessOrError> getBasSettings() async {
    return await dio.get(ApiEndpoints.basClientSetting).mapFromResponse(
          (data) =>
              GeneralResponseModel<BasSettingsData, BasSettingsData>.fromJson(
            json: data,
            serialize: BasSettingsData.fromJson,
          ),
        );
  }

  ///..

  Future<SuccessOrError> getCustomerInfo() async {
    return await dio
        .get(
          ApiEndpoints.customerInfo,
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<RegisterFormData, RegisterFormData>.fromJson(
            json: data,
            serialize: RegisterFormData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchAvatar() async {
    return await dio.get(ApiEndpoints.getAvatar).mapFromResponse(
          (data) => GeneralResponseModel<GetAvatarData, GetAvatarData>.fromJson(
            json: data,
            serialize: GetAvatarData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> updateCustomerInfo(RegistrationReqBody reqBody) async {
    return await dio
        .post(ApiEndpoints.customerInfo, data: reqBody)
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<RegisterFormData, RegisterFormData>.fromJson(
            json: data,
            serialize: RegisterFormData.fromJson,
          ),
        );
  }
}

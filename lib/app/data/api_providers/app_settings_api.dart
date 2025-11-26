import 'package:tamoily/app/data/api_providers/base_configs/api_paths.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/app_landing_response.dart';

import '../models/requestbody/app_start_req_body.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/base_api.dart';

class AppSettingsApi extends BaseApi {
  Future<SuccessOrError> getAppLanding() async {
    return await dio.get(ApiEndpoints.appLandingSettings).mapFromResponse(
          (data) =>
              GeneralResponseModel<AppLandingData, AppLandingData>.fromJson(
            json: data,
            serialize: AppLandingData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> postFcmToken(AppStartData data) async {
    return await dio.post(
      ApiEndpoints.appStart,
      data: {"Data": data.toJson()},
    ).mapFromResponse(
      (data) => GeneralResponseModel.fromJson(json: data),
    );
  }

  Future<SuccessOrError> changeLanguage(int languageId) async {
    return await dio
        .get('${ApiEndpoints.setLanguage}/$languageId')
        .mapFromResponse(
          (data) => GeneralResponseModel.fromJson(json: data),
        );
  }

  Future<SuccessOrError> changeCurrency(int currencyId) async {
    return await dio
        .get('${ApiEndpoints.setCurrency}/$currencyId')
        .mapFromResponse(
          (data) => GeneralResponseModel.fromJson(json: data),
        );
  }
}

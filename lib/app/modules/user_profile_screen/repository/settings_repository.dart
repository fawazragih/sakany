class SettingsRepository {
  // final ApiBaseHelper _helper = ApiBaseHelper();
  //
  // Future<AppLandingResponse> fetchAppLandingSettings() async {
  //   final response = await _helper.get(Endpoints.appLandingSettings);
  //   return AppLandingResponse.fromJson(response);
  // }
  //
  // Future<BaseResponse> postFcmToken(String fcmToken) async {
  //   num deviceTypeId;
  //
  //   if (!kIsWeb && Platform.isAndroid) {
  //     deviceTypeId = 10;
  //   } else if (!kIsWeb && Platform.isIOS) {
  //     deviceTypeId = 5;
  //   } else {
  //     deviceTypeId = 20;
  //   }
  //
  //   final response = await _helper.post(
  //       Endpoints.appStart,
  //       AppStartReqBody(
  //           data: AppStartData(
  //         deviceTypeId: deviceTypeId.toInt(), // Android
  //         subscriptionId: fcmToken,
  //       )));
  //   return BaseResponse.fromJson(response);
  // }
  //
  // Future<BaseResponse> changeLanguage(int languageId) async {
  //   final response = await _helper.get('${Endpoints.setLanguage}/$languageId');
  //   return BaseResponse.fromJson(response);
  // }
  //
  // Future<BaseResponse> changeCurrency(int currencyId) async {
  //   final response = await _helper.get('${Endpoints.setCurrency}/$currencyId');
  //   return BaseResponse.fromJson(response);
  // }
}
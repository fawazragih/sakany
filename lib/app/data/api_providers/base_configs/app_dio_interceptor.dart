import 'package:app_extensions/app_extensions.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart' as getx;
import 'package:tamoily/app/core/language_and_localization/app_language_controller.dart';

// import 'package:jaguar_jwt/jaguar_jwt.dart' as jwt;
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import '../../../base_controllers_and_listeners/user_auth_controller.dart';

class AppAuthInterceptor extends QueuedInterceptor {
  final Dio dio;
//  final CookieJar cookieJar = CookieJar();
  // final RefreshUserToken refreshUserTokenHandler = RefreshUserToken.instance;
  // UserAuthController get userAuthController => getx.Get.find<UserAuthController>();

  final String _nstKey = 'bm9wU3RhdGlvblRva2Vu';
  final String _nstSecret = 'bm9wS2V5';

  static Future<Map<String, String>> get getRequestHeader async {
    /*final claimSet = jwt.JwtClaim(
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{
        'NST_KEY': _nstKey,
      },
    );*/

    // String jwtToken = jwt.issueJwtHS256(claimSet, _nstSecret);

    final UserAuthController userAuthController =
        getx.Get.find<UserAuthController>();

    Map<String, String> map = {
    //  'Cookie':
          // '.Nop.Authentication=CfDJ8GlM2dBfIsNDkl1SrY4bukFcJiSHMWo5PrM1sGHMQybJSplbmu2F3OSHXdhVUYwvEmjgJaX4JB8JEi952mMuBfXaYhxIruoVyJqUeIgutHWghs16TE4F7sHIISwNh-s-TOr3llD10ILfUP2rKODwRnG6gJcULfvrRwvSuyh_bDcHqVqmDEfv_cmUV2qpD7F_B3Nwl8G0qz5vnV6YgIthcCE6nB4c9dYYEKLbXe5yYuxzI3hGlVfX2cNe9xALAuwVt9bXMLYQ8pTG5azQgm_eSsXbSUbp_igCOuvmc2DhWoridUXjL6lchE_INQHvPAoMetOLQaO0N67Y0-nLWGSah1MDp97wHYYIMIoayVO7pGRaNQxs23pNvLg8cOikt-JUSRt4aYBsLuyb8Q_8Te54WHrjxS-S23HOvEJ0L9drX6Vr9H6ZEWJMJtMkdSB7Pq_mVkowk7O1uVLD2MvwLcakKHpcRam3v1OxLrQgQCuJMITMjiArVMf_6VZ_KZkdDs9hal1OtHCgCP5LOb4M1whGaKp3WU36yn0XZMle7Dky1lo_-stzIe0OhozjmxGPlD-DU64qK1xBOR9OHqAIdZCzW_w; .Nop.Culture=c%3Den-US%7Cuic%3Den-US; .Nop.Customer=5e139e2d-0a95-43ab-bb22-e47646e14470; .Nop.Customer.DeviceId=6H5BLCbL1T9mBLs; .Nop.Customer.Token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJDdXN0b21lcklkIjoxMCwiZXhwIjoxNzY4MDc5ODIyLjB9.tqS8wUZDRh-miJF2BqUyE0yOgM8om8sL6GmBlYBcris; .Nop.Tenant=bca1caa7-8766-45e7-bf20-0825990e709c',
        'X-Tenant-Id' : "bca1caa7-8766-45e7-bf20-0825990e709c",
      // 'NST': jwtToken,
      // 'NST': 'eyJhbGciOiJIUzUxMiJ9.eyJOU1RfS0VZIjoiU1lTVEVNX05TVF9LRVkifQ.dP4gMEM3iT23ighaxsOfxBFQOzb2BkVkKfSem_4OUCM1vDh60EK8x80EEkQY9QPK2hnKpazUG6XRbQqkYrS0fg',
      'NST':
          'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJOU1RfS0VZIjoiVGFtd2VlbCJ9.fgtuZvm_g0ng_Pn52QxRb_b9xzMCuCtSjqCBFxmMDXSEWd2PuksQWcFFUmaRzWG0lt_PJfIPIKVtOuzphy5JcA',
      'deviceId': await userAuthController.fetchDeviceId() ?? '',
      // 'Content-Type': isFormData ? '' : 'application/json',
      'Accept': 'application/json',
      'lang':
          getx.Get.find<AppLanguageController>().appLocale.value.languageCode,
      // 'User-Agent': 'nopstationcart.flutter/v1'
    };

    if (userAuthController.currentAuthToken.isNotNullOrEmpty) {
      // map['Token'] = userAuthController.currentAuthToken ?? '';
    }

    map.removeWhere((key, value) => value.isEmpty);

    return map;
  }

  AppAuthInterceptor(this.dio) {
    //   dio.interceptors.add(CookieManager(cookieJar));
  }

  @override
  Future onRequest(RequestOptions options, handler) async {
    ///for test only
    // options.headers.addAll({
    //   "authorization":
    //       "Bearer 3|laravel_sanctum_lBsqXFPbLBgQrob6vsHu8aRys58v51UCbi9l6Y80d61e0df3"
    // });

    options.headers.addAll(await getRequestHeader);

    return handler.next(options);
  }

  ///....
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    // logger.d("onResponse ${response.data}");
    // var token = response.requestOptions.headers[autInHeader];
    // logger.d(
    //     "request url=> ${response.requestOptions.uri} \n status code=> ${response.statusCode} \n request data => ${response.data}");
    // return handler.next(response);
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.e(
        '${err.response?.statusCode}\n${err.requestOptions.method.toUpperCase()} \n${err.response?.realUri}');

 //   '${err.requestOptions.method.toUpperCase()}\n${err.requestOptions.uri.toString()}\n${err.message}\n${err.response?.statusCode}')

    // logger.d(err.message);
    // logger.d(error.response?.data);
    // logger.d('onError -- $counter');

    // if (err.error is SocketException) {}

    if (err.response?.statusCode == 401) {
      /// TODO implement refresh token;
      /// and then go resolve old err.requestOptions;
      // return handler.resolve(await _retry(err.requestOptions));
    }

    return handler.next(err);

    // return super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions oldRequest) async {
    final options = Options(
      method: oldRequest.method,
      headers: oldRequest.headers,
    );
    logger.d('#######> _retry');
    return dio.request<dynamic>(
      oldRequest.path,
      data: oldRequest.data,
      queryParameters: oldRequest.queryParameters,
      options: options,
    );
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:sakani_mobile_app/app/core/language_and_localization/app_language_controller.dart';

// import 'package:jaguar_jwt/jaguar_jwt.dart' as jwt;
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import '../../../base_controllers_and_listeners/user_auth_controller.dart';

class AppAuthInterceptor extends QueuedInterceptor {
  final Dio dio;

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
      // 'NST': jwtToken,
      // 'NST': 'eyJhbGciOiJIUzUxMiJ9.eyJOU1RfS0VZIjoiU1lTVEVNX05TVF9LRVkifQ.dP4gMEM3iT23ighaxsOfxBFQOzb2BkVkKfSem_4OUCM1vDh60EK8x80EEkQY9QPK2hnKpazUG6XRbQqkYrS0fg',
      'NST':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOU1RfS0VZIjoiU1lTVEVNX05TVF9LRVkifQ.TYQ_gGGwpTjEfjqD8HmyffFjdYGh9ZptkVysAqGWYfg',
      'deviceId': await userAuthController.fetchDeviceId() ?? '',
      // 'Content-Type': isFormData ? '' : 'application/json',
      'Accept': 'application/json',
      'lang': getx.Get.find<AppLanguageController>().appLocale.value.languageCode,
      // 'User-Agent': 'nopstationcart.flutter/v1'
    };

    if (userAuthController.currentAuthToken.isNotNullOrEmpty) {
      map['Token'] = userAuthController.currentAuthToken ?? '';
    }

    map.removeWhere((key, value) => value.isEmpty);

    return map;
  }

  AppAuthInterceptor(this.dio);

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

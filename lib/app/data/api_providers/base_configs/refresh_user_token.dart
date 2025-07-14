// import 'package:get/get.dart';
// import 'package:logger/logger.dart';
// import '../../../base_controllers_and_listeners/user_auth_controller.dart';
// import '../../models/app_auth_data.dart';
// import 'package:get/get.dart' as getx;
//
// class RefreshUserToken {
//   RefreshUserToken._();
//
//   static final RefreshUserToken _instance = RefreshUserToken._();
//
//   static RefreshUserToken get instance => _instance;
//
//   final Logger logger = Logger();
//
//   UserAuthController get userAuthController =>
//       getx.Get.find<UserAuthController>();
//
//   AppAuthData? get currentAuthData {
//     return userAuthController.currentAuthData;
//   }
//
//   // String? _userToken;
//   // AppToken? _userToken;
//
//   String? _tempAccessToken;
//   // String? _tempRefreshToken;
//   // set userToken(AppToken? value) {
//   //   _tempAccessToken = currentAuthData?.token?.accessToken;
//   //   _tempRefreshToken = currentAuthData?.token?.refreshToken;
//   //   currentAuthData?.token = value;
//   //   _userToken = value;
//   // }
//
//   // AppToken? get getUserToken => _userToken ?? currentAuthData?.token;
//
//   set userToken(String? value) {
//     _tempAccessToken = currentAuthData?.token;
//     currentAuthData?.token = value;
//     // _userToken = value;
//   }
//
//   // bool get canRefresh {
//   //   if (_tempRefreshToken != null && _tempAccessToken != null) {
//   //     return true;
//   //   }
//   //   return false;
//   // }
//
//   // getNewToken(RequestOptions options, RequestInterceptorHandler handler,
//   //     Dio dio) async {
//   //   logger.d('#######> no token，request token firstly...');
//   //
//   //   if (!canRefresh) {
//   //     logger.d('_tempAccessToken == null || _tempAccessToken == null');
//   //     return getx.Get.offAllNamed(LoginScreen.routeName);
//   //   }
//   //   return await AuthApi()
//   //       .getAccessToken(
//   //     accessToken: _tempAccessToken!,
//   //     refreshToken: _tempRefreshToken!,
//   //   )
//   //       .then((value) async {
//   //     logger.d(value.toString());
//   //     logger.d(value.runtimeType);
//   //     if (value != null &&
//   //         value is GeneralResponseModel &&
//   //         value.success &&
//   //         value.data is AppAuthData) {
//   //       AppAuthData newAuthData = value.data;
//   //       _userToken = newAuthData.token;
//   //       // logger.d(_userToken!);
//   //       options.headers['Authorization'] = newAuthData.token?.bearerAccessToken;
//   //       logger.d('#######> new token is has set');
//   //       await userAuthController.saveUserToLocalStorage(newAuthData);
//   //       logger.d('#######> new user is has set');
//   //       logger.d(currentAuthData?.token?.bearerAccessToken);
//   //       return handler.next(options);
//   //     } else {
//   //       logger.e(value.toString());
//   //       getx.Get.offAllNamed(LoginScreen.routeName);
//   //       return handler.reject(DioException(requestOptions: options), true);
//   //     }
//   //   }).catchError((error, stackTrace) {
//   //     getx.Get.offAllNamed(LoginScreen.routeName);
//   //     logger.d('catchError=>${error.toString()}');
//   //     return handler.reject(error, true);
//   //   });
//   // }
// }

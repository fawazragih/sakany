import 'package:app_extensions/app_extensions.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/api_providers/auth_api.dart';
import 'package:sakani/app/data/models/user_login_response.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';

import '../data/local_data/session_service.dart';
import '../utils/utility.dart';
import 'helpers_methods.dart';

class UserAuthController extends GetxService with HelpersMethods {
  final SessionServiceWithSecureStorage _sessionService =
      SessionServiceWithSecureStorage.instance;

  String? _currentAuthToken;

  String? get currentAuthToken => _currentAuthToken;

  CustomerInfo? _currentUser;

  CustomerInfo? get currentUser => _currentUser;

  RxBool authenticated = RxBool(false);

  setCurrentAuthData(String? authToken,
      {CustomerInfo? customerInfo, bool notify = true}) {
    _currentUser = customerInfo;
    _currentAuthToken = authToken;
    authenticated.value = _checkAuthenticated;
    if (notify) {
      Get.forceAppUpdate();
    }
  }

  bool get _checkAuthenticated =>
      currentUser != null && currentAuthToken.isNotNullOrEmpty;

  Future saveUserToLocalStorage(
    String authToken,
    CustomerInfo customerInfo,
  ) async {
    var result = await _sessionService.saveUserInfoToLocalStorage(
      authToken,
      customerInfo,
    );
    logger.d(result);
    if (result is bool && result) {
      setCurrentAuthData(
        authToken,
        customerInfo: customerInfo,
        notify: true,
      );
      return true;
    } else {
      return false;
    }
  }

  signUserOut() async {
    await AuthApi().performLogout();
    await _sessionService.signOut();
    setCurrentAuthData(null, notify: true);
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchDeviceId();
    setCurrentAuthData(
      _sessionService.authToken,
      customerInfo: _sessionService.currentUserInfo,
      notify: false,
    );
  }

  //region deviceID
  String? _deviceID;
  // String? get deviceID => _deviceID;
  Future<String> fetchDeviceId() async {
    if(_deviceID.isNotNullOrEmpty){
      return _deviceID!;
    }
    final savedDeviceId = await _sessionService.fetchDeviceId();
    if (savedDeviceId.isNullOrEmpty) {
      String newDeviceId = generateRandomDeviceId();
      logger.d('newDeviceId => $newDeviceId');
      _sessionService.setDeviceId(newDeviceId);
      _deviceID = newDeviceId;
    } else {
      _deviceID = savedDeviceId;
    }

    return _deviceID!;
  }

//endregion
}

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';

import '../models/user_login_response.dart';

class SessionServiceWithSecureStorage {
  SessionServiceWithSecureStorage._();

  static final SessionServiceWithSecureStorage _instance =
      SessionServiceWithSecureStorage._();

  static SessionServiceWithSecureStorage get instance => _instance;

  ///..............
  final String _keyCurrentUser = '_keyCurrentUser';

  static const _keyAuthToken = '_keyAuthToken';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
  );

  ///...
  String? _authToken;

  String? get authToken => _authToken;

  String? _deviceId;

  String? get deviceId => _deviceId;

  CustomerInfo? _currentUserInfo;

  CustomerInfo? get currentUserInfo => _currentUserInfo;

  setupDb() async {
    return await fetchCurrentUser();
  }

  fetchCurrentUser() async {
    _authToken = await _secureStorage.read(key: _keyAuthToken);
    logger.d('============> current authToken is $authToken');

    //region fetch customerInfoData
    var customerInfoData = await _secureStorage.read(key: _keyCurrentUser);
    if (customerInfoData != null) {
      // var user = Map<String, dynamic>.from(jsonDecode(data));
      _currentUserInfo = CustomerInfo.fromJson(jsonDecode(customerInfoData));
      logger.d('============> current user is ${currentUserInfo?.toJson()}');
    } else {
      logger.d('============> current user is none');
    }
    //endregion
  }

  saveUserInfoToLocalStorage(String authToken,
      [CustomerInfo? customerInfo]) async {
    try {
      _currentUserInfo = customerInfo;
      _authToken = authToken;

      await _secureStorage.write(key: _keyAuthToken, value: authToken);
      logger
          .d('===> authToken ===> $authToken successfully saved to local data');

      if (customerInfo != null) {
        await _secureStorage.write(
          key: _keyCurrentUser,
          value: jsonEncode(customerInfo),
        );
        logger.d('===> user ===> ${customerInfo.toJson()} successfully saved to local data');
      }

      return true;
    } catch (e) {
      logger.e('== Error in UserSession == saveUserInfoToHive ==');
      logger.e(e.toString());
      logger.e('.......');
      return e.toString();
    }
  }

  bool checkUserSignIn() {
    if (currentUserInfo != null) {
      return true;
    } else {
      return false;
    }
  }

  Future signOut() async {
    _currentUserInfo = null;
    _authToken = null;
    if (await _secureStorage.read(key: _keyCurrentUser) != null) {
      await _secureStorage.delete(key: _keyCurrentUser);
    }
    if (await _secureStorage.read(key: _keyAuthToken) != null) {
      await _secureStorage.delete(key: _keyAuthToken);
    }
  }


  //region DeviceId

  static const _keyDeviceId = '_keyDeviceId';

  Future<String?> fetchDeviceId() async {
    _deviceId = await _secureStorage.read(key: _keyDeviceId);
    logger.d('============> current _keyDeviceId is $deviceId');
    return _deviceId;
  }

  setDeviceId(String id) async {
    try {
      _deviceId = id;
      await _secureStorage.write(key: _keyDeviceId, value: _deviceId);
      logger.d('===> _deviceId ===> $_deviceId successfully saved to local data');
      return true;
    } catch (e) {
      logger.e('== Error in Set deviceId ==');
      logger.e(e.toString());
      logger.e('.......');
      return e.toString();
    }
  }
  //endregion

}

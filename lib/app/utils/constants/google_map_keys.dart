import 'package:get/get.dart';

class GoogleMapApiKeys {
  GoogleMapApiKeys._();

  //TODO change to YKB key

  static const String _androidApiKey =
      'AIzaSyDGUaGrETLobFVqFjSvWWV0c1d_c2yDGEs';
  // 'AIzaSyCKBIVyTfBckSwB7RXIkN9SYNAqkcWIV2E';//basApp

  //TODO paste ios key here
  static const String _iOSApiKey = '';

  static String get getKey {
    if (GetPlatform.isAndroid) {
      return _androidApiKey;
    }
    if (GetPlatform.isIOS) {
      return _iOSApiKey;
    }
    return '';
  }
}

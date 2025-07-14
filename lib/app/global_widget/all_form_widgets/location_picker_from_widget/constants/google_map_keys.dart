import 'package:get/get.dart';

class GoogleMapApiKeys {
  GoogleMapApiKeys._();

  //TODO change to Kitsys key

  static const String _androidApiKey =
      'AIzaSyDGUaGrETLobFVqFjSvWWV0c1d_c2yDGEs';

  //TODO paste ios key here
  static const String _iOSApiKey = '';
  static const String _webApiKey = 'AIzaSyCrezEYyPXO65RVR3JbgFXNwmv-3tnt3hk';

  static String get getKey {
    if (GetPlatform.isWeb) {
      return _webApiKey;
    }
    if (GetPlatform.isAndroid) {
      return _androidApiKey;
    }
    if (GetPlatform.isIOS) {
      return _iOSApiKey;
    }
    return '';
  }
}

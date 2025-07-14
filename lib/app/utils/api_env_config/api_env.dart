
import 'package:app_extensions/app_extensions.dart';

abstract class BackendEnv {
  // BaseUrls._();
  // static final BaseUrls _instance = BaseUrls._();
  // String get privacyPolicyURL;

  String get baseUrl;

  String get identityUrl;

// /// shared urls
// ///.. privacyPolicyURL
// String get privacyPolicyURL => 'https://app.com/privacy_policy/';
}

class KitSysEnv extends BackendEnv {
  @override
  String get baseUrl => 'https://ecommerce.ks3.kitsys.site';

  @override
  String get identityUrl => baseUrl;
}

class ClothesEnv extends BackendEnv {
  @override
  // String get baseUrl => 'https://ms-store.demo.maujood.store';
  // String get baseUrl => 'https://ysf-store.demo2.maujood.store';
  // String get baseUrl => 'http://ms-store.crabdance.com';
  String get baseUrl => 'https://saas-web-tst.yk-bank.com:9003';

  // String get baseUrl =>  kIsWeb?'https://ms-store.demo.maujood.store' :'https://clothes.ks3.kitsys.site';

  @override
  String get identityUrl => baseUrl;
}

class BooksEnv extends BackendEnv {
  @override
  String get baseUrl => 'https://book.ks3.kitsys.site';

  @override
  String get identityUrl => baseUrl;
}

class ElectronicsEnv extends BackendEnv {
  @override
  String get baseUrl => 'https://electronic.ks3.kitsys.site';

  @override
  String get identityUrl => baseUrl;
}

class LocalhostEnv extends BackendEnv {
  LocalhostEnv._();

  static final LocalhostEnv instance = LocalhostEnv._();

  String? _baseUrl;

  set baseUrl(String value) {
    _baseUrl = value;
  }

  @override
  String get baseUrl {
    if (_baseUrl.isNotNullOrEmpty) {
      return _baseUrl!.endsWith('/')
          ? _baseUrl!.substring(0, _baseUrl!.length - 1)
          : _baseUrl!;
    }
    return '';
  }

  @override
  String get identityUrl => baseUrl;
}

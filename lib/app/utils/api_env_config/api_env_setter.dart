import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'api_env.dart';
import 'app_logger_config.dart';

enum EnvType {
  kitSys,
  clothes,
  electronic,
  books,
  localhost,
}

class BuildEnvironment {
  BuildEnvironment._();

  static final BuildEnvironment instance = BuildEnvironment._();

  late EnvType envType = EnvType.clothes;

  Map<String, BackendEnv> get _backendEnvMap => {
        'kitSys': KitSysEnv(),
        'clothes': ClothesEnv(),
        'books': BooksEnv(),
        'electronic': ElectronicsEnv(),
        'localhost': LocalhostEnv.instance,
      };

  // bool get isStage => envType == EnvType.stage;

  bool get isGooglePlayProduction {
    // logger.w(appFlavor);
    return !isLiveFlavor &&
        !isClothesFlavor &&
        !isBooksFlavor &&
        !isElectronicsFlavor;
  }

  bool get isLiveFlavor {
    // final flavor = await platform.invokeMethod("getFlavor");
    // appFlavor is from 'package:flutter/services.dart'
    // logger.w(appFlavor);
    return appFlavor?.toLowerCase().contains('kitSys'.toLowerCase()) == true;
  }

  bool get isClothesFlavor =>
      appFlavor?.toLowerCase().contains('clothes'.toLowerCase()) == true;

  bool get isLocalhostFlavor =>
      appFlavor?.toLowerCase().contains('localhost'.toLowerCase()) == true;

  bool get isBooksFlavor =>
      appFlavor?.toLowerCase().contains('books'.toLowerCase()) == true;

  bool get isElectronicsFlavor =>
      appFlavor?.toLowerCase().contains('electronic'.toLowerCase()) == true;

  late String packageID;
  late String appVersion;
  String? buildNumber;

  String appVersionText({bool hideAppVersion = false}) {
    String version = appVersion ?? '';
    if (appVersion.isNullOrEmpty || buildNumber.isNullOrEmpty) {
      return '';
    }
    if (!BuildEnvironment.instance.isGooglePlayProduction && !hideAppVersion) {
      int index = appVersion.lastIndexOf('.');
      version = appVersion.replaceRange(index, appVersion.length, '');
    }
    if (hideAppVersion) {
      return buildNumber ?? '';
    }
    return "[$version - ${buildNumber ?? ''}]";
  }

  /// set BuildEnvironment depending on packageName;
  Future<void> setBuildEnvironment() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    packageID = packageInfo.packageName;

    packageID = packageInfo.packageName;
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    String packageNameEnv = packageInfo.packageName.split('.').last;

    envType = kIsWeb
        ? EnvType.clothes
        : EnvType.values.firstWhere(
            (element) =>
                element.name.toLowerCase() == packageNameEnv.toLowerCase(),
            orElse: () => EnvType.kitSys,
          );

    logger.d(
        'packageID = $packageID //// packageNameEnv = $packageNameEnv /// envType=$envType');
  }

  /// =====> ApiUrlEnvSetter
  BackendEnv get _selectedEnvSetter =>
      _backendEnvMap[envType.name] ?? KitSysEnv();

  String get baseUrl => _selectedEnvSetter.baseUrl;

  String get identityUrl => _selectedEnvSetter.identityUrl;

// String get privacyPolicyURL => _selectedEnvSetter.privacyPolicyURL;
}

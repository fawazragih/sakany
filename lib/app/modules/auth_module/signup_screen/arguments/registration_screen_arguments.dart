import 'dart:convert';

import 'package:app_extensions/app_extensions.dart';
import 'package:sakani_mobile_app/app/data/models/user_login_response.dart';
import 'package:sakani_mobile_app/app/utils/type_conversion.dart';

class RegistrationScreenArguments {
  bool? getCustomerInfo;
  bool? completeRegisterWithBasUserData;
  BasUserInfo? basUserInfo;

  RegistrationScreenArguments({
    this.getCustomerInfo = false,
    this.completeRegisterWithBasUserData = false,
    this.basUserInfo,
  });

  factory RegistrationScreenArguments.fromJson(Map<String, String?> json) {
    return RegistrationScreenArguments(
      getCustomerInfo:
          json['getCustomerInfo'].toString().valueTypeToBool ?? false,
      completeRegisterWithBasUserData:
          json['completeRegisterWithBasUserData']?.toString().valueTypeToBool ??
              false,
      basUserInfo: json['basUserInfo'] == null ||
              json['basUserInfo'].isNullOrEmpty == true
          ? null
          : BasUserInfo.fromJson(jsonDecode(json['basUserInfo']!)),
    );
  }

  Map<String, String> toJson() {
    return {
      'getCustomerInfo': getCustomerInfo?.toString() ?? '',
      'completeRegisterWithBasUserData':
          completeRegisterWithBasUserData?.toString() ?? '',
      'basUserInfo':
          basUserInfo == null ? '' : jsonEncode(basUserInfo?.toJson()),
    }..removeWhere((k, v) => v.isNullOrEmpty);
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sakani/app/core/language_and_localization/api_errors_strings.dart';

class GeneralException implements Exception {
  final String? message;
  final int? statusCode;
  final String? errorType;

  GeneralException({
    this.statusCode,
    this.errorType,
    this.message,
  });

  factory GeneralException.fromJson(Map<String, dynamic> passed) {
    Map<String, dynamic> json = passed.toCaseInsensitiveMap;

    String? message;

    if ((json['messages'] ?? json['ErrorList']) != null &&
        (json['messages'] ?? json['ErrorList']) is List) {
      message = ((json['messages'] ?? json['ErrorList']) as List)
          .map<String>((e) => e.toString())
          .toList()
          .join(',');
    }

    // logger.e(message ?? json['message'] ?? json['Message']);
    return GeneralException(
      statusCode: json['statusCode'],
      errorType: json['errorType'],
      message: message ?? (json['message'] ?? json['Message'])?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': kDebugMode ? statusCode : null,
      'errorType': kDebugMode || statusCode?.isNegative == true
          ? errorType?.toUpperCase()
          : null,
      'message': (message ?? ApiErrorsStrings.unknownError).tr,
    }..removeWhere((key, value) => value == null);
  }

  @override
  String toString() {
    return toMap().values.toList().join('\n');
  }
}

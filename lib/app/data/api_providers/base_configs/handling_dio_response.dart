import 'dart:convert';

import 'package:app_extensions/app_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';

import '../api_response_models/general_exception.dart';
import '../api_response_models/general_response_model.dart';

typedef SuccessOrError = (GeneralResponseModel?, GeneralException?);

extension SuccessOrErrorExtention on SuccessOrError {
  bool get success {
    var (GeneralResponseModel? data, GeneralException? error) = this;
    return error == null && data?.isSuccess == true;
  }

  /* bool get successStatusCode {
    var (GeneralResponseModel? data, GeneralException? error) = this;
    return data?.status == 1;
  }*/

  GeneralResponseModel? get response {
    var (GeneralResponseModel? data, GeneralException? error) = this;
    return data;
  }

  // bool isOf<T>() {
  //   return response?.data is T;
  // }

  // dynamic get data {
  //   var (GeneralResponseModel? data, GeneralException? error) = this;
  //   return data?.data;
  // }

  GeneralException? get error {
    var (GeneralResponseModel? data, GeneralException? error) = this;
    return error ??
        (data == null ? null : GeneralException.fromJson(data.toMap()));
  }

  Map<String, dynamic>? get toJson {
    var (GeneralResponseModel? data, GeneralException? error) = this;
    return data?.toMap() ?? error?.toMap();
  }
}

/// force return GeneralResponseModel
typedef OnSerializeObject = GeneralResponseModel Function(
    Map<String, dynamic> data);
typedef CustomHandle = GeneralResponseModel Function(Map<String, dynamic> data, Response<dynamic>);

extension HandleResoponse on Future<Response<dynamic>> {
  Future<SuccessOrError> mapFromResponse(OnSerializeObject myJsonParser,
      {CustomHandle? customHandle}) async {
    try {
      final response = await this;
      // logger.i(response.headers);
      // logger.i(response.realUri);
      // logger.i(response.data);
      // Map<String,dynamic> data;
      dynamic data;
      if (response.data is String && response.data.toString().isJsonString) {
        data = json.decode(response.data.toString());

      } else {
        // logger.d('is not String');
        data = jsonDecode(jsonEncode(response.data));
      }


      // logger.d(data.runtimeType);

      /*if (response.statusCode == 204) {
        // logger.i('204=> NO Content');
        return (
          myJsonParser.call({
            "data": [],
            "messages": ["ok"],
            "status": 1,
          }),
          null,
        );
      }*/

      if (customHandle != null) {
        return (customHandle.call(data, response), null);
      }

      return (myJsonParser(data), null);
      }
      catch (e, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }
      GeneralException ex = await handleError(e: e);
      return (null, ex);
    }
  }
}

/// process methods
Future<GeneralException> handleError({required e}) async {
  logger.e(e.toString());

  if (e is DioException) {
    // logger.i(e.response?.headers);
    // logger.i(e.response?.realUri);
    // logger.e(e.message);
    // logger.e(e.response);
    // logger.e(e.response?.statusCode);
    // logger.e(e.response?.data.runtimeType);
    // logger.e(e.response?.data);

    var errData;
    if (e.response?.data?.toString().isJsonString == true) {
      errData = json.decode(e.response?.data.toString() ?? '');
    } else {
      errData = jsonDecode(jsonEncode(e.response?.data));
    }
    // var errData = jsonDecode(jsonEncode(e.response?.data));
    // logger.d(errData);

    dynamic mesFromErrorData;
    if (errData is Map) {
      Map<String, dynamic> err = (errData as Map<String, dynamic>).toCaseInsensitiveMap;
      mesFromErrorData = err['messages'] ??
          err['ErrorList'] ??
          err['message'] ??
          err['data']?['error'] ??
          err['errors']?.toString() ??
          err['detail'];
    } else if (errData is List) {
      logger.d(errData);
      mesFromErrorData = errData.join(',');
    }

    String? apiErrorMessage = mesFromErrorData == null
        ? null
        : mesFromErrorData is String
            ? mesFromErrorData
            : mesFromErrorData?.toString();

    logger.e(apiErrorMessage);

    return GeneralException(
      statusCode: e.response?.statusCode,
      errorType: e.type.name,
      message: apiErrorMessage ??
          _switchDioError(e) ??
          e.response?.data ??
          e.message ??
          e.toString(),
    );
  } else {
    logger.e(e.toString());
    logger.e(e.runtimeType);
    return GeneralException(
      // statusCode: e?.response?.statusCode,
      message: e.toString(),
    );
  }
}

String? _switchDioError(DioException ex) {
  String? msg;

  switch (ex.type) {
    case DioExceptionType.connectionError:
      msg = "No internet connection";
      break;
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      msg =
          'Server is not reachable. Please verify your internet connection and try again (timeout)';
      break;
    case DioExceptionType.badCertificate:
      msg =
          "App can't work through vpn. please turn off vpn or update the app to the last version!";
      break;
    case DioExceptionType.badResponse:
      msg = 'Server error. Please connect customer service to fix the problem!';
      break;
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
      msg = null;
      break;
  }
  return msg;
}

// refactored code by ai toTry
// typedef SuccessOrError = (GeneralResponseModel?, GeneralException?);
//
// extension SuccessOrErrorExtention on SuccessOrError {
//   bool get success {
//     var (GeneralResponseModel? data, GeneralException? error) = this;
//     return error == null && data?.isSuccess == true;
//   }
//
//   /* bool get successStatusCode {
//     var (GeneralResponseModel? data, GeneralException? error) = this;
//     return data?.status == 1;
//   }*/
//
//   GeneralResponseModel? get response {
//     var (GeneralResponseModel? data, GeneralException? error) = this;
//     return data;
//   }
//
//   // bool isOf<T>() {
//   //   return response?.data is T;
//   // }
//
//   // dynamic get data {
//   //   var (GeneralResponseModel? data, GeneralException? error) = this;
//   //   return data?.data;
//   // }
//
//   GeneralException? get error {
//     var (GeneralResponseModel? data, GeneralException? error) = this;
//     return error ??
//         (data == null ? null : GeneralException.fromJson(data.toMap()));
//   }
//
//   Map<String, dynamic>? get toJson {
//     var (GeneralResponseModel? data, GeneralException? error) = this;
//     return data?.toMap() ?? error?.toMap();
//   }
// }
//
// /// force return GeneralResponseModel
// typedef OnSerializeObject = GeneralResponseModel Function(Map<String, dynamic>);
//
// extension HandleResponse on Future<Response<dynamic>> {
//   Future<SuccessOrError> mapFromResponse(OnSerializeObject myJsonParser) async {
//     try {
//       final response = await this;
//       final data = _parseResponseData(response.data);
//       return (myJsonParser(data), null);
//     } catch (e, stacktrace) {
//       return _handleException(e, stacktrace);
//     }
//   }
//
//   dynamic _parseResponseData(dynamic responseData) {
//     if (responseData is String && responseData.isJsonString) {
//       return json.decode(responseData);
//     }
//     return jsonDecode(jsonEncode(responseData));
//   }
//
//   SuccessOrError _handleException(dynamic e, StackTrace stacktrace) {
//     if (e is FormatException) {
//       return _createExceptionResponse(e, -1, 'FormatException');
//     } else if (e is TypeError) {
//       return _createExceptionResponse(e, -2, 'TypeError');
//     } else {
//       if (kDebugMode) {
//         print(stacktrace);
//       }
//       return (null, handleError(e: e));
//     }
//   }
//
//   SuccessOrError _createExceptionResponse(dynamic error, int statusCode, String errorType) {
//     if (kDebugMode) {
//       print(error.stackTrace);
//     }
//     logger.e('$errorType:::=> ${error.toString()}');
//     return (
//     null,
//     GeneralException(
//       statusCode: statusCode,
//       errorType: errorType,
//       message: '$errorType\n${error.toString()}',
//     )
//     );
//   }
// }
//
// Future<GeneralException> handleError({required dynamic e}) async {
//   logger.e(e.toString());
//
//   if (e is DioException) {
//     return _handleDioException(e);
//   } else {
//     logger.e(e.runtimeType);
//     return GeneralException(message: e.toString());
//   }
// }
//
// GeneralException _handleDioException(DioException e) {
//   final errData = _parseErrorData(e.response?.data);
//   final apiErrorMessage = _extractErrorMessage(errData);
//
//   logger.e(apiErrorMessage);
//
//   return GeneralException(
//     statusCode: e.response?.statusCode,
//     errorType: e.type.name,
//     message: apiErrorMessage ?? _switchDioError(e) ?? e.response?.data ?? e.message ?? e.toString(),
//   );
// }
//
// dynamic _parseErrorData(dynamic responseData) {
//   if (responseData?.toString().isJsonString == true) {
//     return json.decode(responseData.toString());
//   }
//   return jsonDecode(jsonEncode(responseData));
// }
//
// String? _extractErrorMessage(dynamic errData) {
//   if (errData is Map) {
//     final possibleKeys = ['messages', 'Messages', 'message', 'Message', 'data.error', 'errors', 'detail'];
//     for (final key in possibleKeys) {
//       final value = key.contains('.') ? _nestedLookup(errData, key.split('.')) : errData[key];
//       if (value != null) return value.toString();
//     }
//   } else if (errData is List) {
//     logger.d(errData);
//     return errData.join(',');
//   }
//   return null;
// }
//
// dynamic _nestedLookup(Map map, List<String> keys) {
//   return keys.fold(map, (prev, key) => prev is Map ? prev[key] : null);
// }
//
// String? _switchDioError(DioException ex) {
//   String? msg;
//
//   switch (ex.type) {
//     case DioExceptionType.connectionError:
//       msg = "No internet connection";
//       break;
//     case DioExceptionType.connectionTimeout:
//     case DioExceptionType.sendTimeout:
//     case DioExceptionType.receiveTimeout:
//       msg =
//       'Server is not reachable. Please verify your internet connection and try again (timeout)';
//       break;
//     case DioExceptionType.badCertificate:
//       msg =
//       "App can't work through vpn. please turn off vpn or update the app to the last version!";
//       break;
//     case DioExceptionType.badResponse:
//       msg = 'Server error. Please connect customer service to fix the problem!';
//       break;
//     case DioExceptionType.cancel:
//     case DioExceptionType.unknown:
//       msg = null;
//       break;
//   }
//   return msg;
// }

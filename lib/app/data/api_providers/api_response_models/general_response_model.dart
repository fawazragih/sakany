import 'package:http_parser/http_parser.dart';
import 'package:sakani/app/utils/type_conversion.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';

typedef OnInsideDataSerialize<T> = T Function(Map<String, dynamic>);

class GeneralResponseModel<T, ModelName> {
  GeneralResponseModel({
    this.success = false,
    this.message,
    this.errorList,
    this.data,
    this.hasMore = true,
    this.head,
    // this.status,
    this.code,
  });

  final bool success;
  final String? message;
  final List<String>? errorList;
  final T? data;
  final bool hasMore;

  // final int? status;
  final dynamic head;
  final String? code;

  bool get isSuccess => success;

  static String? getErrorMessage(json) {
    var messageFromJson = json['error']?.toString() ??
        json['errorMsg'] ??
        json['Messages'] ??
        json['messages'];

    return (messageFromJson != null && messageFromJson is List)
        ? messageFromJson.join(',')
        : messageFromJson?.toString();
  }

  factory GeneralResponseModel.fromJson({
    dynamic json,
    OnInsideDataSerialize? serialize,
    bool hasMore = false,
    String? errorMessage,
  }) {
    dynamic jsonData;

    if (json is Map<String, dynamic>) {
      jsonData = CaseInsensitiveMap.from(json);
    } else {
      jsonData = json;
    }

    String? errorMessage = getErrorMessage(jsonData);

    bool successValue = jsonData["status"]?.toString().valueTypeToBool ??
        jsonData["success"]?.toString().valueTypeToBool ??
        jsonData["statusCode"]?.toString().valueTypeToBool ??
        //when there is no general custom json from backend
        errorMessage == null && jsonData is Map;


    // logger.d(errorMessage == null && jsonData is Map);

    var data = (jsonData["data"] ?? jsonData['items']) != null
        ? getData<T, ModelName>(
            data: jsonData["data"] ?? jsonData['items'], serialize: serialize)
        //when there is no general custom json from backend
        : getData<T, ModelName>(data: jsonData, serialize: serialize);

    return GeneralResponseModel<T, ModelName>(
      success: successValue,
      message: errorMessage,
      errorList: (jsonData['errorList'] ?? jsonData['messages'])
          ?.map<String>((e) => e.toString())
          ?.toList(),
      // status: json['status'] is int
      //     ? json['status']
      //     : (int.tryParse(json['status']?.toString() ?? '') ?? 0),
      hasMore: hasMore,
      head: jsonData['head'],
      code: jsonData['code']?.toString(),
      data: data,
    );
  }

  static getData<T, ModelName>(
      {required data, OnInsideDataSerialize? serialize}) {
    // logger.d(data);

    if (serialize == null) {
      return data;
    }

    // logger.d('$ModelName, $T');

    if (data is List && T == List<ModelName>) {
      // _logger.d('1');
      return List<ModelName>.from(
        data.map((item) => serialize(item)),
      );
    }

    if (data is Map && T == List<ModelName>) {
      // data is map so we have only one object;
      if ((data).isNotEmpty) {
        ModelName item = serialize(data as Map<String, dynamic>);
        return <ModelName>[item];
      }
      return <ModelName>[];
    }

    if (data is List && T.runtimeType == ModelName.runtimeType) {
      logger.d('2');
      return null;
    }

    // logger.d('3');
    return serialize(data);
  }

  @override
  String toString() {
    return toMap().toString();
  }

  Map<String, dynamic> toMap() {
    return {
      // 'status': status,
      'success': success,
      'message': message,
      'messages': errorList,
      'data': data,
      'hasMore': hasMore,
    };
  }

// Map<String, dynamic> toJsonInMiniApp(Map<String, dynamic>? dataToJson) {
//   return {
//     // 'status': status,
//     'data': dataToJson,
//     'messages': messages,
//   };
// }
}

/*typedef OnInsideDataSerialize<T> = T Function(Map<String, dynamic>);

class GeneralResponseModel<T, ModelName> {
  final bool success;
  final String? message;
  final List<String>? errorList;
  final T? data;
  final bool hasMore;
  final dynamic head;
  final String? code;

  bool get isSuccess => success;

  GeneralResponseModel({
    this.success = false,
    this.message,
    this.errorList,
    this.data,
    this.hasMore = true,
    this.head,
    this.code,
  });

  static String? getErrorMessage(json) {
    var messageFromJson = json['error']?.toString() ??
        json['errorMsg'] ??
        json['Messages'] ??
        json['messages'];

    return (messageFromJson != null && messageFromJson is List)
        ? messageFromJson.join(',')
        : messageFromJson?.toString();
  }

  factory GeneralResponseModel.fromJson({
    required dynamic json,
    OnInsideDataSerialize? serialize,
    bool hasMore = false,
    String? errorMessage,
  }) {
    final jsonData = _normalizeJsonData(json);
    errorMessage ??= getErrorMessage(jsonData);

    final successValue = _determineSuccessValue(jsonData, errorMessage);
    final data = _extractData<T, ModelName>(jsonData, serialize);

    return GeneralResponseModel<T, ModelName>(
      success: successValue,
      message: errorMessage,
      errorList: _extractErrorList(jsonData),
      hasMore: hasMore,
      head: jsonData['head'],
      code: jsonData['code']?.toString(),
      data: data,
    );
  }

  static dynamic _normalizeJsonData(dynamic json) {
    return json is Map<String, dynamic> ? CaseInsensitiveMap.from(json) : json;
  }

  static bool _determineSuccessValue(dynamic jsonData, String? errorMessage) {
    return jsonData["status"]?.toString().valueTypeToBool ??
        jsonData["success"]?.toString().valueTypeToBool ??
        jsonData["statusCode"]?.toString().valueTypeToBool ??
        (errorMessage == null && jsonData is Map);
  }

  static List<String>? _extractErrorList(dynamic jsonData) {
    final errorListData = jsonData['errorList'] ?? jsonData['messages'];
    return errorListData?.map<String>((e) => e.toString().camelCase)?.toList();
  }

  static T? _extractData<T, ModelName>(
      dynamic jsonData,
      OnInsideDataSerialize? serialize,
      ) {
    final rawData = jsonData["data"] ?? jsonData['items'] ?? jsonData;
    return getData<T, ModelName>(data: rawData, serialize: serialize);
  }

  static T? getData<T, ModelName>({
    required dynamic data,
    OnInsideDataSerialize? serialize,
  }) {
    if (serialize == null) return data;

    if (data is List && T == List<ModelName>) {
      return List<ModelName>.from(data.map((item) => serialize(item))) as T;
    }

    if (data is Map && T == List<ModelName>) {
      if (data.isNotEmpty) {
        final ModelName item = serialize(data as Map<String, dynamic>);
        return <ModelName>[item] as T;
      }
      return <ModelName>[] as T;
    }

    if (data is List && T == ModelName) {
      logger.d('Unexpected case: data is List but T is not List<ModelName>');
      return null;
    }

    return serialize(data) as T;
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'messages': errorList,
    'data': data,
    'hasMore': hasMore,
  };

  @override
  String toString() => toMap().toString();
}*/

import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import 'api_paths.dart';
import 'app_dio_interceptor.dart';
import 'dart:convert';

import 'dart:io';
import 'package:app_extensions/app_extensions.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../../base_controllers_and_listeners/user_auth_controller.dart';

typedef OnDecodedJsonData<T> = T Function(dynamic);

class BaseApi {
  bool enableDioLog = true;

  Dio? _dio;

  Dio get dio {
    if (_dio == null) {
      _dio ??= getNewDioInstance(overrideInvalidCertificate: true);
      _dio?.options = BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        contentType: Headers.jsonContentType,
        headers: {
          Headers.acceptHeader: Headers.jsonContentType,
          Headers.contentTypeHeader: Headers.jsonContentType,
        },
      );
      _dio?.interceptors.clear();
      _dio?.interceptors.add(AppAuthInterceptor(_dio!));
      if (enableDioLog) {
        _dio?.interceptors.add(
          LogInterceptor(
            responseBody: true,
            responseHeader: true,
            requestBody: true,
            requestHeader: true,
            error: true,
            request: true,
            // urlPathToEnableLogAt:'category/SideCategory' ,
            // urlPathToEnableLogAt:ApiPaths.switchChannel(25.toString()) ,
            logPrint: (log) {
              if (enableDioLog) {
                developer.log(log.toString());
              }
              // logger.d(log.toString(), TAG);
            },
          ),
        );
      }
    }

    return _dio!;
  }

  static String _serverCert = '';

  ///this method must be call at main
  static setServerCert() async {
    _serverCert = await rootBundle.loadString("assets/cert/server.cer");
  }

  static Dio getNewDioInstance({
    final bool overrideInvalidCertificate = true,
    // final bool withLog = false,
  }) {
    Dio dio = Dio();

    if (!kIsWeb) {
      HttpClient httpClient;

      if (overrideInvalidCertificate) {
        httpClient = HttpClient(context: null);
        httpClient.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      } else {
        try {
          // String? serverCert = await rootBundle.loadString("assets/cert/server.cer");
          if (_serverCert.isNotNullOrEmpty) {
            List<int> certBytes = utf8.encode(_serverCert);
            SecurityContext sc = SecurityContext();
            sc.setTrustedCertificatesBytes(certBytes);
            httpClient = HttpClient(context: sc);
          } else {
            httpClient = HttpClient(context: null);
          }
        } catch (ex) {
          httpClient = HttpClient(context: null);
        }
      }
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
          () => httpClient;
    }
    return dio;
  }
}

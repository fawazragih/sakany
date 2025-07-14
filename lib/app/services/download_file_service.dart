import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFileService {
  DownloadFileService._();

  static Future<String?> downloadAndSaveFile(String url, String fileName,
      {bool toTempFileDir = true}) async {
    try {
      final Directory directory = toTempFileDir
          ? await getTemporaryDirectory()
          : await getApplicationDocumentsDirectory();

      final String filePath = '${directory.path}/$fileName';
      final Response response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          // followRedirects: false,
          // validateStatus: (status) {
          //   return status! < 500;
          // }
        ),
      );
      final File file = File(filePath);
      await file.writeAsBytes(response.data);
      return filePath;
    } catch (e) {
      if (kDebugMode) {
        print('===================downloadAndSaveFile==============');
        print(e.toString());
        print('===================downloadAndSaveFile==============');
      }
      return null;
    }
  }
}

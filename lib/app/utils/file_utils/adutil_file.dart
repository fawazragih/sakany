import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/file_download_response.dart';
import 'package:tamoily/app/services/notification_service/local_notification_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';

class AdUtilFiles {
  static Future<String?> checkAndCreateDirInApplicationDocDir(
      String folderNameToCheckAndCreate) async {
    return await getApplicationDocumentsDirectory().then((value) async {
      String localAppDirectoryPath =
          "${value.path}/$folderNameToCheckAndCreate";
      final dir = Directory(localAppDirectoryPath);
      if (!(await dir.exists())) {
        // logger.d('not available');
        await dir.create();
      }
      return await dir.exists() ? localAppDirectoryPath : null;
    });
  }

  ///... this method ether return object of T or [Exception]
  static readDocsToJsonFile<T>(String filePath) async {
    logger.d(filePath);
    final payoutDocsFile = File(filePath);
    try {
      if (await payoutDocsFile.exists()) {
        var value = payoutDocsFile.readAsStringSync();
        // logger.d(value);
        var decoded = json.decode(value);
        if (decoded != null && decoded is T) {
          return decoded;
        }
      }
    } catch (e) {
      return e;
    }
  }

  ///... this method ether return bool of true or [Exception]
  static writeDocsToJsonFile(
      List<Map<String, dynamic>> data, String filePath) async {
    // logger.d(data);
    final payoutDocsFile = File(filePath);
    try {
      if (!await payoutDocsFile.exists()) {
        await payoutDocsFile.create();
      }
      await payoutDocsFile.writeAsString(json.encode(data));
      return true;
    } catch (e) {
      return e;
    }
  }

  ///... compressFile
  // static Future<Uint8List?> compressFile(File file) async {
  //   Uint8List? result;
  //
  //   String filePath = file.path;
  //   final String extension = path.extension(filePath).toLowerCase();
  //
  //   late CompressFormat compressFormat;
  //   if (extension == '.jpg' || extension == '.jpeg') {
  //     compressFormat = CompressFormat.jpeg;
  //   } else if (extension == '.png') {
  //     compressFormat = CompressFormat.png;
  //   }
  //
  //   int quality = 30;
  //
  //   try {
  //     result = await FlutterImageCompress.compressWithFile(
  //       filePath,
  //       format: compressFormat,
  //       quality: quality,
  //     );
  //
  //     var oldFileSize = getFileSizeString(file.readAsBytesSync().lengthInBytes);
  //     var newFileSize = getFileSizeString(result!.lengthInBytes);
  //
  //     // logger.d('old file size bytes => $oldFileSize bytes \nnew file in bytes => $newFileSize bytes');
  //
  //     // if (newFileSize < oldFileSize) {
  //     //   logger.d('success 1');
  //     // }
  //     // if ((newFileSize / 1024) < oldFileSize / 1024) {
  //     //   logger.d('success 2');
  //     // }
  //
  //     logger.d(
  //         'old file length => $oldFileSize \nnew file length => $newFileSize');
  //     return result;
  //   } catch (e) {
  //     logger.e(e.toString());
  //     return null;
  //   }
  // }

  ///... End of compressFile
  static String getFileSizeString(int bytes, {int decimals = 2}) {
    const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024.0)).floor();
    return ((bytes / pow(1024.0, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  static Future<File?> saveFileToDisk(FileResponse response,
      {bool showNotification = false}) async {
    String path = '';

    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      // User canceled the picker
      path = selectedDirectory!;
    } else {
      return null;
    }

    /*if (!kIsWeb && Platform.isAndroid) {
    path = "/storage/emulated/0/Download";
  } else if (!kIsWeb && Platform.isIOS) {
    path = (await getApplicationDocumentsDirectory()).path;
  } else {
    throw Exception('Platform not supported yet');
  }*/

    if (!await Directory(path).exists()) await Directory(path).create();

    // If file already exists with the same name append number
    var nameWithExt = (response.filename as String).split('.');
    File file = File('$path/${response.filename}');

    var count = 0;
    while (await file.exists() == true) {
      count++;
      file = File('$path/${nameWithExt[0]}-($count).${nameWithExt[1]}');
    }
    if (response.fileBytes != null) {
      file = await file.writeAsBytes(response.fileBytes!);

      if (showNotification) {
        LocalNotificationService.instance.showFileDownloadNotification(path: file.path);
      }

      return file;
    } else {
      throw Exception('File bytes value is null');
    }
  }
}

extension PlatformExtension on GetPlatform {
  String get lineSeparator => GetPlatform.isWindows
      ? '\r\n'
      : GetPlatform.isMacOS
          ? '\r'
          : GetPlatform.isLinux
              ? '\n'
              : '\n';
}

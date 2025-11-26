import 'dart:io';
import 'dart:typed_data';

import 'package:tamoily/app/utils/file_utils/adutil_file.dart';

import 'sample_download_response.dart';

class FileDownloadResponse<T> {
  final T? jsonResponse;
  final File? file;

  FileDownloadResponse({this.jsonResponse, this.file});
}

class FileResponse {
  final Uint8List? fileBytes;
  final jsonStr;
  final filename;
  bool isFile = false;

  FileResponse({
    this.fileBytes,
    this.jsonStr,
    this.filename,
  }) {
    isFile = fileBytes != null;
  }

  Future<FileDownloadResponse<SampleDownloadResponse>> get responseData async {
    FileDownloadResponse<SampleDownloadResponse> data;

    if (isFile) {
      data = FileDownloadResponse<SampleDownloadResponse>(
        file: await AdUtilFiles.saveFileToDisk(this, showNotification: true),
      );
    } else {
      data = FileDownloadResponse<SampleDownloadResponse>(
        jsonResponse: SampleDownloadResponse.fromJson(jsonStr),
      );
    }

    return data;
  }
}

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani/app/data/models/bas_settings_response.dart';
import 'package:sakani/app/data/models/file_download_response.dart';
import 'package:sakani/app/data/models/file_upload_response.dart';
import 'package:sakani/app/data/models/get_states_response.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/handling_dio_response.dart';

mixin SharedApi on BaseApi {
  Future<SuccessOrError> getStatesByCountry(int countryId) async {
    return await dio
        .get(
          '${ApiEndpoints.getStatesByCountry}/$countryId',
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<List<AvailableStates>,
              AvailableStates>.fromJson(
            json: data,
            serialize: AvailableStates.fromJson,
          ),
        );
  }

  Future<SuccessOrError> getBasSettings() async {
    return await dio.get(ApiEndpoints.basClientSetting).mapFromResponse(
          (data) =>
              GeneralResponseModel<BasSettingsData, BasSettingsData>.fromJson(
            json: data,
            serialize: BasSettingsData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> uploadMultipartFile({
    required String filePath,
    required String url,
  }) async {
    final mimeType = lookupMimeType(filePath);
    final mimeSplitted = mimeType?.split('/') ?? [];
    final mimePart1 = mimeSplitted.isNotEmpty ? mimeSplitted[0] : 'application';
    final mimePart2 = mimeSplitted.length > 1 ? mimeSplitted[1] : 'unknown';

    return await dio
        .post(url,
            data: FormData.fromMap(
              {
                'file': await MultipartFile.fromFile(
                  filePath,
                  filename: filePath.split('/').last ?? 'uploadedFile',
                  contentType: MediaType(
                    mimePart1,
                    mimePart2,
                  ),
                )
              },
            ))
        .mapFromResponse(
      (data) {
        data['success'] = true;
        return GeneralResponseModel<FileUploadData, FileUploadData>.fromJson(
          json: data,
          serialize: FileUploadData.fromJson,
        );
      },
    );
  }

  GeneralResponseModel<FileResponse, FileResponse> fileDownloadCustomHandle(
      Map<String, dynamic> data, response) {
    FileResponse responseJson;

    String? contentType = response.headers.map['content-type']?.firstOrNull;
    // var contentType = response.headers. ?? '';

    if (contentType?.contains('application/json') == true) {
      responseJson = FileResponse(jsonStr: response.data);
    } else {
      List<String> tokens = response.headers.map['content-disposition'] ?? [];
      String filename = 'new_file.${contentType?.split('/').last}';
      for (var i = 0; i < tokens.length; i++) {
        if (tokens[i].contains('filename') &&
            !tokens[i].contains('filename*')) {
          filename =
              tokens[i].substring(tokens[i].indexOf("=") + 1, tokens[i].length);
          break;
        }
      }
      responseJson = FileResponse(fileBytes: response.data, filename: filename);
    }

    return GeneralResponseModel<FileResponse, FileResponse>.fromJson(
      json: data,
      serialize: (_) => responseJson,
    );
  }

// Future<SuccessOrError> downloadSample({required int productId}) async {
//   return await dio
//       .get('${ApiEndpoints.sampleDownload}/$productId')
//       .mapFromResponse(
//         (data) => GeneralResponseModel(),
//       );
// }
}

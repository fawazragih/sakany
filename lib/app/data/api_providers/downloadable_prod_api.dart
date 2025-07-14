import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/api_providers/share_api.dart';
import 'package:sakani/app/data/models/downloadable_product_response.dart';
import 'package:sakani/app/data/models/user_agreement_response.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class DownloadableProdApi extends BaseApi with SharedApi{
  Future<SuccessOrError> fetchDownloadableProducts() async {
    return await dio.get(ApiEndpoints.downloadableProducts).mapFromResponse(
          (data) => GeneralResponseModel<DownloadableProductData,
              DownloadableProductData>.fromJson(
            json: data,
            serialize: DownloadableProductData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchUserAgreementText(String guid) async {
    // final response = await _helper.get('${Endpoints.userAgreement}/$guid');
    // return UserAgreementResponse.fromJson(response);
    return await dio.get('${ApiEndpoints.userAgreement}/$guid').mapFromResponse(
          (data) => GeneralResponseModel<UserAgreementData,
              UserAgreementData>.fromJson(
            json: data,
            serialize: UserAgreementData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> downloadFile(String guid, String consent) async {
    // final FileResponse response = await _helper.getFile('${Endpoints.getDownload}/$guid/$consent');
    //
    // if (response.isFile) {
    //   return FileDownloadResponse<SampleDownloadResponse>(
    //     file: await saveFileToDisk(response, showNotification: true),
    //   );
    // } else {
    //   return FileDownloadResponse<SampleDownloadResponse>(
    //     jsonResponse: SampleDownloadResponse.fromJson(response.jsonStr),
    //   );
    // }

    return await dio
        .get('${ApiEndpoints.getDownload}/$guid/$consent')
        .mapFromResponse(
          (data) => GeneralResponseModel(),
      customHandle: fileDownloadCustomHandle,
    );
  }
}

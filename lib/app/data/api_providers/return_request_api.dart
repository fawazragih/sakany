import 'package:sakani/app/data/api_providers/base_configs/api_paths.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/api_providers/share_api.dart';
import 'package:sakani/app/data/models/requestbody/return_request_body.dart';
import 'package:sakani/app/data/models/return_request_history_response.dart';
import 'package:sakani/app/data/models/return_request_response.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/base_api.dart';

class ReturnRequestApi extends BaseApi with SharedApi {
  Future<SuccessOrError> fetchReturnRequestForm(int orderId) async {
    return await dio
        .get('${ApiEndpoints.returnRequest}/$orderId')
        .mapFromResponse(
          (data) => GeneralResponseModel<ReturnRequestData,
              ReturnRequestData>.fromJson(
            json: data,
            serialize: ReturnRequestData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> postReturnRequestForm(
      int orderId, ReturnRequestBody reqBody) async {
    return await dio
        .post(
          '${ApiEndpoints.returnRequest}/$orderId',
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<ReturnRequestData,
              ReturnRequestData>.fromJson(
            json: data,
            serialize: ReturnRequestData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> uploadFile(String filePath) async {
    return super.uploadMultipartFile(
        filePath: filePath, url: ApiEndpoints.uploadFileReturnRequest);
  }

  Future<SuccessOrError> fetchReturnRequestHistory() async {
    return await dio.get(ApiEndpoints.returnRequestHistory).mapFromResponse(
          (data) => GeneralResponseModel<ReturnReqHistoryData,
              ReturnReqHistoryData>.fromJson(
            json: data,
            serialize: ReturnReqHistoryData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> downloadFile(String guid) async {
    return await dio
        .get('${ApiEndpoints.returnRequestFileDownload}/$guid')
        .mapFromResponse(
          (data) => GeneralResponseModel(),
          customHandle: fileDownloadCustomHandle,
        );
  }
}

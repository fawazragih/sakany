import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/api_providers/return_request_api.dart';

import '../../../data/models/requestbody/return_request_body.dart';

class ReturnRequestRepository {
  final ReturnRequestApi _api = ReturnRequestApi();

  Future<SuccessOrError> fetchReturnRequestForm(int orderId) =>
      _api.fetchReturnRequestForm(orderId);

  Future<SuccessOrError> postReturnRequestForm(
          int orderId, ReturnRequestBody reqBody) =>
      _api.postReturnRequestForm(orderId, reqBody);

  Future<SuccessOrError> uploadFile(String filePath) =>
      _api.uploadFile(filePath);

  Future<SuccessOrError> fetchReturnRequestHistory() =>
      _api.fetchReturnRequestHistory();

  Future<SuccessOrError> downloadFile(String guid) => _api.downloadFile(guid);
}

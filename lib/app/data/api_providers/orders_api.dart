import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/api_providers/share_api.dart';
import '../models/order_details_response.dart';
import '../models/order_history_response.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class OrdersApi extends BaseApi with SharedApi {
  Future<SuccessOrError> fetchOrderHistory() async {
    OrderHistoryResponse;
    return await dio.get(ApiEndpoints.orderHistory).mapFromResponse(
          (data) =>
              GeneralResponseModel<OrderHistoryData, OrderHistoryData>.fromJson(
            json: data,
            serialize: OrderHistoryData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchOrderDetails(int orderId) async {
    return await dio
        .get('${ApiEndpoints.orderDetails}/$orderId')
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<OrderDetailsData, OrderDetailsData>.fromJson(
            json: data,
            serialize: OrderDetailsData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> reorder(int orderId) async {
    // final response = await _helper.get('${Endpoints.reorder}/$orderId');
    // return response.toString();
    return await dio.get('${ApiEndpoints.reorder}/$orderId').mapFromResponse(
          (data) => GeneralResponseModel.fromJson(
            json: data,
          ),
        );
  }

  Future<SuccessOrError> repostPayment(num orderId) async {
    // final response = await _helper.post('${Endpoints.orderRepostPayment}/$orderId', AppConstants.EMPTY_POST_BODY);
    // return response.toString();
    return await dio.post(
      '${ApiEndpoints.orderRepostPayment}/$orderId',
      data: {},
    ).mapFromResponse(
      (data) => GeneralResponseModel.fromJson(
        json: data,
      ),
    );
  }

  Future<SuccessOrError> downloadPdfInvoice(int orderId) async {
    // final FileResponse response =
    //     await _helper.getFile('${Endpoints.orderPdfInvoice}/$orderId');
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
        .get('${ApiEndpoints.orderPdfInvoice}/$orderId')
        .mapFromResponse(
          (data) => GeneralResponseModel(),
          customHandle: fileDownloadCustomHandle,
        );
  }

  Future<SuccessOrError> downloadNotesAttachment(int noteId) async {
    // final FileResponse response = await _helper.getFile('${Endpoints.orderNote}/$noteId');
    // if (response.isFile) {
    //   return FileDownloadResponse<SampleDownloadResponse>(
    //     file: await saveFileToDisk(response, showNotification: true),
    //   );
    // } else {
    //   return FileDownloadResponse<SampleDownloadResponse>(
    //     jsonResponse: SampleDownloadResponse.fromJson(response.jsonStr),
    //   );
    // }
    return await dio.get('${ApiEndpoints.orderNote}/$noteId').mapFromResponse(
          (data) => GeneralResponseModel(),
          customHandle: fileDownloadCustomHandle,
        );
  }
}

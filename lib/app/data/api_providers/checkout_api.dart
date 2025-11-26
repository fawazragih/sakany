import 'package:tamoily/app/data/api_providers/base_configs/api_paths.dart';
import 'package:tamoily/app/data/api_providers/base_configs/base_api.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/api_providers/share_api.dart';
import 'package:tamoily/app/data/models/bas_checkout_payment_info.dart';
import 'package:tamoily/app/data/models/get_billing_address_response.dart';
import 'package:tamoily/app/data/models/requestbody/form_values_request_body.dart';
import 'package:tamoily/app/data/models/requestbody/save_billing_req_body.dart';
import 'package:tamoily/app/data/models/requestbody/save_payment_req_body.dart';
import 'package:tamoily/app/data/models/requestbody/save_shipping_req_body.dart';
import 'package:tamoily/app/data/models/save_billing_response.dart';

import 'api_response_models/general_response_model.dart';

class CheckoutApi extends BaseApi with SharedApi {
  // final ApiBaseHelper _helper = ApiBaseHelper();

  Future<SuccessOrError> fetchBillingAddress() async {
    // final response = await _helper.get(ApiEndpoints.getBilling);
    // return GetBillingAddressResponse.fromJson(response);

    return await dio
        .get(
          ApiEndpoints.getBilling,
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<GetBillingData, GetBillingData>.fromJson(
            json: data,
            serialize: GetBillingData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> saveBillingAddress(SaveBillingReqBody reqBody) async {
    // final response = await _helper.post(ApiEndpoints.saveBilling, reqBody);
    // return CheckoutPostResponse.fromJson(response);

    return await dio
        .post(
          ApiEndpoints.saveBilling,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<CheckoutPostResponseData,
              CheckoutPostResponseData>.fromJson(
            json: data,
            serialize: CheckoutPostResponseData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> saveShippingAddress(
      SaveShippingReqBody reqBody) async {
    // final response = await _helper.post(ApiEndpoints.saveShippingAddress, reqBody);
    // return CheckoutPostResponse.fromJson(response);

    return await dio
        .post(
          ApiEndpoints.saveShippingAddress,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<CheckoutPostResponseData,
              CheckoutPostResponseData>.fromJson(
            json: data,
            serialize: CheckoutPostResponseData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> saveShippingMethod(
    FormValuesRequestBody reqBody,
  ) async {
    // final response = await _helper.post(ApiEndpoints.saveShippingMethod, reqBody);
    // return CheckoutPostResponse.fromJson(response);
    return await dio
        .post(
          ApiEndpoints.saveShippingMethod,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<CheckoutPostResponseData,
              CheckoutPostResponseData>.fromJson(
            json: data,
            serialize: CheckoutPostResponseData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> savePaymentMethod(SavePaymentReqBody reqBody) async {
    // final response =
    //     await _helper.post(ApiEndpoints.savePaymentMethod, reqBody);
    // return CheckoutPostResponse.fromJson(response);

    return await dio
        .post(ApiEndpoints.savePaymentMethod, data: reqBody.toJson(),).mapFromResponse((data) =>
    GeneralResponseModel<CheckoutPostResponseData,
              CheckoutPostResponseData>.fromJson(
            json: data,
            serialize: CheckoutPostResponseData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> callBasPaymentInfo(String basAuthId) async {
    // final response =
    //     await _helper.postWithFormData(ApiEndpoints.basCheckoutInfo, {
    //   'CustomerBASAuthCode': basAuthId,
    // });
    // return BasCheckoutPaymentInfo.fromJson(response);

    return await dio.post(ApiEndpoints.basCheckoutInfo, data: {
      'CustomerBASAuthCode': basAuthId,
    }).mapFromResponse(
      (data) => GeneralResponseModel<BasCheckoutPaymentInfoData,
          BasCheckoutPaymentInfoData>.fromJson(
        json: data,
        serialize: BasCheckoutPaymentInfoData.fromJson,
      ),
    );
  }

  Future<SuccessOrError> getConfirmOrder() async {
    // final response = await _helper.get(ApiEndpoints.confirmOrder);
    // return OrderSummaryResponse.fromJson(response);

    return await dio.get(ApiEndpoints.confirmOrder).mapFromResponse(
          (data) => GeneralResponseModel<ConfirmModel, ConfirmModel>.fromJson(
            json: data,
            serialize: ConfirmModel.fromJson,
          ),
        );
  }

  Future<SuccessOrError> confirmOrder() async {
    // final response = await _helper.post(ApiEndpoints.confirmOrder, '');
    // return CheckoutPostResponse.fromJson(response);
    return await dio
        .post(
          ApiEndpoints.confirmOrder,
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<CheckoutPostResponseData,
              CheckoutPostResponseData>.fromJson(
            json: data,
            serialize: CheckoutPostResponseData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> orderComplete() async {
    // final response = await _helper.get(ApiEndpoints.orderComplete);
    // return CheckoutPostResponse.fromJson(response);

    return await dio.get(ApiEndpoints.orderComplete).mapFromResponse(
          (data) => GeneralResponseModel<CheckoutPostResponseData,
              CheckoutPostResponseData>.fromJson(
            json: data,
            serialize: CheckoutPostResponseData.fromJson,
          ),
        );
  }
}

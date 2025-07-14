import 'package:sakani_mobile_app/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani_mobile_app/app/data/api_providers/share_api.dart';
import 'package:sakani_mobile_app/app/data/models/estimate_shipping_response.dart';
import 'package:sakani_mobile_app/app/data/models/requestbody/estimate_shipping_req_body.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/handling_dio_response.dart';

class EstimateShippingApi extends BaseApi with SharedApi {

  Future<SuccessOrError> estimateShipping(
      EstimateShippingReqBody reqBody) async {
    return await dio
        .post(
          ApiEndpoints.cartEstimateShipping,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<EstimateShippingData,
              EstimateShippingData>.fromJson(
            json: data,
            serialize: EstimateShippingData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> productEstimateShipping(
      EstimateShippingReqBody reqBody) async {
    return await dio
        .post(
          ApiEndpoints.productEstimateShipping,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<EstimateShippingData,
              EstimateShippingData>.fromJson(
            json: data,
            serialize: EstimateShippingData.fromJson,
          ),
        );
  }
}

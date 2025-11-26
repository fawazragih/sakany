import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/api_providers/estimate_shipping_api.dart';
import 'package:tamoily/app/data/models/requestbody/estimate_shipping_req_body.dart';

class EstimateShippingRepository {
  final EstimateShippingApi _api = EstimateShippingApi();

  Future<SuccessOrError> getStatesByCountry(int countryId) =>
      _api.getStatesByCountry(countryId);

  Future<SuccessOrError> estimateShipping(EstimateShippingReqBody reqBody)=>_api.estimateShipping(reqBody);
  Future<SuccessOrError> productEstimateShipping(EstimateShippingReqBody reqBody)=>_api.productEstimateShipping(reqBody);


}

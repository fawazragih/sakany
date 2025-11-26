import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';

import '../models/requestbody/form_values_request_body.dart';
import '../models/subscription_list_response.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class SubscriptionApi extends BaseApi {
  Future<SuccessOrError> fetchSubscriptions(int pageNumber) async {
    // final response = await _helper.get('${Endpoints.customerSubscriptions}/$pageNumber');
    // return SubscriptionListData.fromJson(response);
    return await dio
        .get('${ApiEndpoints.customerSubscriptions}/$pageNumber')
        .mapFromResponse(
          (data) => GeneralResponseModel<SubscriptionListData,
              SubscriptionListData>.fromJson(
            json: data,
            serialize: SubscriptionListData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> unsubscribe(FormValuesRequestBody reqBody) async {
    // final response = await _helper.post(Endpoints.customerSubscriptions, reqBody);
    // return SubscriptionListResponse.fromJson(response);

    return await dio
        .post(
          ApiEndpoints.customerSubscriptions,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<SubscriptionListData,
              SubscriptionListData>.fromJson(
            json: data,
            serialize: SubscriptionListData.fromJson,
          ),
        );
  }
}

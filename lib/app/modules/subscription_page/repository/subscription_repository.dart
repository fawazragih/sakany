import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/api_providers/subscription_api.dart';

import '../../../data/models/requestbody/form_values_request_body.dart';

class SubscriptionRepository {
  final SubscriptionApi _api = SubscriptionApi();

  Future<SuccessOrError> fetchSubscriptions(int pageNumber) =>
      _api.fetchSubscriptions(pageNumber);

  Future<SuccessOrError> unsubscribe(FormValuesRequestBody reqBody) =>
      _api.unsubscribe(reqBody);
}

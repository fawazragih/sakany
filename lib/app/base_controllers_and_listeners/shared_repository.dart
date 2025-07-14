
import 'package:sakani/app/data/models/bas_settings_response.dart' show BasSettingsData;

import '../data/api_providers/api_response_models/general_response_model.dart';
import '../data/api_providers/base_configs/handling_dio_response.dart';
import '../data/api_providers/checkout_api.dart';

class SharedRepository {
  final CheckoutApi checkoutApi = CheckoutApi();
  static BasSettingsData? basSettingsResponse;

  Future<SuccessOrError> getBasSettings() async {
    if (basSettingsResponse == null) {
      return await checkoutApi.getBasSettings();
    } else {
      return (
      GeneralResponseModel(
        success: true,
        message: "Bas Settings already fetched",
        data: basSettingsResponse,
      ),
      null
      );
    }
  }


  Future<SuccessOrError> getStatesByCountry(int countryId) =>
      checkoutApi.getStatesByCountry(countryId);
}
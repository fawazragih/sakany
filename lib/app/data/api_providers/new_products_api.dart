import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/product_summary.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class NewProductsApi extends BaseApi {
  Future<SuccessOrError> fetchNewProducts() async {
    return await dio.get(ApiEndpoints.newProducts).mapFromResponse(
          (data) => GeneralResponseModel<List<ProductSummary>,
              ProductSummary>.fromJson(
            json: data,
            serialize: ProductSummary.fromJson,
          ),
        );
  }
}

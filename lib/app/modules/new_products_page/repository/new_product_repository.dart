import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/api_providers/new_products_api.dart';

class NewProductRepository {
  final NewProductsApi _api = NewProductsApi();

  Future<SuccessOrError> fetchNewProducts() => _api.fetchNewProducts();
}

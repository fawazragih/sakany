import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';

import '../../../data/api_providers/search_api.dart';

class SearchRepository {
  final SearchApi _api = SearchApi();

  Future<SuccessOrError> searchProduct(Map<String, dynamic> queryParams) =>
      _api.searchProduct(queryParams);

  Future<SuccessOrError> fetchSuggestions(String query) =>
      _api.fetchSuggestions(query);
}

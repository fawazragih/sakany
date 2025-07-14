import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/search_response.dart';
import 'package:sakani/app/data/models/search_suggestion_response.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';

class SearchApi extends BaseApi {
  Future<SuccessOrError> searchProduct(
    Map<String, dynamic> queryParams,
  ) async {
    return await dio
        .get(
          ApiEndpoints.search,
          queryParameters: queryParams,
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<SearchData, SearchData>.fromJson(
            json: data,
            serialize: SearchData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchSuggestions(String query) async {
    return await dio.get(ApiEndpoints.searchAutocomplete,
        queryParameters: {'term': query}).mapFromResponse(
      (data) => GeneralResponseModel<List<SearchSuggestionData>,
          SearchSuggestionData>.fromJson(
        json: data,
        serialize: SearchSuggestionData.fromJson,
      ),
    );
  }
}

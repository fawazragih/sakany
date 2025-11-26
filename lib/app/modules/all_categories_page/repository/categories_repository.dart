import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/api_providers/categories_api.dart';
import 'package:tamoily/app/data/models/filter_model.dart';

class CategoriesAndChannelRepository {
  final CategoriesAndChannelApi _api = CategoriesAndChannelApi();

  Future<SuccessOrError> getMore({
    required int page,
    ApiFilter? apiFilter,
    int onPage = 10,
  }) {
    return _api.getMore(
      page: page,
      onPage: onPage,
      // apiFilter: apiFilter,
    );
  }

  Future<SuccessOrError> getMoreParentCat({
    required int page,
    ApiFilter? apiFilter,
    int onPage = 10,
  }) {
    return _api.getParentCategories(
      page: page,
      onPage: onPage,
      // apiFilter: apiFilter,
    );
  }

  Future<SuccessOrError> getMoreSubCat({
    required int page,
    required String parentCatId,
    ApiFilter? apiFilter,
    int onPage = 10,
  }) {
    return _api.getSubCategories(
      page: page,
      parentCatId: parentCatId,
      onPage: onPage,
      // apiFilter: apiFilter,
    );
  }

// getProductDetails({
//   required String productId,
//   required String? catId,
//   String? goodsUrlName,
// }) {
//   return _api.getProductDetails(
//     productId: productId,
//     catId: catId,
//     goodsUrlName: goodsUrlName,
//   );
// }
}

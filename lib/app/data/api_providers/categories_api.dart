import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/pagination_logic.dart';


class CategoriesAndChannelApi extends BaseApi {
  PaginationLogic? _paginationLogic;

  PaginationLogic get paginationLogic =>
      _paginationLogic ??= PaginationLogic(dio);

  /*Future<SuccessOrError>*/ getMore({
    required int page,
    int? onPage,
  }) async {
    // return await paginationLogic.loadMore<AppChannel>(
    //   ApiPaths.channels,
    //   page,
    //   requiredOnPage: onPage ?? 10,
    //   // moreParameter: {
    //   //   // 'search': search,
    //   //   // 'brandId': brandId,
    //   //   // 'categoryId': catId,
    //   // }..removeWhere((key, value) => value == null),
    //   onInsideDataSerialize: (data) => AppChannel.fromJson(data),
    // );
  }

 /* Future<SuccessOrError>*/ getParentCategories({
    required int page,
    int? onPage,
  }) async {
    /*return await paginationLogic.loadMore<AppCategory>(
      ApiEndpoints.prentCategories,
      page,
      requiredOnPage: onPage ?? 10,
      // moreParameter: {
      //   // 'search': search,
      //   // 'brandId': brandId,
      //   // 'categoryId': catId,
      // }..removeWhere((key, value) => value == null),
      onInsideDataSerialize: (data) => AppCategory.fromJson(data),
    );*/
  }

  /*Future<SuccessOrError>*/ getSubCategories({
    required int page,
    required String parentCatId,
    int? onPage,
  }) async {
    /*return await paginationLogic.loadMore<AppCategory>(
      ApiEndpoints.childCategories,
      page,
      requiredOnPage: onPage ?? 10,
      moreParameter: {
        'parent_id': parentCatId,
      },
      onInsideDataSerialize: (data) => AppCategory.fromJson(data),
    );*/
  }
}

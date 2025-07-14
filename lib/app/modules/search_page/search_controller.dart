import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/data/api_providers/api_response_models/general_response_model.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/models/catalog_products_model.dart';
import 'package:sakani_mobile_app/app/data/models/filter_model.dart';
import 'package:sakani_mobile_app/app/data/models/search_response.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import '../../base_controllers_and_listeners/pagination_logic_controller.dart';
import '../../data/models/product_summary.dart';
import '../product_list_page/widgets/filters_widgets/filters_builder_widget.dart';
import '../product_list_page/widgets/sort_options_builder_widget.dart';
import 'repository/search_repository.dart';

class SearchPageController extends BaseController
    with PaginationLogicController<ProductSummary> {
  final String avdSearchButtonId = 'avdSearchButtonId';
  final String filterOptionId = 'filterOptionId';
  final String paginationListBuilderId = 'paginationListBuilderId';
  final SearchRepository _repository = SearchRepository();

  ApiFilter apiFilter = ApiFilter();

  SearchData? searchResponse;
  CatalogProductsModel? catalogProductsModel;

  @override
  void onInit() {
    super.onInit();
    initPagingController();
  }

  @override
  Future<SuccessOrError> getData(int page) async {
    Map<String, dynamic> queryParams = {
      'PageNumber': page.toString(),
      'PageSize': 12,
    };

    queryParams.addAll(apiFilter.toJson());

    if (searchResponse?.advSearchSelected == true) {
      queryParams['advs'] = searchResponse?.advSearchSelected.toString();
      queryParams['sid'] = searchResponse?.searchInDescription.toString();
      queryParams['isc'] = searchResponse?.searchInSubcategory.toString();
      queryParams['cid'] = searchResponse?.categoryId.toString();
      queryParams['mid'] = searchResponse?.manufacturerId.toString();
      queryParams['vid'] = searchResponse?.vendorId.toString();
    }

    logger.d('queryParams=>$queryParams');

    SuccessOrError result = await _repository.searchProduct(queryParams);

    if (result.success) {
      SearchData response = result.response?.data;

      //update filterOptionId GetBuilder only if there is a changes;
      if (catalogProductsModel == null &&
          (hasSortOption != response.catalogProductsModel?.hasSortOption ||
              hasFilterOption !=
                  response.catalogProductsModel?.hasFilterOption)) {
        catalogProductsModel = response.catalogProductsModel;
        update([filterOptionId]);
      }
      searchResponse = response;
      return (
        GeneralResponseModel(
          data: searchResponse?.catalogProductsModel?.products,
          hasMore: searchResponse?.catalogProductsModel?.hasNextPage == true,
          success: true,
        ),
        null
      );
    } else {
      return (null, result.error);
    }
  }

  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 1000));

  onSearchChange(String value) {
    _debouncer.call(() {
      if (value.trim().isEmpty || value.length < 3) {
        apiFilter.search = null;
        pagingController.itemList?.clear();
        update([paginationListBuilderId]);
        return;
      } else if (value != apiFilter.search) {
        apiFilter.search = value;
      }
      hideSoftKeyBoard();
      pagingController.refresh();
    });
  }

  // Future<List<SearchSuggestionData>> fetchSuggestions(String query) async {
  //   searchQuery = query;
  //   pagingController.refresh();
  //
  //   SuccessOrError result = await _repository.fetchSuggestions(query);
  //   if (result.success) {
  //     List<SearchSuggestionData> suggestions = result.response?.data;
  //     return suggestions;
  //   } else {
  //     buildErrorSnackBar(msg: result.error.toString());
  //     return [];
  //   }
  // }

  bool get hasFilterOption {
    bool v = catalogProductsModel?.hasFilterOption == true;
    // logger.d('hasFilterOption=>$v');
    return v;
  }

  bool get hasSortOption {
    bool v = catalogProductsModel?.hasSortOption == true;
    // logger.d('hasSortOption=>$v');
    return v;
  }

  openFilterOptions() {
    if (catalogProductsModel != null) {
      Get.bottomSheet(
        FiltersBuilderWidget(
          catalogProductsModel: catalogProductsModel!,
          filter: apiFilter,
          onAppLyFilter: () {
            logger.d(apiFilter.toJson());
            pagingController.refresh();
            if (Get.isBottomSheetOpen == true) {
              Get.back();
            }
          },
          onClearFilter: () {
            String? oldSearchQuery = apiFilter.search;
            apiFilter = ApiFilter(search: oldSearchQuery);
            pagingController.refresh();
            if (Get.isBottomSheetOpen == true) {
              Get.back();
            }
          },
        ),
        isScrollControlled: true,
      );
    }
  }

  openSortOptions() {
    Get.bottomSheet(
      SortOptionsBuilderWidget(
        options: catalogProductsModel?.availableSortOptions ?? [],
        onSortBy: (e) {
          // logger.d(e.toJson());
          if (Get.isBottomSheetOpen == true) {
            Get.back();
          }
          if (e.value != null) {
            apiFilter.orderBy = e.value!;
            pagingController.refresh();
          }
        },
      ),
      isScrollControlled: true,
    );
  }

  @override
  disposePaginationController() {
    pagingController.dispose();
  }

  @override
  void onClose() {
    disposePaginationController();
    super.onClose();
  }
}

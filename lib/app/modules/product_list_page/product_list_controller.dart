import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/base_controllers_and_listeners/pagination_logic_controller.dart';
import 'package:tamoily/app/data/api_providers/api_response_models/general_response_model.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/modules/products_details_screen/repository/all_products_repository.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import '../../data/models/filter_model.dart';
import '../../data/models/product_list/product_list_response.dart';
import '../../data/models/product_summary.dart';
import 'argument/product_list_argument.dart';
import 'product_list_view.dart';
import 'widgets/filters_widgets/filters_builder_widget.dart';
import 'widgets/sort_options_builder_widget.dart';

class ProductListController extends BaseController
    with PaginationLogicController<ProductSummary> {
  final AllProductsRepository _repository = AllProductsRepository();
  ProductListScreenArguments? arguments;

  int? categoryId;

  ApiFilter apiFilter = ApiFilter();

  bool hasAlreadyInit = false;

  @override
  void onInit() {
    super.onInit();

    arguments = ProductListScreenArguments.fromJson(Get.parameters);
    categoryId =
        int.tryParse(Get.parameters['cat_id'] ?? '') ?? arguments?.id ?? -1;

    if (categoryId == -1) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.back();
        buildErrorSnackBar(msg: 'product_id mus be passed');
      });
      return;
    }
    initPagingController();
  }

  RxBool doneLoading = RxBool(false);

  ProductListData? productListData;

  @override
  Future<SuccessOrError> getData(int page) async {
    Map<String, dynamic> queryParams = {
      'PageNumber': page.toString(),
      'PageSize': 4,
    };

    queryParams.addAll(apiFilter.toJson());

    SuccessOrError result = await _repository.getMore(
      categoryId: categoryId!,
      type: arguments?.type ?? GetProductListBy.CATEGORY,
      queryParams: queryParams,
    );

    if (result.success) {
      ProductListData responseData = result.response?.data;
      List<ProductSummary> productsList = responseData.catalogProductsModel?.products ?? [];
      productListData = responseData;
      doneLoading.value = true;
      return (
        GeneralResponseModel(
          data: productsList,
          hasMore: productListData?.catalogProductsModel?.hasNextPage == true,
          success: true,
        ),
        null
      );
    } else {
      return (null, result.error);
    }
  }

  bool get showBannerImage =>
      productListData?.pictureModel?.imageUrl.isNotNullOrEmpty == true;

  bool get hasFilterOption =>
      productListData?.catalogProductsModel?.hasFilterOption == true;

  bool get hasSortOption =>
      productListData?.catalogProductsModel?.hasSortOption == true;

  bool get hasSubcategories => productListData?.hasSubcategories == true;

  openFilterOptions() {
    if (productListData?.catalogProductsModel != null) {
      Get.bottomSheet(
        FiltersBuilderWidget(
          catalogProductsModel: productListData!.catalogProductsModel!,
          filter: apiFilter,
          onAppLyFilter: () {
            logger.d(apiFilter.toJson());
            pagingController.refresh();
            if (Get.isBottomSheetOpen == true) {
              Get.back();
            }
          },
          onClearFilter: () {
            /*apiFilter.price = '';
            apiFilter.specs = '';
            apiFilter.ms = '';*/
            apiFilter = ApiFilter();
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
        options:
            productListData?.catalogProductsModel?.availableSortOptions ?? [],
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

  onSubProductTap(SubCategory item) {
    if (item.id != null) {
      Get.toNamed(
        ProductListPage.navTo(item.id.toString()),
        parameters: ProductListScreenArguments(
          type: GetProductListBy.CATEGORY,
          name: item.name ?? '',
          id: item.id!,
        ).toJson(),
      );
    }
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

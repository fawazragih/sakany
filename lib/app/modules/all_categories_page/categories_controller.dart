import 'package:app_extensions/app_extensions.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/modules/home_page/repository/home_repository.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/product_list_view.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';

import '../../data/api_providers/base_configs/handling_dio_response.dart';
import '../../data/models/category_tree/category_tree_response.dart';

class AllCategoriesController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;

  List<CategoryTreeResponseData>? categoriesTree;

  Rx<CategoryTreeResponseData?> selectedSidCat = Rx(null);

  @override
  void onInit() {
    super.onInit();
    fetchCats();
  }

  bool showWithSubDesign = false;

  fetchCats() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchCategories();
    // logger.d(result.toJson);
    if (result.success) {
      categoriesTree = result.response?.data;
      categoriesTree?.sort((a, b) => (b.subCategories?.length ?? 0)
          .compareTo(a.subCategories?.length ?? 0));
      showWithSubDesign = categoriesTree
              ?.firstWhereOrNull((e) => e.subCategories.isNotNullOrEmpty) !=
          null;
      selectedSidCat.value = categoriesTree?.firstOrNull;
      logger.d(showWithSubDesign);
    } else {
      buildErrorSnackBar(msg: result.error?.message);
    }
    setBusy(false);
  }

  onCatTap(CategoryTreeResponseData item) {
    if (item.categoryId != null) {
      Get.toNamed(
        ProductListPage.navTo(item.categoryId.toString()),
        parameters: ProductListScreenArguments(
          type: GetProductListBy.CATEGORY,
          name: item.name ?? '',
          id: item.categoryId!,
        ).toJson(),
      );
    }
  }

}

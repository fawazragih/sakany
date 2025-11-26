import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/category_tree/category_tree_response.dart';
import 'package:tamoily/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:tamoily/app/modules/product_list_page/product_list_view.dart';

import '../../repository/home_repository.dart';

class HomeCategoriesController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;

  List<CategoryTreeResponseData>? categoriesTree;

  @override
  void onInit() {
    super.onInit();
    fetchCats();
  }

  fetchCats() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchCategories();
    // logger.d(result.toJson);
    if (result.success) {
      categoriesTree = result.response?.data;
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

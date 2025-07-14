import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/home/categories_with_products_response.dart';

import '../../repository/home_repository.dart';

class CategoriesWithProductsController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;

  List<CategoriesWithProducts>? categoriesWithProducts;

  @override
  void onInit() {
    super.onInit();
    fetchCategoriesWithProducts();
    // logger.f('fetchCategoriesWithProducts');
  }

  fetchCategoriesWithProducts() async {
    setBusy(true);
    if (appLandingData?.showHomepageCategoryProducts == true) {
      //fetch CategoriesWithProducts
      SuccessOrError result = await _repository.fetchCategoriesWithProducts();

      if (result.success) {
        categoriesWithProducts = result.response?.data;
      } else {
        buildErrorSnackBar(msg: result.error?.message);
      }
      setBusy(false);
    } else {
      // clear CategoriesWithProducts data;
      categoriesWithProducts = null;
    }
  }

  @override
  void onClose() {
    // logger.e('onCloseCategoriesWithProducts');
    super.onClose();
  }
}

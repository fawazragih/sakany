import 'package:get/get.dart';
import 'package:sakani/app/data/models/filter_model.dart';

import '../../base_controllers_and_listeners/base_controller.dart';
import '../../data/models/category_tree/category_tree_response.dart';
import '../../utils/refresh_data_listener.dart';
import 'repository/home_repository.dart';
import 'widgets/app_home_slider_widget/app_home_slider_controller.dart';
import 'widgets/best_seller_products_widget/best_seller_products_controller.dart';
import 'widgets/categories_with_products_widget/categories_with_products_controller.dart';
import 'widgets/featured_products_widget/featured_products_controller.dart';
import 'widgets/home_categories_widget/home_categories_controller.dart';
import 'widgets/manufacturer_slider_widget/manufacturer_slider_controller.dart';

class HomeController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;

  RefreshProductsDataListener? refreshDataListener;

  List<CategoryTreeResponseData>? categoriesTree;

  S? findAndCheck<S>({String? tag}) {
    if (Get.isRegistered<S>()) {
      return Get.find<S>();
    }
    return null;
  }

  Future<void> onRefresh() async {
    findAndCheck<AppHomeSliderController>()?.fetchHomeBanners();
    findAndCheck<BestSellerProductsController>()?.fetchBestSellerProducts();
    findAndCheck<CategoriesWithProductsController>()
        ?.fetchCategoriesWithProducts();
    findAndCheck<FeaturedProductsController>()?.fetchFeaturedProducts();
    findAndCheck<HomeCategoriesController>()?.fetchCats();
    findAndCheck<ManufacturerSliderController>()?.fetchManufacturers();
    // update();
    return Future.value();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  startSearchingData(String? value) {
    refreshDataListener?.refreshData(
      apiFilter: ApiFilter(search: value),
    );
  }

  clearSearchData() async {
    // refreshDataListener?.refreshData(
    //   apiFilter: ApiFilter(catID: selectedCatID.value?.id),
    // );
  }
}

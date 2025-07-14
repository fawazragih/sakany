import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';

import '../../../../data/models/product_summary.dart';
import '../../repository/home_repository.dart';

class FeaturedProductsController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;

  List<ProductSummary>? featuredProductsRes;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
    // logger.f('fetchFeaturedProducts');
  }

  fetchFeaturedProducts() async {
    setBusy(true);
    if (appLandingData?.showFeaturedProducts == true) {
      //fetch FeaturedProducts
      SuccessOrError result = await _repository.fetchFeaturedProducts();

      if (result.success) {
        featuredProductsRes = result.response?.data;
      } else {
        buildErrorSnackBar(msg: result.error?.message);
      }

      setBusy(false);
    } else {
      // clear FeaturedProducts data;
      featuredProductsRes = null;
    }
  }

  @override
  void onClose() {
    // logger.e('onCloseFeaturedProducts');
    super.onClose();
  }
}

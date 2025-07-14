import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import '../../../../data/models/product_summary.dart';
import '../../repository/home_repository.dart';

class BestSellerProductsController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;

  List<ProductSummary>? bestSellerProductsRes;

  @override
  void onInit() {
    super.onInit();
    fetchBestSellerProducts();
    // logger.f('fetchBestSellerProducts');
  }

  fetchBestSellerProducts() async {
    setBusy(true);
    if (appLandingData?.showBestsellersOnHome == true) {
      //fetch BestSellerProducts
      SuccessOrError result = await _repository.fetchBestSellerProducts();

      if (result.success) {
        bestSellerProductsRes = result.response?.data;
      } else {
        buildErrorSnackBar(msg: result.error?.message);
      }

      setBusy(false);
    } else {
      // clear BestSellerProducts data;
      bestSellerProductsRes = null;
    }
  }

  @override
  void onClose() {
    // logger.e('onCloseBestSeller');
    super.onClose();
  }
}

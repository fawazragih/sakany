import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/models/product_summary.dart';

import 'repository/new_product_repository.dart';

class NewProductsController extends BaseController {
  final NewProductRepository _repository = NewProductRepository();

  List<ProductSummary> data = [];

  @override
  void onInit() {
    super.onInit();
    fetchNewProducts();
  }

  fetchNewProducts() async {
    // productSink.add(ApiResponse.loading());
    // try {
    //   NewProductResponse response = await _repository.fetchNewProducts();
    //   productSink.add(ApiResponse.completed(response.data));
    // } catch (e) {
    //   productSink.add(ApiResponse.error(e.toString()));
    //   print(e);
    // }
    setBusy(true);
    SuccessOrError result = await _repository.fetchNewProducts();
    if (result.success) {
      data = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }
}

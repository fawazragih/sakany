import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/pagination_logic_controller.dart';
import 'package:sakani_mobile_app/app/data/api_providers/api_response_models/general_response_model.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/models/customer_review_response.dart';
import 'package:sakani_mobile_app/app/modules/product_review_page/repository/product_review_repository.dart';

class CustomerReviewController extends BaseController
    with PaginationLogicController<ProductReview> {
  final ProductReviewRepository _repository = ProductReviewRepository();

  @override
  void onInit() {
    super.onInit();
    initPagingController();
  }

  @override
  Future<SuccessOrError> getData(int page) async {
    SuccessOrError result = await _repository.fetchMyReviews(page);

    if (result.success) {
      CustomerReviewData responseData = result.response?.data;
      List<ProductReview> productsList = responseData.productReviews ?? [];
      // productListData = responseData;
      // doneLoading.value = true;

      return (
        GeneralResponseModel(
          data: productsList,
          // hasMore: productListData?.catalogProductsModel?.hasNextPage == true,
          hasMore: responseData.pagerModel?.hasNextPage == true,
          success: true,
        ),
        null
      );
    } else {
      return (null, result.error);
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

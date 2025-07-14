import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/base_controllers_and_listeners/pagination_logic_controller.dart';
import 'package:sakani/app/data/api_providers/api_response_models/general_response_model.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/product_review_response.dart';
import 'package:sakani/app/data/models/requestbody/form_value.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani/app/data/models/requestbody/post_review_req_body.dart';
import 'package:sakani/app/utils/constants/app_constants.dart';
import 'repository/product_review_repository.dart';

class ProductReviewController extends BaseController
    with PaginationLogicController<ProductReviewItem> {
  final String bottomNavigationBarId = 'bottomNavigationBarId';
  final ProductReviewRepository _repository = ProductReviewRepository();
  int? productId;
  ProductReviewData? data;

  bool get showAddReview =>
      data?.generalInfo?.addProductReview?.canCurrentCustomerLeaveReview ==
      true;

  @override
  void onInit() {
    super.onInit();
    productId = int.tryParse(Get.parameters['product_id'] ?? '') ?? -1;
    if (productId == -1) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.back();
        buildErrorSnackBar(msg: 'product_id mus be passed');
      });
      return;
    }
    initPagingController();
  }

  @override
  Future<SuccessOrError> getData(int page) async {
    Map<String, dynamic> queryParams = {
      'Start': pagingController.itemList.isNullOrEmpty
          ? 0
          : pagingController.itemList!.length,
      'Length': 2,
    };

    SuccessOrError result = await _repository.fetchProductReviews(
      productId!,
      queryParams,
    );

    if (result.success) {
      data = result.response?.data;
      List<ProductReviewItem> newItems = data?.reviews?.items ?? [];
      int listLength =
          (pagingController.itemList?.length ?? 0) + newItems.length;
      return (
        GeneralResponseModel(
          data: newItems,
          hasMore: data?.reviews?.hasMore(listLength) ?? false,
          success: true,
        ),
        null
      );
    } else {
      return (null, result.error);
    }
  }

  void postHelpfulness(int productReviewId, {required bool isHelpful}) async {
    // helpfulnessSink.add(ApiResponse.loading());

    showProgressDialog();
    SuccessOrError result = await _repository.postReviewHelpfulness(
      productReviewId,
      FormValuesRequestBody(
        formValues: [
          FormValue(
            key: AppConstants.productReviewId,
            value: productReviewId.toString(),
          ),
          FormValue(
            key: AppConstants.wasReviewHelpful,
            value: isHelpful.toString(),
          ),
        ],
      ),
    );

    hideProgressDialog();

    if (result.success) {
      var index = data?.reviews?.items?.indexWhere(
          (element) => element.helpfulness?.productReviewId == productReviewId);
      if (index != null && index > -1) {
        data?.reviews?.items?[index].helpfulness = result.response?.data;
      }
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void postReview(AddProductReview formData) async {
    showProgressDialog();

    SuccessOrError response = await _repository.postProductReview(
      productId,
      PostReviewReqBody(
        data: PostReviewData(
          addProductReview: formData,
        ),
      ),
    );
    hideProgressDialog();

    if (response.success) {
      data = response.response?.data;
      pagingController.refresh();
    } else {
      buildErrorSnackBar(msg: response.error.toString());
    }
  }

  // void fetchCustomerReviews() async {
  //   if (_lastPageReached) return;
  //
  //   if (_pageNumber == 1) {
  //     customerReviewSink.add(ApiResponse.loading());
  //   } else {
  //     loaderSink.add(ApiResponse.loading());
  //   }
  //
  //   try {
  //     CustomerReviewResponse response =
  //         await _repository.fetchMyReviews(_pageNumber);
  //
  //     if (_pageNumber == 1) {
  //       _cachedData = response.data;
  //     } else {
  //       _cachedData?.productReviews
  //           ?.addAll(response.data?.productReviews ?? []);
  //       _cachedData?.pagerModel = response.data?.pagerModel;
  //     }
  //
  //     customerReviewSink.add(ApiResponse.completed(_cachedData));
  //     if (_pageNumber > 1) {
  //       loaderSink.add(ApiResponse.completed(''));
  //     }
  //
  //     _pageNumber++;
  //     _lastPageReached = (response.data?.pagerModel?.totalPages ?? 0) ==
  //         (response.data?.pagerModel?.currentPage ?? 0);
  //   } catch (e) {
  //     customerReviewSink.add(ApiResponse.error(e.toString()));
  //     if (_pageNumber > 1) {
  //       loaderSink.add(ApiResponse.error(e.toString()));
  //     }
  //     debugPrint(e.toString());
  //   }
  // }

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

import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/api_providers/product_review_api.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani/app/data/models/requestbody/post_review_req_body.dart';

class ProductReviewRepository {
  final ProductReviewApi _api = ProductReviewApi();

  Future<SuccessOrError> fetchProductReviews(int productId,   Map<String, dynamic> params) => _api.fetchProductReviews(productId,params);
  // Future<SuccessOrError> fetchProductReviewsList(Map<String,dynamic> params) => _api.fetchProductReviewsList(params);

  Future<SuccessOrError> postReviewHelpfulness(
          int reviewId, FormValuesRequestBody reqBody) =>
      _api.postReviewHelpfulness(reviewId, reqBody);

  Future<SuccessOrError> fetchMyReviews(int pageNumber) =>
      _api.fetchMyReviews(pageNumber);

  Future<SuccessOrError> postProductReview(
          int? productId, PostReviewReqBody postReviewReqBody) =>
      _api.postProductReview(productId, postReviewReqBody);
}

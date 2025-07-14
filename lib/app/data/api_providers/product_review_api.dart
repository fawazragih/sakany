import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani/app/data/models/requestbody/post_review_req_body.dart';

import '../models/customer_review_response.dart';
import '../models/product_review_response.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';

class ProductReviewApi extends BaseApi {
  Future<SuccessOrError> fetchProductReviews(
      int productId, Map<String, dynamic> params) async {
    return await dio
        .get(
          '${ApiEndpoints.productReviews}/$productId',
          queryParameters: params,
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<ProductReviewData,
              ProductReviewData>.fromJson(
            json: data,
            serialize: ProductReviewData.fromJson,
          ),
        );
  }

  // Future<SuccessOrError> fetchProductReviewsList(
  //     Map<String, dynamic> params) async {
  //   return await dio
  //       .post(
  //         ApiEndpoints.productReviewsList,
  //         queryParameters: params,
  //       ).mapFromResponse(
  //         (data) => GeneralResponseModel<ProductReviewData,
  //             ProductReviewData>.fromJson(
  //           json: data,
  //           serialize: ProductReviewData.fromJson,
  //         ),
  //       );
  // }

  Future<SuccessOrError> postProductReview(
      int? productId, PostReviewReqBody reqBody) async {
    // final response = await _helper.post('${Endpoints.addProductReview}/$productId', reqBody);
    //  ProductReviewResponse.fromJson(response);

    return await dio
        .post('${ApiEndpoints.addProductReview}/$productId', data: reqBody)
        .mapFromResponse(
          (data) => GeneralResponseModel<ProductReviewData,
              ProductReviewData>.fromJson(
            json: data,
            serialize: ProductReviewData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchMyReviews(int pageNumber) async {
    return await dio.get(ApiEndpoints.productReviews, queryParameters: {
      'pageNumber': pageNumber,
    }).mapFromResponse(
      (data) =>
          GeneralResponseModel<CustomerReviewData, CustomerReviewData>.fromJson(
        json: data,
        serialize: CustomerReviewData.fromJson,
      ),
    );
  }

  Future<SuccessOrError> postReviewHelpfulness(
      int reviewId, FormValuesRequestBody reqBody) async {
    return await dio
        .post(
          '${ApiEndpoints.addReviewHelpfulness}/$reviewId',
          data: reqBody,
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<Helpfulness, Helpfulness>.fromJson(
            json: data,
            serialize: Helpfulness.fromJson,
          ),
        );
  }
}

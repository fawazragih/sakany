import 'package:dio/dio.dart';
import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/file_upload_response.dart';
import 'package:sakani/app/data/models/post_checkout_attr_response.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani/app/data/models/shopping_cart_response.dart';

import '../models/add_to_cart_response.dart';
import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';

class ShoppingCartApi extends BaseApi {
  Future<SuccessOrError> fetchCartDetails() async {
    return await dio.get(ApiEndpoints.getCart).mapFromResponse(
          (data) =>
              GeneralResponseModel<ShoppingCartData, ShoppingCartData>.fromJson(
            json: data,
            serialize: ShoppingCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> addToCartFromProductBox(
    int productId,
    int cartType,
    FormValuesRequestBody reqBody,
  ) async {
    return await dio
        .post(
          '${ApiEndpoints.addToCartFromProductBox}/$productId/$cartType',
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<AddToCartData, AddToCartData>.fromJson(
            json: data,
            serialize: AddToCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> updateShoppingCart(
      FormValuesRequestBody reqBody) async {
    // final response = await _helper.post(Endpoints.updateCart, reqBody);
    // return ShoppingCartResponse.fromJson(response);
    return await dio
        .post(
          ApiEndpoints.updateCart,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ShoppingCartData, ShoppingCartData>.fromJson(
            json: data,
            serialize: ShoppingCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> postCheckoutAttribute(
    FormValuesRequestBody reqBody,
  ) async {
    // final response = await _helper.post(Endpoints.checkoutAttributeChange, reqBody);
    // return PostCheckoutAttrResponse.fromJson(response);

    return await dio
        .post(
          ApiEndpoints.checkoutAttributeChange,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<PostCheckoutAttrResponse,
              PostCheckoutAttrResponse>.fromJson(
            json: data,
            serialize: PostCheckoutAttrResponse.fromJson,
          ),
        );
  }

  Future<SuccessOrError> applyCoupon(FormValuesRequestBody reqBody) async {
    // final response = await _helper.post(Endpoints.applyCoupon, reqBody);
    // return ShoppingCartResponse.fromJson(response);

    return await dio
        .post(
          ApiEndpoints.applyCoupon,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ShoppingCartData, ShoppingCartData>.fromJson(
            json: data,
            serialize: ShoppingCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> removeCoupon(
    FormValuesRequestBody reqBody,
  ) async {
    // final response = await _helper.post(Endpoints.removeCoupon, reqBody);
    // return ShoppingCartResponse.fromJson(response);

    return await dio
        .post(
          ApiEndpoints.removeCoupon,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ShoppingCartData, ShoppingCartData>.fromJson(
            json: data,
            serialize: ShoppingCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> applyGiftCard(FormValuesRequestBody reqBody) async {
    // final response = await _helper.post(Endpoints.applyGiftCard, reqBody);
    // return ShoppingCartResponse.fromJson(response);
    return await dio
        .post(
          ApiEndpoints.applyGiftCard,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ShoppingCartData, ShoppingCartData>.fromJson(
            json: data,
            serialize: ShoppingCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> removeGiftCard(FormValuesRequestBody reqBody) async {
    // final response = await _helper.post(Endpoints.removeGiftCard, reqBody);
    // return ShoppingCartResponse.fromJson(response);

    return await dio
        .post(
          ApiEndpoints.removeGiftCard,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<ShoppingCartData, ShoppingCartData>.fromJson(
            json: data,
            serialize: ShoppingCartData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> uploadFile(String filePath, String attributeId) async {
    return await dio
        .post('${ApiEndpoints.uploadFileCheckoutAttribute}/$attributeId',
            data: FormData.fromMap(
              {
                'file': await MultipartFile.fromFile(filePath),
              },
            ))
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<FileUploadData, FileUploadData>.fromJson(
            json: data,
            serialize: FileUploadData.fromJson,
          ),
        );
  }
}

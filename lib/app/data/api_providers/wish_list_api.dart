import 'package:sakani_mobile_app/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani_mobile_app/app/data/models/wish_list_response.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';

class WishListApi extends BaseApi {
  Future<SuccessOrError> fetchWishlistItem() async {
    return await dio.get(ApiEndpoints.getWishList).mapFromResponse(
          (data) => GeneralResponseModel<WishListData, WishListData>.fromJson(
            json: data,
            serialize: WishListData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> updateWishlistItem(
      FormValuesRequestBody reqBody) async {
    return await dio
        .post(
          ApiEndpoints.updateWishList,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<WishListData, WishListData>.fromJson(
            json: data,
            serialize: WishListData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> moveItemToCart(FormValuesRequestBody reqBody) async {
    return await dio
        .post(
          ApiEndpoints.moveToCartFromWishList,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<WishListData, WishListData>.fromJson(
            json: data,
            serialize: WishListData.fromJson,
          ),
        );
  }
}

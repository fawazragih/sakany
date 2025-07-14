import 'package:sakani/app/data/api_providers/wish_list_api.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';

import '../../../data/api_providers/base_configs/handling_dio_response.dart';

class WishListRepository {
  final WishListApi _api = WishListApi();

  Future<SuccessOrError> fetchWishlistItem() => _api.fetchWishlistItem();

  Future<SuccessOrError> updateWishlistItem(FormValuesRequestBody reqBody) =>
      _api.updateWishlistItem(reqBody);

  Future<SuccessOrError> moveItemToCart(FormValuesRequestBody reqBody) =>
      _api.moveItemToCart(reqBody);
}

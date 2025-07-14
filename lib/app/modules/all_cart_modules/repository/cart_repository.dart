import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import '../../../data/api_providers/add_to_cart_api.dart';

class CartRepository {
  final ShoppingCartApi _api = ShoppingCartApi();

  Future<SuccessOrError> addToCartFromProductBox(
    int productId,
    int cartType,
    FormValuesRequestBody reqBody,
  ) =>
      _api.addToCartFromProductBox(
        productId,
        cartType,
        reqBody,
      );

  Future<SuccessOrError> fetchCartDetails() => _api.fetchCartDetails();

  Future<SuccessOrError> updateShoppingCart(FormValuesRequestBody reqBody) =>
      _api.updateShoppingCart(reqBody);

  Future<SuccessOrError> postCheckoutAttribute(FormValuesRequestBody reqBody) =>
      _api.postCheckoutAttribute(reqBody);

  Future<SuccessOrError> applyCoupon(FormValuesRequestBody reqBody) =>
      _api.applyCoupon(reqBody);

  Future<SuccessOrError> removeCoupon(FormValuesRequestBody reqBody) =>
      _api.removeCoupon(reqBody);

  Future<SuccessOrError> applyGiftCard(FormValuesRequestBody reqBody) =>
      _api.applyGiftCard(reqBody);

  Future<SuccessOrError> removeGiftCard(FormValuesRequestBody reqBody) =>
      _api.removeGiftCard(reqBody);

  Future<SuccessOrError> uploadFile(String filePath, String attributeId) =>
      _api.uploadFile(filePath, attributeId);
}

import 'package:sakani/app/data/api_providers/products_api.dart';
import 'package:sakani/app/modules/product_list_page/argument/product_list_argument.dart';

import '../../../data/api_providers/base_configs/handling_dio_response.dart';
import '../../../data/models/requestbody/form_values_request_body.dart';

class AllProductsRepository {
  final ProductsApi _api = ProductsApi();

  // final ProductsApi _api = ProductsApi();

  /*Future<SuccessOrError> */
  Future<SuccessOrError> getMore({
    required GetProductListBy type,
    required int categoryId,
    required Map<String, dynamic> queryParams,
  }) {
    return _api.getMore(
        categoryId: categoryId, type: type, queryParams: queryParams);
  }

  Future<SuccessOrError> fetchProductDetails({
    required int productId,
    bool updateCart = false,
    int? updateCartItemId,
  }) {
    return _api.fetchProductDetails(
      productId: productId,
      updateCartItemId: updateCartItemId,
      updateCart: updateCart,
    );
  }

  Future<SuccessOrError> postSelectedAttributes({
    required int productId,
    required FormValuesRequestBody formValuesRequestBody,
  }) {
    return _api.postSelectedAttributes(
      productId: productId,
      requestBody: formValuesRequestBody,
    );
  }

  addToCart({
    required int productId,
    required int cartType,
    required FormValuesRequestBody requestBody,
  }) async {
    return _api.addProductToCart(
      productId: productId,
      cartType: cartType,
      requestBody: requestBody,
    );
  }

  Future<SuccessOrError> downloadSample({required int productId}) {
    return _api.downloadSample(productId: productId);
  }

  Future<SuccessOrError> fetchSubscriptionStatus({required int productId}) {
    return _api.fetchSubscriptionStatus(productId: productId);
  }

  Future<SuccessOrError> changeSubscriptionStatus({required int productId}) {
    return _api.changeSubscriptionStatus(productId: productId);
  }

  Future<SuccessOrError> fetchRelatedProducts({required int productId}) {
    return _api.fetchRelatedProducts(productId: productId);
  }

  Future<SuccessOrError> fetchCrossSellProducts({required int productId}) {
    return _api.fetchCrossSellProducts(productId: productId);
  }

  Future<SuccessOrError> uploadFile(
      {required String filePath, required String attributeId}) {
    return _api.uploadFile(filePath: filePath, attributeId: attributeId);
  }
}

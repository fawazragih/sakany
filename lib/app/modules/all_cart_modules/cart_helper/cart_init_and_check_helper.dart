import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/helpers_methods.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/requestbody/form_values_request_body.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/different_dialogs.dart';
import 'package:tamoily/app/modules/products_details_screen/arguments/product_details_screen_arguments.dart';
import 'package:tamoily/app/modules/products_details_screen/products_details_view.dart';
import 'package:tamoily/app/utils/constants/app_constants.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import '../../../data/api_providers/add_to_cart_api.dart';
import '../../../data/models/add_to_cart_response.dart';
import '../../../data/models/requestbody/form_value.dart';

class CartCheckAndInitHelper with HelpersMethods {
  final ShoppingCartApi _api = ShoppingCartApi();

  CartCheckAndInitHelper._();

  static final CartCheckAndInitHelper _instance = CartCheckAndInitHelper._();

  static CartCheckAndInitHelper get instance => _instance;

  RxInt cartCount = RxInt(0);
  RxInt wishListCount = RxInt(0);

  addToCart(int productId, String? productName, bool isCart) async {
    DifferentDialogs.showProgressDialog();
    FormValuesRequestBody reqBody = FormValuesRequestBody(formValues: [
      FormValue(
        key: 'addtocart_$productId.EnteredQuantity',
        value: '1',
      ),
    ]);

    SuccessOrError result = await _api.addToCartFromProductBox(
      productId,
      isCart ? AppConstants.typeShoppingCart : AppConstants.typeWishList,
      reqBody,
    );
    DifferentDialogs.hideProgressDialog();

    if (result.success) {
      AddToCartData cartData = result.response?.data;

      logger.d(cartData.toJson());
      cartCount.value = cartData.totalShoppingCartProducts ?? 0;
      wishListCount.value = cartData.totalWishListProducts ?? 0;

      if (cartData.redirectToDetailsPage == true) {
        Get.toNamed(
          ProductsDetailsPage.navToRoute(productId.toString()),
          arguments: ProductDetailsScreenArguments(
            id: productId,
            name: productName ?? '',
          ),
        );
      } else {
        DifferentDialogs.successSnackBar(
          message: isCart
              ? ConstStrings.PRODUCT_ADDED_TO_CART.translate
              : ConstStrings.PRODUCT_ADDED_TO_WISHLIST.translate,
        ).show();
      }
    } else {
      buildErrorSnackBar(msg: result.error?.toString());
    }
  }
}

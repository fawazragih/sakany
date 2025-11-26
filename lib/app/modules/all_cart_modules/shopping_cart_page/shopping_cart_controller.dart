import 'package:app_extensions/app_extensions.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/gift_card.dart';
import 'package:tamoily/app/data/models/post_checkout_attr_response.dart';
import 'package:tamoily/app/data/models/requestbody/form_value.dart';
import 'package:tamoily/app/data/models/requestbody/form_values_request_body.dart';
import 'package:tamoily/app/data/models/shopping_cart_response.dart';
import 'package:tamoily/app/modules/all_cart_modules/cart_helper/cart_init_and_check_helper.dart';
import 'package:tamoily/app/modules/all_cart_modules/repository/cart_repository.dart';
import 'package:tamoily/app/modules/all_cart_modules/shopping_cart_page/widgets/checkout_dialog.dart';
import 'package:tamoily/app/modules/auth_module/login_screen/login_view.dart';
import 'package:tamoily/app/modules/checkout_page/checkout_view.dart';
import 'package:tamoily/app/modules/products_details_screen/widgets/estimate_shipping_dialog_page/estimate_shipping_dialog_view.dart';
import 'package:tamoily/app/services/bas_service_configs/bas_service.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import 'package:tamoily/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';

class ShoppingCartController extends BaseController {
  final CartRepository _repository = CartRepository();
  String? enteredCouponCode, enteredGiftCardCode;
  String warningMsg = '';
  String selectedShippingMethod = '';
  bool anonymousCheckoutPermissible = false;
  late CustomAttributeManager attributeManager;

  ShoppingCartData? _cartData;

  ShoppingCartData? get cartData => _cartData;

  set cartData(ShoppingCartData? value) {
    _cartData = value;

    //region update global cart counter
    logger.d('<> items in cart ${cartData?.cart?.items?.length}');
    int totalItems = 0;
    cartData?.cart?.items?.forEach((element) {
      totalItems += (element.quantity ?? 0);
    });
    CartCheckAndInitHelper.instance.cartCount.value = totalItems;
    //endregion

    _updateWarningMessage(cartData?.cart);

    update();
  }

  void _updateWarningMessage(Cart? cart) {
    warningMsg = '';
    var hasMinValueWaring = cart?.minOrderSubtotalWarning != null &&
        cart?.minOrderSubtotalWarning?.isNotEmpty == true;

    if (hasMinValueWaring) {
      warningMsg = '$warningMsg${cart?.minOrderSubtotalWarning ?? ''}\n';
    }
    cart?.warnings?.forEach((element) {
      warningMsg = '$warningMsg$element\n';
    });
    warningMsg.trimRight();
  }

  @override
  void onInit() {
    super.onInit();
    attributeManager = CustomAttributeManager(
      context: Get.context!,
      onClick: (priceAdjNeeded) {
        // updating UI to show selected attribute values
        // setState(() {
        //   if (priceAdjNeeded) {
        //     var checkoutAttrs =
        //         attributeManager?.getSelectedAttributes('checkout_attribute');
        //     _bloc.postCheckoutAttributes(checkoutAttrs ?? [], false);
        //   }
        // });
      },
      onFileSelected: (file, attributeId) {
        // _bloc.uploadFile(file.path ?? '', attributeId);
      },
    );
    fetchCartData();
  }

  fetchCartData() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchCartDetails();
    if (result.success) {
      cartData = result.response?.data;
      anonymousCheckoutPermissible = cartData?.anonymousPermissed ?? false;
      setBusy(false);
    } else {
      CartCheckAndInitHelper.instance.cartCount.value = 0;
      setShowRetryButton(true, errorMsg: result.error.toString());
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  Future<bool> updateItemQuantity(CartItem product, int quantity) async {
    if (product.quantity == quantity) {
      logger.d('Quantity is same, no need to update');
      return false;
    }

    List<FormValue> formValues = [];
    formValues.add(FormValue(
      key: 'itemquantity${product.id}',
      value: quantity.toString(),
    ));
    FormValuesRequestBody requestBody =
        FormValuesRequestBody(formValues: formValues);
    return await _updateCart(requestBody);
  }

  Future<bool> removeItemFromCart(int cartId) async {
    FormValuesRequestBody requestBody = FormValuesRequestBody(formValues: [
      FormValue(
        key: 'removefromcart',
        value: cartId.toString(),
      ),
    ]);

    return await _updateCart(requestBody);
  }

  Future<bool> _updateCart(FormValuesRequestBody requestBody) async {
    showProgressDialog();
    SuccessOrError result = await _repository.updateShoppingCart(requestBody);
    hideProgressDialog();
    if (result.success) {
      cartData = result.response?.data;
      return true;
    } else {
      cartData = null;
      setShowRetryButton(true, errorMsg: result.error.toString());
      buildErrorSnackBar(msg: result.error.toString());
      return false;
    }
  }

  applyGiftCard(String couponCode) async {
    FormValuesRequestBody requestBody = FormValuesRequestBody(formValues: [
      FormValue(
        key: 'giftcardcouponcode',
        value: couponCode,
      ),
    ]);

    showProgressDialog();
    SuccessOrError result = await _repository.applyGiftCard(requestBody);
    hideProgressDialog();
    if (result.success) {
      cartData = result.response?.data;
      if (cartData?.cart?.giftCardBox?.message?.isNotNullOrEmpty == true) {
        buildInfoSnack(msg: cartData?.cart?.giftCardBox?.message);
      }
    } else {
      cartData = null;
      setShowRetryButton(true, errorMsg: result.error.toString());
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void removeGiftCard(GiftCard giftCard) async {
    FormValuesRequestBody requestBody = FormValuesRequestBody(formValues: [
      FormValue(
        key: 'removegiftcard-${giftCard.id}',
        value: giftCard.couponCode,
      ),
    ]);

    showProgressDialog();
    SuccessOrError result = await _repository.removeGiftCard(requestBody);
    hideProgressDialog();
    if (result.success) {
      cartData = result.response?.data;
      if (cartData?.cart?.giftCardBox?.message?.isNotNullOrEmpty == true) {
        // errorMsgSink.add(response.data?.cart?.giftCardBox?.message);
        buildErrorSnackBar(msg: cartData?.cart?.giftCardBox?.message);
      }
    } else {
      cartData = null;
      setShowRetryButton(true, errorMsg: result.error.toString());
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  applyDiscountCoupon(String couponCode) async {
    FormValuesRequestBody requestBody = FormValuesRequestBody(formValues: [
      FormValue(
        key: 'discountcouponcode',
        value: couponCode,
      ),
    ]);
    showProgressDialog();
    SuccessOrError result = await _repository.applyCoupon(requestBody);
    hideProgressDialog();
    if (result.success) {
      cartData = result.response?.data;
      String couponMessage = '';
      cartData?.cart?.discountBox?.messages?.forEach((element) {
        couponMessage = '$couponMessage$element\n';
      });
      couponMessage = couponMessage.trimRight();
      if (couponMessage.isNotEmpty) {
        buildInfoSnack(msg: couponMessage);
      }
    } else {
      cartData = null;
      setShowRetryButton(true, errorMsg: result.error.toString());
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  removeDiscountCoupon(AppliedDiscountsWithCode coupon) async {
    FormValuesRequestBody requestBody = FormValuesRequestBody(formValues: [
      FormValue(
        key: 'removediscount-${coupon.id}',
        value: coupon.couponCode,
      ),
    ]);

    showProgressDialog();
    SuccessOrError result = await _repository.removeCoupon(requestBody);
    hideProgressDialog();
    if (result.success) {
      cartData = result.response?.data;
      String couponMessage = '';
      cartData?.cart?.discountBox?.messages?.forEach((element) {
        couponMessage = '$couponMessage$element\n';
      });
      couponMessage = couponMessage.trimRight();
      if (couponMessage.isNotEmpty) {
        buildInfoSnack(msg: couponMessage);
      }
    } else {
      cartData = null;
      setShowRetryButton(true, errorMsg: result.error.toString());
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  postCheckoutAttributes(List<FormValue> data, bool checkoutClicked) async {
    var reqBody = FormValuesRequestBody(
      formValues: data,
    );

    showProgressDialog();
    SuccessOrError result = await _repository.postCheckoutAttribute(reqBody);
    hideProgressDialog();
    if (result.success) {
      PostCheckoutAttrResponse response = result.response?.data;
      cartData = ShoppingCartData(
        cart: response.cart,
        orderTotals: response.orderTotals,
        selectedCheckoutAttributes: response.selectedCheckoutAttributess,
      );

      //region check if to go to checkout page
      if (checkoutClicked) {
        if (userAuthController.authenticated.value || anonymousCheckoutPermissible) {
          Get.toNamed(CheckoutPage.routeName);
        } else {
          showCheckoutDialog();
        }
      }
      //endregion
    } else {
      setShowRetryButton(true, errorMsg: result.error.toString());
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  showCheckoutDialog() {
    // TODO byMe showCheckoutDialog
    // logger.d('TODO');
    Get.dialog(CheckoutDialog());
  }

  void onCheckoutTap() {
    if (userAuthController.authenticated.value ||
        appLandingData?.anonymousCheckoutAllowed == true) {
      // user allowed to go to checkout
      String errMsg = attributeManager.checkRequiredAttributes(
              cartData?.cart?.checkoutAttributes ?? []) ??
          '';
      if (errMsg.isNotEmpty) {
        buildErrorSnackBar(msg: errMsg);
      } else {
        // post checkout attributes before going to Checkout screen
        List<FormValue> checkoutAttrs =
            attributeManager.getSelectedAttributes('checkout_attribute');
        postCheckoutAttributes(checkoutAttrs, true);
      }
    } else {
      // go to login
      if (BasService.instance.inBasApp) {
        //TODO byMe call BasSuperAppFlow.loginFlow;
        logger.d('TODO');
        // BasSuperAppFlow.loginFlow(AuthBloc(), context);
      } else {
        Get.toNamed(LoginScreen.routeName);
      }
    }
  }

  showEstimateShippingDialog() {
    if (cartData?.estimateShipping != null) {
      Get.bottomSheet(
        EstimateShippingDialogView(
          estimateShipping: cartData!.estimateShipping!,
          estimationForProduct: false,
          preSelectedShippingMethod: selectedShippingMethod,
        ),
        isScrollControlled: true,
      ).then((selectedMethod) {
        // logger.d(selectedMethod);
        if (selectedMethod != null && selectedMethod.toString().isNotEmpty) {
          selectedShippingMethod = selectedMethod;
        }
      });
    }
  }
}

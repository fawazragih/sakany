import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/models/requestbody/form_value.dart';
import 'package:tamoily/app/data/models/wish_list_response.dart';
import 'package:tamoily/app/modules/all_cart_modules/cart_helper/cart_init_and_check_helper.dart';
import 'package:tamoily/app/modules/all_cart_modules/shopping_cart_page/shopping_cart_view.dart';
import 'package:tamoily/app/modules/wish_list_page/repository/wish_list_repository.dart';

import '../../data/api_providers/base_configs/handling_dio_response.dart';
import '../../data/models/requestbody/form_values_request_body.dart';

class WishListController extends BaseController {

  final WishListRepository _repository = WishListRepository();
  WishListData? _data;

  RxBool showAddAllToCartButton = RxBool(false);

  WishListData? get data => _data;

  set data(WishListData? value) {
    _data = value;
    var totalItems = 0;
    data?.items?.forEach((element) {
      totalItems += (element.quantity ?? 0);
    });

    CartCheckAndInitHelper.instance.wishListCount.value = totalItems;
    showAddAllToCartButton.value =
        data?.displayAddToCart == true && data?.items?.isNotEmpty == true;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchWishListData();
  }

  fetchWishListData() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchWishlistItem();
    if (result.success) {
      data = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  removeItemFromWishlist(int id) async {
    // loaderSink.add(true);
    // try {
    //   WishListResponse response = await _repository
    //      .updateWishlistItem(FormValuesRequestBody(formValues: [
    //     FormValue(
    //       key: 'removefromcart',
    //       value: id.toString(),
    //     )
    //   ]));
    //   wishListSink.add(ApiResponse.completed(response));
    //   loaderSink.add(false);
    // } catch (e) {
    //   wishListSink.add(ApiResponse.error(e.toString()));
    //   loaderSink.add(false);
    //   print(e);
    // }

    showProgressDialog();
    SuccessOrError result =
        await _repository.updateWishlistItem(FormValuesRequestBody(formValues: [
      FormValue(
        key: 'removefromcart',
        value: id.toString(),
      )
    ]));
    hideProgressDialog();
    if (result.success) {
      data = result.response?.data;
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  moveToCart(List<int> ids) async {
    // loaderSink.add(true);
    //
    // try {
    //   WishListResponse response =
    //   await _repository.moveItemToCart(FormValuesRequestBody(formValues: [
    //     for (int i = 0; i < ids.length; i++)
    //       FormValue(
    //         key: 'addtocart',
    //         value: ids[i].toString(),
    //       )
    //   ]));
    //   wishListSink.add(ApiResponse.completed(response));
    //   loaderSink.add(false);
    //   launchCartSink.add(true);
    // } catch (e) {
    //   wishListSink.add(ApiResponse.error(e.toString()));
    //   loaderSink.add(false);
    //   print(e);
    // }

    showProgressDialog();
    SuccessOrError result =
        await _repository.moveItemToCart(FormValuesRequestBody(formValues: [
      for (int i = 0; i < ids.length; i++)
        FormValue(
          key: 'addtocart',
          value: ids[i].toString(),
        )
    ]));
    hideProgressDialog();
    if (result.success) {
      data = result.response?.data;
      goToCart();
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  goToCart() {
    Get.toNamed(ShoppingCartPage.routeName);
  }
}

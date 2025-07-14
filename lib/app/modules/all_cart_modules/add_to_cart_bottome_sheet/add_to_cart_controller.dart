import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/product_summary.dart';
import '../../../base_controllers_and_listeners/base_controller.dart';


class AddToCartBottomSheetController extends BaseController {
  final ProductSummary product;

  RxInt qty = RxInt(0);

  AddToCartBottomSheetController(this.product) {
    // qty.value = CartCheckAndInitService.instance.getProductQty(product.id!);
  }

  late int initialValueOProduct;

  @override
  void onInit() async {
    super.onInit();
    // qty.value = CartCheckAndInitHelper.instance.getProductQty(product.id);
    initialValueOProduct = qty.value;
  }

  incrementQuantity() {
    if (qty.value <= 99) ++qty.value;
  }

  decrementQuantity() {
    if (qty.value > 0) --qty.value;
  }

  // CartData? get currentCart => CartCheckAndInitHelper.instance.currentCartData;

  addToCart() async {
    // if (qty.value == initialValueOProduct) {
    //   toastMessage(AppStrings.alreadySetWithSameQty.tr.capitalizeFirst!);
    //   return;
    // }
    //
    // if (qty.value == 0) {
    //   onDeleteProduct(product);
    // } else {
    //   var result = await CartRepository.instance.addToCart(
    //     currentCart?.cartId! ?? '1',
    //     CartItem(
    //       product: product,
    //       quantity: qty.value,
    //       cartKey: currentCart?.cartKey,
    //     ),
    //   );
    //   if (Get.isBottomSheetOpen ?? false) {
    //     Get.close(1);
    //   }
    //   if (result != null && result is GeneralResponseModel && result.success) {
    //     if (result.data != null) {
    //       CartCheckAndInitHelper.instance.cartItems.value = result.data;
    //     }
    //     // buildSuccessSnackBar();
    //   } else {
    //     logger.e(result.toString());
    //     buildErrorSnackBar(msg: result.toString());
    //   }
    // }
  }

  onDeleteProduct(ProductSummary? product) async {
    // var confirmResult = await Get.dialog(AppAvatarIconDialog(
    //   iconData: CupertinoIcons.delete,
    //   title: AppStrings.delete.tr.capitalizeFirst!,
    //   explain: AppStrings.areYouSureYouWantToDeleteThisItem.tr.capitalizeFirst!,
    // ));
    //
    // if (confirmResult != null && confirmResult && currentCart != null) {
    //   var result = await CartRepository.instance.deleteFromCart(
    //     currentCart!,
    //     product!.id!,
    //   );
    //
    //   if (result != null && result is GeneralResponseModel && result.success) {
    //     if (Get.isBottomSheetOpen ?? false) {
    //       Get.close(1);
    //     }
    //     CartCheckAndInitHelper.instance.cartItems.value?.items
    //         ?.removeWhere((element) => element.product?.id == product.id);
    //     CartCheckAndInitHelper.instance.cartItems.refresh();
    //   } else {
    //     buildErrorSnackBar(msg: result.toString());
    //   }
    // }
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/product_details_response.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/global_widget/increment_and_decrement_buttons.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';
import 'package:sakani/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani/app/modules/products_details_screen/widgets/product_price_widget.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import '../../../global_widget/app_ui_helper/different_dialogs.dart';
import '../../../global_widget/images_and_videos_widgets/app_image_loader.dart';
import '../arguments/product_details_screen_arguments.dart';
import '../products_details_controller.dart';

class AssociatedProducts extends GetWidget<ProductsDetailsController> {
  const AssociatedProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.productDetails?.productType == 10 &&
        controller.productDetails?.associatedProducts?.isNotNullOrEmpty ==
            true) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ConstStrings.PRODUCT_GROUPED_PRODUCT.translate,
            style: Theme.of(Get.context!).textTheme.bodySmall.withBoldFont,
          ),
          UiHelper.verticalSpaceSmallMedium,
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.productDetails!.associatedProducts!.length,
            itemBuilder: (context, index) {
              var data = controller.productDetails!.associatedProducts![index];
              return ItemGroupProduct(
                data: data,
                onClick: (cartType) {
                  controller.addToCartClick(
                      cartType: cartType, redirectToCart: false);
                },
              ).marginOnly(bottom: 8.0);
            },
          ),
        ],
      ).marginOnly(bottom: 16.0.h);
    }
    return Offstage();
  }
}

class ItemGroupProduct extends StatelessWidget {
  final ProductDetails data;
  final Function(int cartType) onClick;

  const ItemGroupProduct({
    super.key,
    required this.data,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => Get.toNamed(
        ProductsDetailsPage.navToRoute(data.id.toString()),
        arguments: ProductDetailsScreenArguments(
          id: data.id,
          name: data.name,
          productDetails: data,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.defaultPictureModel?.imageUrl != null)
              AppImageLoader(
               imageUrl: data.defaultPictureModel?.imageUrl ?? '',
                width: 120,
                height: 125,
                borderRadius: BorderRadius.circular(12),
                fit: BoxFit.cover,
              ),
            UiHelper.horizontalSpaceSmall,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UiHelper.verticalSpaceSmall,
                  Text(
                    data.name ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
                  ),
                  UiHelper.verticalSpaceSmallMedium,

                  if (data.productPrice != null &&
                      data.productPrice?.hidePrices == false &&
                      data.addToCart?.customerEntersPrice == false) ...[
                    ProductPriceWidget(
                      productPrice: data.productPrice!,
                    ),
                    UiHelper.verticalSpaceSmall,
                  ],

                  //region quantity and favorite buttons
                  Row(
                    children: [
                      Flexible(
                        // flex: 3,
                        child: IncrementAndDecrementButtons(
                          iconBgColor: Theme.of(context).colorScheme.primary,
                          iconSize: 24.0,
                          circularIcons: false,
                          iconPadding: EdgeInsets.all(4),
                          qty: data.addToCart?.enteredQuantity ?? 1,
                          textContentPadding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                          onDecrement: (value) async {
                            if (data.addToCart?.enteredQuantity != null &&
                                data.addToCart!.enteredQuantity! <= 1) {
                              DifferentDialogs.messageSnackBar(
                                message: ConstStrings
                                    .PRODUCT_QUANTITY_POSITIVE.translate,
                              ).show();
                              return false;
                            } else {
                              if (data.addToCart?.enteredQuantity != null) {
                                data.addToCart!.enteredQuantity = value;
                                return true;
                              }
                            }
                            return false;
                          },
                          onIncrement: (value) async {
                            if (data.addToCart?.enteredQuantity != null) {
                              data.addToCart?.enteredQuantity = value;
                              return true;
                            }
                            return false;
                          },
                        ),
                      ),
                      UiHelper.horizontalSpaceSmall,
                      AppCard(
                        onTap: () => onClick(2),
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Color(0xFFFF476E),
                          // size: 26,
                        ),
                      ),
                      UiHelper.horizontalSpaceSmall,
                      AppCard(
                        padding: EdgeInsets.all(4.0),
                        onTap: () => onClick(1),
                        child: Icon(
                          CupertinoIcons.cart,
                          // size: 26,
                        ),
                      )
                    ],
                  ),
                  //endregion
                ],
              ).marginSymmetric(horizontal: 8.0, vertical: 12),
            )
          ],
        ),
      ),
    );
  }
}

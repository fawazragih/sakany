import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_controller.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import 'quantity_box_widget.dart';

class BottomNavigationButtons extends GetWidget<ProductsDetailsController> {
  const BottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    bool show1 = controller.productDetails?.addToCart?.disableBuyButton == false && controller.productDetails?.productType != 10;
    bool show2 = controller.productDetails?.addToCart?.availableForPreOrder == false;

    // logger.d(show1 && show2);
    return Card(
      // elevation: 5.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0))),
      // color: Colors.green,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: QuantityBoxWidget(
              showTitle: false,
            ).paddingDirection(end: 12),
          ),
          if (show1 && show2)
            Flexible(
              child: ActionButton(
                text: controller.productDetails?.addToCart?.isRental == true
                    ? ConstStrings.PRODUCT_BTN_RENT_NOW.translate.toUpperCase()
                    : ConstStrings.PRODUCT_BTN_BUY_NOW.translate.toUpperCase(),
                onPressed: () => controller.addToCartClick(
                    cartType: 1, redirectToCart: true),
              ),
            ),
        ],
      ).paddingOnly(
        left: 12.w,
        right: 12.w,
        top: 12.w,
        bottom: 8.w,
      ),
    );
  }
}

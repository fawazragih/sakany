import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/user_auth_controller.dart';
import 'package:tamoily/app/modules/products_details_screen/products_details_controller.dart';
import 'package:tamoily/app/modules/products_details_screen/products_details_view.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import '../../../global_widget/action_buttons/action_button.dart';

class ProductAvailabilityWidget extends GetWidget<ProductsDetailsController> {
  // final ProductDetails? data;
  // final VoidCallback onTap;

  const ProductAvailabilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = controller.productDetails;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data?.stockAvailability.isNotNullOrEmpty == true)
          TitleAndValueRow(
            title: ConstStrings.PRODUCT_AVAILABILITY.translate,
            value: data?.stockAvailability ?? '',
          ),

        if (data?.isFreeShipping == true)
          Row(
            children: [
              const Icon(Icons.local_shipping_outlined),
              const SizedBox(width: 10),
              Text(ConstStrings.PRODUCT_FREE_SHIPPING.translate),
            ],
          ),

        if (data?.deliveryDate != null &&
            data?.deliveryDate?.isNotEmpty == true)
          TitleAndValueRow(
            title: ConstStrings.PRODUCT_DELIVERY_DATE.translate,
            value: data?.deliveryDate ?? '',
          ),

        //region productSku,
        if (controller.productDetails!.checkShowSku)
          TitleAndValueRow(
            title: ConstStrings.SKU.translate,
            value: controller.productDetails?.sku ?? '',
          ),
        //endregion

        //region productManufacturerPartNumber
        if (controller.productDetails!.checkShowManufacturerPartNumber)
          TitleAndValueRow(
            title: ConstStrings.PRODUCT_MANUFACTURER_PART_NUM.translate,
            value:
                controller.productDetails?.manufacturerPartNumber?.toString() ??
                    '',
          ),
        //endregion

        //productGtin,
        if (controller.productDetails!.checkShowGtin)
          TitleAndValueRow(
            title: ConstStrings.SKU.translate,
            value: controller.productDetails?.gtin ?? '',
          ),
        //endregion

        // back in stock subscription button
        // to show btn that say inform me when product is available
        if (data?.displayBackInStockSubscription == true)
          ActionButton(
            isOutLined: true,
            onPressed: () {
              //TODO check go to login screen and come back to here.
              bool loggedIn = Get.find<UserAuthController>().authenticated.value;

              if (loggedIn && data?.id != null) {
                controller.getSubscriptionStatus(data!.id!);
              } else {
                controller.buildInfoSnack(
                    msg: ConstStrings.BACK_IN_STOCK_ONLY_REGISTERED.translate);
              }
            },
            text: ConstStrings.BACK_IN_STOCK_NOTIFY_ME_WHEN_AVAILABLE.translate,
          ),
      ].withSpaceBetween(
        height: 8.0.h,
      ),
    ).marginOnly(bottom: 16.0.h);
  }
}

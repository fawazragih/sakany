import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/product_details_response.dart';
import 'package:tamoily/app/modules/products_details_screen/products_details_controller.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

class GetTierPriceTableWidget extends GetWidget<ProductsDetailsController> {
  const GetTierPriceTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.productDetails?.tierPrices?.isNotEmpty == true &&
        controller.productDetails?.tierPrices != null) {
      final List<TierPrice> tierPrices = controller.productDetails!.tierPrices!;

      if (tierPrices.isEmpty) return const Offstage();

      var textStyle = Theme.of(context).textTheme.bodySmall;

      // print(tierPrices.length);

      return Table(
        border: TableBorder.all(
          color: Theme.of(context).disabledColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0.r),
        ),
        children: [
          //region QUANTITY row
          TableRow(
            children: [
              Text(
                ConstStrings.PRODUCT_TIER_PRICE_QUANTITY.translate,
                style: textStyle,
              ).paddingDirection(
                top: 4.0,
                bottom: 4.0,
                start: 12,
              ),
              for (var i = 0; i < tierPrices.length; i++)
                Text(
                  '${tierPrices[i].quantity}+',
                  style: textStyle,
                ).paddingAll(4.0),
            ],
          ),
          //endregion
          //region price row
          TableRow(
            children: [
              Text(
                ConstStrings.PRODUCT_TIER_PRICE_PRICE.translate,
                style: textStyle,
              ).paddingDirection(
                top: 4.0,
                bottom: 8.0,
                start: 12,
              ),
              for (var i = 0; i < tierPrices.length; i++)
                Text(
                  '${tierPrices[i].price}',
                  style: textStyle,
                ).paddingAll(4.0),
            ],
          ),
          //endregion
        ],
      ).marginOnly(bottom: 16.h);
    }

    return Offstage();
  }
}

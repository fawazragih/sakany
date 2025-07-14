import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/product_list_view.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_controller.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../../data/models/product_details_response.dart';

class ProductVendorAsTagsWidget extends GetWidget<ProductsDetailsController> {
  const ProductVendorAsTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.productDetails?.vendorModel != null &&
        controller.productDetails?.showVendor == true) {
      final ProductDetails data = controller.productDetails!;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ConstStrings.PRODUCT_VENDOR.translate,
            style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
          ),
          const SizedBox(height: 8.0),
          InkWell(
            onTap: () {
              if (data.vendorModel?.id != null) {
                Get.toNamed(
                  ProductListPage.navTo(data.vendorModel!.id.toString()),
                  arguments: ProductListScreenArguments(
                    name: data.vendorModel?.name,
                    id: data.vendorModel?.id,
                    type: GetProductListBy.VENDOR,
                  ),
                );
              }
            },
            child: Chip(
              label: Text(data.vendorModel?.name ?? ""),
              padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
              elevation: 1,
            ),
          ),
        ],
      ).marginOnly(bottom: 16.0.h);
    }

    return Offstage();
  }
}

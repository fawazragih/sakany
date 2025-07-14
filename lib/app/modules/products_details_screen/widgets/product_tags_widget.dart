import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani/app/modules/product_list_page/product_list_view.dart';
import 'package:sakani/app/modules/products_details_screen/products_details_controller.dart';
import '../../../utils/constants/const_strings.dart';

class ProductTagsWidget extends GetWidget<ProductsDetailsController> {
  const ProductTagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.productDetails!.productTags?.isNullOrEmpty == true) {
      return Offstage();
    }

    final data = controller.productDetails!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ConstStrings.PRODUCT_TAG.translate,
          style: Theme.of(context).textTheme.bodySmall.withBoldFont,
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 30,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.productTags?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: InkWell(
                  onTap: () {
                    if (data.productTags?[index].id != null) {
                      Get.toNamed(
                        ProductListPage.navTo(
                          data.productTags![index].id.toString(),
                        ),
                        parameters: ProductListScreenArguments(
                          id: data.productTags?[index].id,
                          type: GetProductListBy.TAG,
                          name: data.productTags![index].name,
                        ).toJson(),
                      );
                    }
                  },
                  child: Chip(
                    label: Text(data.productTags?[index].name ??
                        '' ' (${data.productTags?[index].productCount})'),
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 3),
                    elevation: 1,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).marginOnly(bottom: 16.0.h);
  }
}

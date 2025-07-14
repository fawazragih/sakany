import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/empty_data_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/shimmer_list.dart';

import '../../../../global_widget/retry_and_errors_widgets/retry_widget.dart';
import '../product_box/horizontal_product_list.dart';
import 'categories_with_products_controller.dart';

class CategoriesWithProductsWidget extends StatelessWidget {
  const CategoriesWithProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesWithProductsController>(
      init: CategoriesWithProductsController(),
      builder: (controller) {
        return controller.busy
            ? AppReadyShimmerList(
                inGrid: false,
                horizontal: true,
                imageHeight: 175.0.h,
                containerWidth: 0.4.sw,
                itemCount: 10,
              )
            : controller.showRetryButton
                ? RetryWidget(
                    onRetry: controller.fetchCategoriesWithProducts,
                  )
                : controller.categoriesWithProducts.isNullOrEmpty
                    // ? EmptyDataWidget()
                    ? Offstage()
                    : Column(
                        children: [
                          ...controller.categoriesWithProducts!
                              .map<Widget>((e) {
                            return HorizontalProductList(
                              title: e.name ?? '',
                              showSeeAllBtn: true,
                              showSubcategories: true,
                              subcategories: e.subCategories,
                              productList: e.products,
                              categoryId: e.id,
                            );
                          }),
                        ],
                      ).marginOnly(bottom: 16.0);
      },
    );
  }
}

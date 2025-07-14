import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/empty_data_widget.dart';
import 'package:sakani/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:sakani/app/global_widget/shimmer_list.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import '../product_box/horizontal_product_list.dart';
import 'featured_products_controller.dart';

class FeaturedProductsWidget extends StatelessWidget {
  const FeaturedProductsWidget({super.key});

  // @override
  // FeaturedProductsWidgetController get controller {
  //   if (!Get.isRegistered<BestSellerProductsWidgetController>()) {
  //     Get.put(BestSellerProductsWidgetController());
  //   }
  //   return Get.find<BestSellerProductsWidgetController>();
  //   // return super.controller;
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeaturedProductsController>(
      init: FeaturedProductsController(),
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
                    onRetry: controller.fetchFeaturedProducts,
                  )
                : controller.featuredProductsRes.isNullOrEmpty
                    ? EmptyDataWidget()
                    : HorizontalProductList(
                        title: ConstStrings.HOME_FEATURED_PRODUCT.translate,
                        showSeeAllBtn: false,
                        showSubcategories: false,
                        subcategories: const [],
                        productList: controller.featuredProductsRes,
                      ) .marginOnly(bottom: 16.0);
      },
    );
  }
}

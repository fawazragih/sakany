import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/product_summary.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import '../home_page/widgets/product_box/horizontal_product_template.dart';
import 'new_products_controller.dart';

class NewProductsPage extends StatelessWidget {
  static const String routeName = '/app/new-products';

  const NewProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_NEW_PRODUCTS.translate,
      ),
      body: GetBuilder<NewProductsController>(
        builder: (controller) {
          return controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchNewProducts,
                )
              : SkeletonOfListView<ProductSummary>(
                  padding:
                      SharedStyle.singleChildScrollViewHorizontalPadding.add(
                    EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  isLoading: controller.busy,
                  // isLoading: true,
                  showEmptyData: controller.data.isNullOrEmpty == true,
                  fakeObject: ProductSummary.fake(),
                  inGrid: true,
                  realData: controller.data,
                  itemBuilder: (item, index) {
                    return HorizontalProductTemplate(item);
                  },
                );
        },
      ),
    );
  }
}

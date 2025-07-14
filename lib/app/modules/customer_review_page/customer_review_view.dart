import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/customer_review_response.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/pagination_list_builder.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'customer_review_controller.dart';
import 'widgets/product_review_template.dart';

class CustomerReviewPage extends GetView<CustomerReviewController> {
  static const routeName = '/app/customer-review';

  const CustomerReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_MY_REVIEW.translate,
      ),
      body: GetBuilder<CustomerReviewController>(
        builder: (controller) {

          return PaginationListBuilder<ProductReview>(
            padding: SharedStyle.singleChildScrollViewHorizontalPadding.add(
              EdgeInsets.symmetric(
                vertical: 16.0.h,
              ),
            ),
            pagingController: controller.pagingController,
            newPageProgressIndicatorBuilder: SkeletonOfListView(
              fakeObject: ProductReview.fake(),
              isLoading: true,
              showEmptyData: false,
              shrinkWrap: true,
              realData: [],
              itemBuilder: (item, int index) {
                return ProductReviewTemplate(
                  item: item,
                );
              },
            ),
            itemBuilder: (ProductReview item, int index) {
              return ProductReviewTemplate(
                item: item,
              );
            },
          );
          // return ScreenStatusWidgets(
          //   controller: controller,
          //   isEmpty: false,
          //   padding: SharedStyle.singleChildScrollViewHorizontalPadding.add(
          //     EdgeInsets.symmetric(
          //       vertical: 16.0.h,
          //     ),
          //   ),
          //   dataWidget: PaginationListBuilder<ProductReview>(
          //     pagingController: controller.pagingController,
          //     newPageProgressIndicatorBuilder: SkeletonOfListView(
          //       fakeObject: ProductReview.fake(),
          //       isLoading: true,
          //       showEmptyData: false,
          //       realData: [],
          //       itemBuilder: (item, int index) {
          //         return ProductReviewTemplate(
          //           item: item,
          //         );
          //       },
          //     ),
          //     itemBuilder: (ProductReview item, int index) {
          //       return ProductReviewTemplate(
          //         item: item,
          //       );
          //     },
          //   ),
          // );
        },
      ),
    );
  }
}

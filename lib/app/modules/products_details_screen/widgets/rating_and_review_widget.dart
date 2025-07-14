import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/modules/product_review_page/product_review_screen.dart';
import '../../../data/models/product_details_response.dart';
import '../../../global_widget/rating_widget.dart';

class RatingAndReviewWidget extends StatelessWidget {
  final ProductDetails? data;

  const RatingAndReviewWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (data?.productReviewOverview?.allowCustomerReviews == true && data?.id != null) {
          Get.toNamed(ProductReviewPage.navTo(data!.id.toString()));
        }
      },
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRatingWidget(
            rate: data?.productReviewOverview?.ratingSum?.toDouble() ?? 0.0,
          ),
          // const SizedBox(width: 10),
          UiHelper.horizontalSpaceSmall,
          Text(
            // '${data?.productReviewOverview?.totalReviews} ${ConstStrings.TITLE_REVIEW.translate}',
            '${data?.productReviewOverview?.totalReviews}',
            style: Theme.of(context).textTheme.labelSmall?.withBoldFont,
          ).marginOnly(top: 4),
        ],
      ),
    ).marginOnly(bottom: 12.0.h);
  }
}

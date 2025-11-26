import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/customer_review_response.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/global_widget/rating_widget.dart';
import 'package:tamoily/app/modules/products_details_screen/arguments/product_details_screen_arguments.dart';
import 'package:tamoily/app/modules/products_details_screen/products_details_view.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

class ProductReviewTemplate extends StatelessWidget {
  final ProductReview item;

  const ProductReviewTemplate({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      withAlignment: false,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.0.h,
      ),
      onTap: () {
        if (item.productId != null) {
          Get.toNamed(
            ProductsDetailsPage.navToRoute(item.productId.toString()),
            arguments: ProductDetailsScreenArguments(
              id: item.productId!,
              name: item.productName ?? '',
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.productName ?? '',
                  style: Theme.of(context).textTheme.labelMedium?.withBoldFont,
                ),
              ),
              AppRatingWidget(
                rate: item.rating?.toDouble() ?? 0,
              ),
            ],
          ),
          UiHelper.verticalSpaceSmall,
          Text(
            item.title ?? '',
            style: Theme.of(context).textTheme.labelMedium?.withBoldFont,
          ),
          UiHelper.verticalSpaceVeryTiny,
          Text(
            item.reviewText ?? '',
            style: Theme.of(context).textTheme.labelMedium?.withBoldFont,
          ),
          UiHelper.verticalSpaceTiny,
          TitleAndValueRow(
            title: ConstStrings.REVIEW_DATE.translate,
            value: item.writtenOnStr ?? '',
          ),
        ],
      ),
    );
  }
}

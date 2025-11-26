import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/product_review_response.dart';
import 'package:tamoily/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/global_widget/rating_widget.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

import '../../../global_widget/app_ui_helper/ui_helpers.dart';

class ReviewsTemplateWidget extends StatelessWidget {
  final ProductReviewItem review;
  final bool isByCurrentUser;

  final ValueChanged<bool> postHelpfulness;

  const ReviewsTemplateWidget({
    super.key,
    required this.review,
    required this.isByCurrentUser,
    required this.postHelpfulness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImageLoader(
          imageUrl: review.customerAvatarUrl ?? '',
          shape: BoxShape.circle,
          // circularRadius: 16.r,
          isUserPlaceHolder: true,
          padding: EdgeInsets.all(2),
          errorIconScale: 1,
          // bgColor: Theme.of(context).primaryColorDark,
          borderColor: Theme.of(context).primaryColorDark,
        ),
        UiHelper.horizontalSpaceSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiHelper.verticalSpaceSmall,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      review.customerName ?? 'unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.labelSmall?.withBoldFont,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 3.h,
                    ),
                    child: AppRatingWidget(
                      rate: review.rating?.toDouble(),
                      iconSize: 14.sp,
                    ),
                  ),
                ],
              ),
              UiHelper.verticalSpaceMedium,
              if (review.title.isNotNullOrEmpty)
                Text(
                  review.title ?? '',
                  style: Theme.of(context).textTheme.labelSmall.withBoldFont,
                ).marginOnly(bottom: 8.0),
              if (review.reviewText.isNotNullOrEmpty)
                Text(
                  review.reviewText ?? 'none',
                  style: Theme.of(context).textTheme.labelSmall.withBoldFont,
                ),
              if (review.writtenOnStr != null) ...[
                UiHelper.verticalSpaceSmall,
                Text(
                  review.writtenOnStr ?? '',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
              UiHelper.verticalSpaceMedium,
              Row(
                children: [
                  Text(
                    ConstStrings.REVIEW_HELPFUL.translate,
                    style: Theme.of(context).textTheme.labelSmall.withBoldFont,
                  ),
                  // SizedBox(width: 15.w),
                  UiHelper.horizontalSpaceSmall,
                  AppCard(
                    color: Theme.of(context).primaryColorLight,
                    onTap: () => postHelpfulness(true),
                    padding: EdgeInsets.all(2),
                    radius: 12,
                    child: Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 16.sp,
                    ),
                  ),
                  UiHelper.horizontalSpaceMedium,
                  AppCard(
                    onTap: () => postHelpfulness(false),
                    color: Theme.of(context).primaryColorLight,
                    padding: EdgeInsets.all(2),
                    radius: 12,
                    child: Icon(
                      Icons.thumb_down_alt_outlined,
                      size: 16.sp,
                    ),
                  ),
                  UiHelper.horizontalSpaceMedium,
                  Text(
                    '${review.helpfulness?.helpfulYesTotal}/${review.helpfulness?.helpfulNoTotal}',
                    style: Theme.of(context).textTheme.labelMedium.withBoldFont,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/data/models/category_tree/category_tree_response.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/generic_image_and_name_template.dart';
import 'package:sakani_mobile_app/app/global_widget/shimmer_list.dart';

import '../../../../global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'home_categories_controller.dart';

class HomeCategoriesWidget extends StatelessWidget {
  final bool showOne;

  const HomeCategoriesWidget({super.key, this.showOne = false});

  SliverGridDelegateWithFixedCrossAxisCount get gridDelegate =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: showOne ? 1 : 2,
        childAspectRatio: showOne ? 1.3 : 1.1,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeCategoriesController>(
      init: HomeCategoriesController(),
      builder: (controller) {
        return controller.busy
            ? AppReadyShimmerList(
                inGrid: true,
                horizontal: false,
                imageHeight: 65,
                containerWidth: 60,
                containerHeight: 8.0,
                itemCount: 12,
                gridDelegate: gridDelegate,
              )
            : controller.showRetryButton
                ? RetryWidget(
                    onRetry: controller.fetchCats,
                  )
                : controller.categoriesTree.isNullOrEmpty
                    ? Offstage()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UiHelper.verticalSpaceSmallMedium,
                          Text(
                            AppStrings.categories.tr.capitalizeFirst!,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                .withBoldFont,
                          ),
                          UiHelper.verticalSpaceSmallMedium,
                          SizedBox(
                            height: 170.h,
                            child: GridView.builder(
                              primary: false,
                              padding: EdgeInsets.zero,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.categoriesTree?.length,
                              gridDelegate: gridDelegate,
                              itemBuilder: (context, index) {
                                var e = controller.categoriesTree![index];
                                return GenericImageAndNameInColumnTemplate<
                                    CategoryTreeResponseData>(
                                  item: e,
                                  imageShape: BoxShape.circle,
                                  onTap: controller.onCatTap,
                                  imgBorderRadius: 8.0,
                                  imgHeight: 55.h,
                                  imgWidth: 55.h,
                                  imageFit: BoxFit.cover,
                                  bgColor:
                                      Theme.of(context).colorScheme.secondary,
                                  name: (item) => item.name,
                                  image: (item) => item.iconUrl,
                                );
                              },
                            ),
                          ),
                        ],
                      );
      },
    );
  }
}

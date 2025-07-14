import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/reward_point_response.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/empty_data_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/global_widget/pagination_list_builder.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/modules/reward_point_page/widgets/reward_point_item_template.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import 'reward_point_controller.dart';

class RewardPointPage extends GetView<RewardPointController> {
  static const String routeName = '/app/reward-point';

  const RewardPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_REWARD_POINT.translate,
      ),
      body: GetBuilder<RewardPointController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async => controller.pagingController.refresh(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  return controller.doneLoading.value == false
                      ? Offstage()
                      : AppCard(
                          color: Theme.of(context).colorScheme.secondary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          child: Text(
                            controller.displayMessage ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.withBoldFont
                                ?.copyWith(
                                  height: 1.5,
                                ),
                            textAlign: TextAlign.start,
                          ),
                        );
                }),
                UiHelper.verticalSpaceSmall,
                Expanded(
                  child: PaginationListBuilder<RewardPoint>(
                    pagingController: controller.pagingController,
                    emptyDataWidget: EmptyDataWidget(
                      imageHeight: 0.5.sh,
                    ),
                    newPageProgressIndicatorBuilder:
                        SkeletonOfListView<RewardPoint>(
                      fakeObject: RewardPoint.fake(),
                      isLoading: true,
                      showEmptyData: false,
                      shrinkWrap: true,
                      realData: [],
                      itemBuilder: (item, int index) {
                        return ItemRewardPoint(
                          item: item,
                        );
                      },
                    ),
                    itemBuilder: (RewardPoint item, int index) {
                      return ItemRewardPoint(
                        item: item,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ).paddingSymmetric(
        horizontal: SharedStyle.horizontalScreenPadding,
        vertical: SharedStyle.verticalScreenPadding,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/subscription_list_response.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/check_box_form_field.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/pagination_list_builder.dart';
import '../../global_widget/empty_data_widget.dart';
import '../../global_widget/screen_status_widgets.dart';
import '../../utils/constants/const_strings.dart';
import 'subscription_controller.dart';

class SubscriptionPage extends GetView<SubscriptionController> {
  static const String routeName = '/app/subscription';

  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_BACK_IN_STOCK_SUBSCRIPTION.translate,
      ),
      body: GetBuilder<SubscriptionController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async => controller.pagingController.refresh(),
            child: Column(
              children: [
                if ((controller.cachedData?.subscriptions?.isNotEmpty ??
                        false) ==
                    true)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Text(
                      ConstStrings.BACK_IN_STOCK_DESCRIPTION.translate,
                    ),
                  ),
                Expanded(
                  child: PaginationListBuilder<Subscription>(
                    pagingController: controller.pagingController,
                    emptyDataMessage:
                        ConstStrings.BACK_IN_STOCK_NO_SUBSCRIPTION.translate,
                    emptyDataWidget: EmptyDataWidget(
                      imageHeight: 0.5.sh,
                    ),
                    newPageProgressIndicatorBuilder:
                        SkeletonOfListView<Subscription>(
                      fakeObject: Subscription.fake(),
                      isLoading: true,
                      showEmptyData: false,
                      shrinkWrap: true,
                      realData: [],
                      itemBuilder: (item, int index) {
                        return SubscriptionItemTemplate(
                          item: item,
                          isSelected: false,
                        );
                      },
                    ),
                    itemBuilder: (Subscription item, int index) {
                      return SubscriptionItemTemplate(
                        item: item,
                        isSelected: controller.isSelected(item.id!),
                        onItemSelectChanged: (bool? value) {
                          // setState(() {
                          controller.setSelectionStatus(
                            item.id!,
                            value ?? false,
                          );
                          // });
                        },
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
      bottomNavigationBar:
          ((controller.cachedData?.subscriptions?.isNotEmpty ?? false) == true)
              ? Padding(
                  padding: SharedStyle.bottomNavigationPadding,
                  child: ActionButton(
                    text: ConstStrings.BACK_IN_STOCK_DELETE_SELECTED.translate
                        .toUpperCase(),
                    onPressed: () => controller.unsubscribeSelected(),
                  ),
                )
              : null,
    );
  }
}

class SubscriptionItemTemplate extends StatelessWidget {
  final Subscription? item;
  final ValueChanged<bool?>? onItemSelectChanged;
  final bool isSelected; // _bloc.isSelected(subscription?.id!)
  const SubscriptionItemTemplate(
      {super.key,
      this.item,
      required this.isSelected,
      this.onItemSelectChanged});

  @override
  Widget build(BuildContext context) {
    if (item!.id == null) {
      return const Offstage();
    } else {
      return Card(
        child: CheckBoxFormFieldWidget(
          keyName: '${item?.hashCode}',
          label: item?.productName ?? '',
          initialValue: isSelected,
          onChanged: onItemSelectChanged,
        ),
      );
    }
  }
}

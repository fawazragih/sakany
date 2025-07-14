import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/data/models/order_history_response.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/dashed_divider_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani_mobile_app/app/modules/return_request_pages/return_request_page/return_request_view.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../order_details_page/order_details_view.dart';
import 'order_history_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderHistoryPage extends GetView<OrderHistoryController> {
  static const String routeName = '/app/order-history';

  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_ORDERS.translate,
      ),
      body: GetBuilder<OrderHistoryController>(
        builder: (controller) {
          return controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchOrderHistory,
                )
              : SkeletonOfListView<Order>(
                  padding:
                      SharedStyle.singleChildScrollViewHorizontalPadding.add(
                    EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  isLoading: controller.busy,
                  // isLoading: true,
                  showEmptyData: controller.orders.isNullOrEmpty,
                  fakeObject: Order(
                    customOrderNumber: '123456',
                    orderTotal: '1000',
                    isReturnRequestAllowed: true,
                    orderStatusEnum: 1,
                    orderStatus: 'Pending',
                    paymentStatus: 'Paid',
                    shippingStatus: 'Shipped',
                    createdOn: DateTime.now(),
                    id: 1,
                  ),
                  realData: controller.orders,
                  itemBuilder: (item, index) {
                    return OrderHistoryTemplate(
                      item: item,
                      onOrderDetailsTap: () {
                        if (item.id != null) {
                          Get.toNamed(
                              OrderDetailsPage.navToRoute(item.id.toString()));
                        }
                      },
                      onOrderReturnItems: () {
                        if (item.id == null) return;
                        Get.toNamed(
                          ReturnRequestPage.navToRoute(
                            item.id.toString(),
                          ),
                        )?.then((value) {
                          if (value == true) {
                            controller.fetchOrderHistory();
                          }
                        });
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}

class OrderHistoryTemplate extends StatelessWidget {
  final Order item;
  final VoidCallback onOrderReturnItems;
  final VoidCallback onOrderDetailsTap;

  const OrderHistoryTemplate({
    super.key,
    required this.item,
    required this.onOrderReturnItems,
    required this.onOrderDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      // onTap: onOrderDetailsTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleAndValueRow(
            title: ConstStrings.ORDER_NUMBER.translate,
            value: item.customOrderNumber.toString(),
            // placeHolderWidth: 0.9.w,
            // placeHolderWidth: 0.6.sw,
          ),
          DashedDividerWidget(),
          TitleAndValueRow(
            title: ConstStrings.ORDER_STATUS.translate,
            value: item.orderStatus ?? '',
            placeHolderWidth: 0.6.sw,
          ),
          DashedDividerWidget(),
          TitleAndValueRow(
            title: ConstStrings.ORDER_DATE.translate,
            value: '${item.createdOn?.toDateYMD}',
            placeHolderWidth: 0.8.sw,
          ),
          DashedDividerWidget(),
          TitleAndValueRow(
            title: ConstStrings.ORDER_TOTAL.translate,
            value: '${item.orderTotal}',
            placeHolderWidth: 0.6.sw,
          ),
          DashedDividerWidget(),
          TitleAndValueRow(
            title: ConstStrings.ORDER_SHIPPING_STATUS.translate,
            value: '${item.shippingStatus}',
            placeHolderWidth: 0.8.sw,
          ),
          DashedDividerWidget(),
          Skeleton.replace(
            child: Row(
              children: [
                Expanded(
                  child: ActionButton(
                    height: 20.h,
                    padding: 8.0.h,
                    text: AppStrings.orderDetails.translate,
                    isOutLined: true,
                    onPressed: onOrderDetailsTap,
                    borderColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).primaryColorDark,
                  ),
                ),
                if (item.isReturnRequestAllowed == true) ...[
                  UiHelper.horizontalSpaceSmallMedium,
                  Expanded(
                    child: ActionButton(
                      height: 20.h,
                      padding: 8.0.h,
                      text: ConstStrings.ORDER_RETURN_ITEMS.translate,
                      isOutLined: true,
                      onPressed: onOrderReturnItems,
                      borderColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ]
              ],
            ),
          )
        ],
      ),
      // child: ListTile(
      //   leading: const Icon(Icons.credit_card_outlined),
      //   title:
      //   subtitle:
      //   trailing: const Icon(Icons.keyboard_arrow_right_outlined),
      // ),
    );
  }
}

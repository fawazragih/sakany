import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/return_request_history_response.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import '../../products_details_screen/arguments/product_details_screen_arguments.dart';
import 'return_request_history_controller.dart';

class ReturnRequestHistoryPage extends GetView<ReturnRequestHistoryController> {
  static const String routeName = '/app/return-request-history';

  const ReturnRequestHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_RETURN_REQUESTS,
      ),
      body: GetBuilder<ReturnRequestHistoryController>(
        builder: (controller) {
          return controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchReturnRequestHistory,
                )
              : SkeletonOfListView<ReturnReqHistoryItem>(
                  padding:
                      SharedStyle.singleChildScrollViewHorizontalPadding.add(
                    EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  isLoading: controller.busy,
                  // isLoading: true,
                  showEmptyData:
                      controller.historyData?.items?.isNullOrEmpty == true,
                  fakeObject: ReturnReqHistoryItem.fakeData(),
                  realData: controller.historyData?.items,
                  itemBuilder: (ReturnReqHistoryItem item, index) {
                    return ReturnReqHistoryItemTemplate(
                      item: item,
                      downloadFile: controller.downloadFile,
                    );
                  },
                );
        },
      ),
    );
  }
}

class ReturnReqHistoryItemTemplate extends StatelessWidget {
  final ReturnReqHistoryItem item;
  final ValueChanged<String?> downloadFile;

  const ReturnReqHistoryItemTemplate(
      {super.key, required this.item, required this.downloadFile});

  @override
  Widget build(BuildContext context) {
    var title = ConstStrings.RETURN_ID.translate
        .replaceAll('{0}', item.id.toString() ?? "")
        .replaceAll('{1}', item.returnRequestStatus ?? '');
    var subtitle =
        '${ConstStrings.RETURNED_ITEM.translate} ${item.productName} * ${item.quantity}\n'
        '${ConstStrings.RETURN_REASON.translate} ${item.returnReason}\n'
        '${ConstStrings.RETURN_ACTION.translate}: ${item.returnAction}\n'
        '${ConstStrings.RETURN_DATE_REQUESTED.translate} ${item.createdOn?.toDateYMD}';

    return AppCard(
      onTap: () {
        if (item.productId != null) {
          Get.toNamed(
              ProductsDetailsPage.navToRoute(item.productId!.toString()),
              parameters: ProductDetailsScreenArguments(
                id: item.productId!,
                name: item.productName ?? '',
              ).toJson());
        }
      },
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium.withBoldFont,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          if (item.uploadedFileGuid != null &&
              item.uploadedFileGuid != '00000000-0000-0000-0000-000000000000')
            AppCard(
              withAlignment: false,
              padding: EdgeInsets.all(4.w),
              color: Theme.of(context).colorScheme.secondary,
              radius: 16.r,
              onTap: () => downloadFile(item.uploadedFileGuid),
              child: Icon(
                CupertinoIcons.arrow_down_doc,
                color: Theme.of(context).primaryColorDark,
              ),
            )
        ],
      ),
    );
  }
}

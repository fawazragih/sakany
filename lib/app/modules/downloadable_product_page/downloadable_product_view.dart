import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/downloadable_product_response.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import 'downloadable_product_controller.dart';

class DownloadableProductPage extends GetView<DownloadableProductController> {
  static const String routeName = '/app/downloadable-product';
  const DownloadableProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: ConstStrings.ACCOUNT_DOWNLOADABLE_PRODUCTS.translate),
      body: GetBuilder<DownloadableProductController>(
        builder: (controller) {
          return controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchDownloadableProducts,
                )
              : SkeletonOfListView<DownloadableProductItem>(
                  padding:
                      SharedStyle.singleChildScrollViewHorizontalPadding.add(
                    EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  isLoading: controller.busy,
                  // isLoading: true,
                  showEmptyData:
                      controller.productData?.items.isNullOrEmpty == true,
                  fakeObject: DownloadableProductItem.fake(),
                  realData: controller.productData?.items,
                  itemBuilder: (item, index) {
                    return DownloadableProductItemTemplate(
                      item: item,
                      onDownload: () => controller.downloadFile(
                          item.orderItemGuid ?? '', 'null'),
                    );
                  },
                );
        },
      ),
    );
  }
}

class DownloadableProductItemTemplate extends StatelessWidget {
  final VoidCallback? onDownload;

  final DownloadableProductItem? item;

  const DownloadableProductItemTemplate(
      {super.key, this.item, this.onDownload});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 9,
                child: Text(
                  item?.productName ?? '',
                ),
              ),
              if (item?.downloadId != null && item?.downloadId != 0)
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: onDownload,
                    child: const Icon(Icons.download_rounded),
                  ),
                ),
            ],
          ),
          Text(
              '${ConstStrings.ORDER_NUMBER.translate}: ${item?.customOrderNumber ?? ''}'),
          Text(
            '${ConstStrings.ORDER_DATE.translate}: ${item?.createdOn?.toDateYMD}',
          ),
        ],
      ),
    );
  }
}

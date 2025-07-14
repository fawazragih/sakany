import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/all_vendors_response.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import 'package:sakani_mobile_app/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani_mobile_app/app/modules/product_list_page/product_list_view.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/full_description_widget.dart';
import 'package:sakani_mobile_app/app/modules/vendors_pages/contact_vendor_page/contact_vendor_view.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import 'vendor_list_controller.dart';

class VendorListPage extends GetView<VendorListController> {
  static const routeName = '/app/vendor-list';

  const VendorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.PRODUCT_VENDOR.translate,
      ),
      body: GetBuilder<VendorListController>(
        builder: (controller) {
          return controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchAllVendors,
                )
              : SkeletonOfListView<VendorDetails>(
                  padding:
                      SharedStyle.singleChildScrollViewHorizontalPadding.add(
                    EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  isLoading: controller.busy,
                  // isLoading: true,
                  showEmptyData: controller.data.isNullOrEmpty == true,
                  fakeObject: VendorDetails.fake(),
                  realData: controller.data,
                  itemBuilder: (item, index) {
                    return VendorItemTemplate(
                      item: item,
                    );
                  },
                );
        },
      ),
    );
  }
}

class VendorItemTemplate extends StatelessWidget {
  final VendorDetails item;

  const VendorItemTemplate({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            ProductListPage.navTo(item.id.toString()),
            parameters: ProductListScreenArguments(
              id: item.id,
              name: item.name,
              type: GetProductListBy.VENDOR,
            ).toJson(),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(5.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (item.pictureModel?.imageUrl != null)
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: AppImageLoader(
                    imageUrl: item.pictureModel?.imageUrl ?? '',
                    width: 120.0.w,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              SizedBox(width: 10.w),
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 120.0.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name ?? '',
                        // style: Styles.productNameTextStyle(context),
                      ),
                      Html(
                        data: item.description ?? '',
                        shrinkWrap: true,
                        style: htmlNoPaddingStyle(fontSize: 15.sp),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (item.id != null) {
                            Get.toNamed(ContactVendorPage.navToRoute(
                                item.id!.toString()));
                          }
                        },
                        child: Text(
                          ConstStrings.VENDOR_CONTACT_VENDOR.translate,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

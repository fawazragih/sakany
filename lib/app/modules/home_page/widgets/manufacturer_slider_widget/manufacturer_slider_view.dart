import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/shimmer_list.dart';
import 'package:sakani/app/modules/product_list_page/product_list_view.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import '../../../../data/models/home/manufacturers_response.dart';
import '../../../../global_widget/empty_data_widget.dart';
import '../../../../global_widget/images_and_videos_widgets/app_image_loader.dart';
import '../../../../global_widget/retry_and_errors_widgets/retry_widget.dart';
import '../../../product_list_page/argument/product_list_argument.dart';
import '../product_box/product_box_header.dart';
import 'manufacturer_slider_controller.dart';

class ManufacturerSliderWidget extends StatelessWidget {
  const ManufacturerSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManufacturerSliderController>(
      init: ManufacturerSliderController(),
      builder: (controller) {
        return controller.busy
            ? AppReadyShimmerList(
                inGrid: false,
                horizontal: true,
                imageHeight: 100,
                containerWidth: 100,
                itemCount: 10,
              )
            : controller.showRetryButton
                ? RetryWidget(
                    onRetry: controller.fetchManufacturers,
                  )
                : controller.manufacturerData.isNullOrEmpty
                    // ? EmptyDataWidget()
                    ? Offstage()
                    : HorizontalManufacturerSlider(
                        ConstStrings.HOME_MANUFACTURER.translate,
                        controller.manufacturerData!,
                      ).marginOnly(bottom: 16.0);
      },
    );
  }
}

class HorizontalManufacturerSlider extends StatelessWidget {
  final String title;

  final List<ManufacturerData> manufacturersList;

  const HorizontalManufacturerSlider(this.title, this.manufacturersList,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductBoxHeader(
          title: title,
          showSeeAllBtn: manufacturersList.isNotEmpty == true,
          showSubcategories: false,
          subcategories: const [],
          itIsManufacturerList: manufacturersList.isNotNullOrEmpty,
        ),
        SizedBox(
          height: 150.h,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: manufacturersList.length,
              itemBuilder: (BuildContext context, int index) {
                return ManufacturerBox(manufacturersList[index]);
              }),
        ),
      ],
    );
  }
}

class ManufacturerBox extends StatelessWidget {
  final ManufacturerData manufacturerData;

  const ManufacturerBox(this.manufacturerData, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175.w,
      height: 150.h,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 10.h),
        child: GestureDetector(
          onTap: () {
            if (manufacturerData.id != null) {
              Get.toNamed(
                ProductListPage.routeName,
                parameters: ProductListScreenArguments(
                  id: manufacturerData.id!,
                  name: manufacturerData.name ?? '',
                  type: GetProductListBy.MANUFACTURER,
                ).toJson(),
              );
            }
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: AppImageLoader(
              imageUrl: manufacturerData.pictureModel?.imageUrl ?? 'http://',
              fit: BoxFit.cover, // BoxFit.cover == CenterCrop
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/home/manufacturers_response.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../global_widget/app_bar_widgets/custom_app_bar.dart';
import '../../global_widget/images_and_videos_widgets/app_image_loader.dart';
import '../product_list_page/argument/product_list_argument.dart';
import '../product_list_page/product_list_view.dart';
import 'all_manufacturers_controller.dart';

class AllManufacturersPage extends GetView<AllManufacturersController> {
  static const routeName = '/app/all-manufacturers-screen';

  const AllManufacturersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.arguments?.title ??
            ConstStrings.HOME_MANUFACTURER.translate,
      ),
      body: GetBuilder<AllManufacturersController>(
        builder: (controller) {
          return ScreenStatusWidgets(
            controller: controller,
            isEmpty: controller.manufacturerList.isNullOrEmpty,
            onRetry: controller.fetchManufacturers,
            dataWidget: GridView.builder(
              padding: SharedStyle.singleChildScrollViewHorizontalPadding.add(
                EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
              itemBuilder: (context, index) {
                return ManufacturerBox(controller.manufacturerList[index]);
              },
              itemCount: controller.manufacturerList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    (MediaQuery.of(context).size.width / 175).round(),
                childAspectRatio: 1.25,
                // mainAxisExtent: 150,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              scrollDirection: Axis.vertical,
            ),
          );
        },
      ),
    );
  }
}

class ManufacturerBox extends StatelessWidget {
  final ManufacturerData manufacturerData;

  const ManufacturerBox(this.manufacturerData, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: 16,
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
        child: AppImageLoader(
          imageUrl: manufacturerData.pictureModel?.imageUrl ?? 'http://',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

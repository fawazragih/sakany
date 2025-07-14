import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import '../../global_widget/screen_status_widgets.dart';
import 'categories_controller.dart';
import 'widgets/side_cats_builder.dart';
import 'widgets/sub_side_cats_builder.dart';

class AllCategoriesPage extends GetView<AllCategoriesController> {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // logger.d(controller.sideSubCat.length);
    // controller.fetchCats();
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.categories.tr.capitalizeFirst,
      ),
      body: GetBuilder<AllCategoriesController>(
        builder: (controller) {
          return ScreenStatusWidgets(
            controller: controller,
            padding: SharedStyle.singleChildScrollViewHorizontalPadding
                .add(EdgeInsets.only(top: 16)),
            isEmpty: controller.categoriesTree.isNullOrEmpty,
            dataWidget: Obx(() {
              controller.selectedSidCat.value;
              return !controller.showWithSubDesign
                  ? SubSideCatsBuilder(
                      onLeaveCatTap: controller.onCatTap,
                      sideSubCatsList: controller.categoriesTree ?? [],
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SideCatsBuilder(
                            selectedSidCatId:
                                controller.selectedSidCat.value?.categoryId,
                            sideCats: controller.categoriesTree ?? [],
                            onSelectedSideCatChange: (cat) =>
                                controller.selectedSidCat.value = cat,
                          ),
                        ),
                        UiHelper.horizontalSpaceMedium,
                        Expanded(
                          flex: 2,
                          child: SubSideCatsBuilder(
                            onLeaveCatTap: controller.onCatTap,
                            sideSubCatsList: controller
                                    .selectedSidCat.value?.subCategories ??
                                [],
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.5,
                            ),
                          ).marginOnly(top: 8.0.h),
                        ),
                      ],
                    );
            }),
          );
        },
      ),
    );
  }
}

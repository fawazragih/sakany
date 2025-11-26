import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/product_list/product_list_response.dart';
import 'package:tamoily/app/data/models/product_summary.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/horizontal_list_builder.dart';
import 'package:tamoily/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/global_widget/pagination_list_builder.dart';
import 'package:tamoily/app/global_widget/shimmer_list.dart';
import 'package:tamoily/app/modules/home_page/widgets/product_box/horizontal_product_template.dart';
import 'package:tamoily/app/routes/app_routs_and_pages.dart';
import '../../global_widget/screen_status_widgets.dart';
import 'product_list_controller.dart';
import 'widgets/filter_and_sort_widget.dart';

class ProductListPage extends StatelessWidget {
  static const String routeName = '/app/product-list/:cat_id';

  static String navTo(String catID) => '${routeName.removeParams}/$catID';

  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListController>(
      global: false,
      init: ProductListController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: controller.arguments?.name,showCartIcon:controller.arguments?.name=='عقارات'||controller.arguments?.name=='أراضي'?false:true ,),
          body: ScreenStatusWidgets(
            controller: controller,
            isEmpty: false,
            padding: SharedStyle.singleChildScrollViewHorizontalPadding,
            dataWidget: RefreshIndicator(
              onRefresh: () async => controller.pagingController.refresh(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: UiHelper.verticalSpaceLarge),
                  SliverToBoxAdapter(
                    child: Obx(() {
                      controller.doneLoading.value;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //region banner image
                          if (controller.showBannerImage)
                            AppImageLoader(
                              imageUrl: controller.productListData?.pictureModel
                                      ?.imageUrl ??
                                  '',
                              height: 0.2.sh,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ).marginOnly(bottom: 12.0),
                          //endregion

                          //region filter and sort
                          if (controller.hasFilterOption ||
                              controller.hasSortOption)
                            FilterAndSearchWidget(
                              hasFilterOption: controller.hasFilterOption,
                              openFilterOptions: controller.openFilterOptions,
                              hasSortOption: controller.hasSortOption,
                              openSortOptions: controller.openSortOptions,
                            ),
                          //endregion

                          //region openSubcategories
                          UiHelper.verticalSpaceSmall,
                          if (controller.hasSubcategories)
                            HorizontalListBuilder<SubCategory>(
                              itemCount: controller
                                  .productListData?.subCategories?.length,
                              items: controller.productListData?.subCategories,
                              widget: (item) => AppCard(
                           
                                onTap: () => controller.onSubProductTap(item),
                                margin: EdgeInsetsDirectional.symmetric(
                                    horizontal: 4.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                borderColor: Theme.of(context).primaryColorDark,
                                radius: 16.0,
                                child: Text(
                                  item.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      .withBoldFont,
                                ),
                              ),
                            ),
                          //endregion
                        ],
                      );
                    }),
                  ),
                  SliverGridPaginationListBuilder<ProductSummary>(
                    pagingController: controller.pagingController,
                    pageProgressIndicatorBuilder: AppReadyShimmerList(
                      inGrid: true,
                      horizontal: false,
                      imageHeight: 180.0.h,
                      containerWidth: double.infinity,
                      itemCount: 12,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1.0.sh > 1.0.sw
                            ? (1.0.sh / 1.0.sw).round()
                            : (1.0.sw / 1.0.sh).round(),
                        childAspectRatio: 0.73,
                        // mainAxisExtent: AppConstants.productBoxHeight,
                      ),
                    ),
                    itemBuilder: (ProductSummary item, int index) {
                      return HorizontalProductTemplate(item);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1.0.sh > 1.0.sw
                          ? (1.0.sh / 1.0.sw).round()
                          : (1.0.sw / 1.0.sh).round(),
                      childAspectRatio: 0.73,
                      // mainAxisExtent: AppConstants.productBoxHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

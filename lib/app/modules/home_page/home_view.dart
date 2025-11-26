import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/loading_progress_bar.dart';
import '../../global_widget/app_ui_helper/shared_style.dart';
import '../../global_widget/app_ui_helper/ui_helpers.dart';
import 'home_controller.dart';
import 'widgets/best_seller_products_widget/best_seller_products_widget_view.dart';
import 'widgets/categories_with_products_widget/categories_with_products_widget_view.dart';
import 'widgets/featured_products_widget/featured_products_widget_view.dart';
import 'widgets/home_categories_widget/home_categories_widget_view.dart';
import 'widgets/home_custom_sliver_app.dart';
import 'widgets/manufacturer_slider_widget/manufacturer_slider_view.dart';

class HomePage extends GetView<HomeController> {
  static const String routeName = '/app/home_page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: GetBuilder<HomeController>(
          builder: (controller) {
            // logger.d(
            //     'showHomepageSlider=>${controller.appLandingData?.showHomepageSlider}');
            // logger.d(
            //     'showBestsellersOnHome=>${controller.appLandingData?.showBestsellersOnHome}');
            // logger.d(
            //     'showHomepageCategoryProducts=>${controller.appLandingData?.showHomepageCategoryProducts}');
            // logger.d(
            //     'showFeaturedProducts=>${controller.appLandingData?.showFeaturedProducts}');
            // logger.d(
            //     'showManufacturers=>${controller.appLandingData?.showManufacturers}');

            return controller.busy
                ? const Center(child: LoadingProgressBar())
                : CustomScrollView(
                    primary: true,
                    slivers: [
                      HomeCustomSliverApp(),

                      SliverPadding(
                        padding:
                            SharedStyle.singleChildScrollViewHorizontalPadding,
                        sliver: SliverToBoxAdapter(
                          child: HomeCategoriesWidget(),
                        ),
                      ),

                      SliverToBoxAdapter(child: UiHelper.verticalSpaceMedium),
                      //region Bestsellers
                      if (controller.appLandingData?.showBestsellersOnHome ==
                          true)
                        SliverPadding(
                          padding: SharedStyle
                              .singleChildScrollViewHorizontalPadding,
                          sliver: SliverToBoxAdapter(
                              child: BestSellerProductsWidget()
                              // .marginOnly(bottom: 16.0),
                              ),
                        ),
                      //endregion

                      //region Featured products
                      if (controller.appLandingData?.showFeaturedProducts ==
                          true)
                        // SliverPadding(
                        //   padding: SharedStyle
                        //       .singleChildScrollViewHorizontalPadding,
                        //   sliver:
                        //       SliverToBoxAdapter(child: FeaturedProductsWidget()
                        //           // .marginOnly(bottom: 16.0),
                        //           ),
                        // ),
                      //endregion

                      //region CategoriesWithProducts
                      if (controller
                              .appLandingData?.showHomepageCategoryProducts ==
                          true)
                        SliverPadding(
                          padding: SharedStyle
                              .singleChildScrollViewHorizontalPadding,
                          sliver: SliverToBoxAdapter(
                              child: CategoriesWithProductsWidget()
                              // .marginOnly(bottom: 16.0),
                              ),
                        ),
                      //endregion

                      // region Manufacturers slider
                      if (controller.appLandingData?.showManufacturers == true)
                        SliverPadding(
                          padding: SharedStyle
                              .singleChildScrollViewHorizontalPadding,
                          sliver: SliverToBoxAdapter(
                              child: ManufacturerSliderWidget()
                              // .marginOnly(bottom: 16.0),
                              ),
                        ),
                      //endregion

                      SliverToBoxAdapter(child: UiHelper.verticalSpaceMedium)
                    ],
                  );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Get.toNamed(
      //     LoginScreen.routeName,
      //   );
      // }),
    );
  }
}

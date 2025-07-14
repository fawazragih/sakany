import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/modules/home_page/widgets/product_box/horizontal_product_list.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/specification_attributes.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/populate_associated_products.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/screen_status_widgets.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/product_price_widget.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/product_availability_widget.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/full_description_widget.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/product_vendor_widget.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/rating_and_review_widget.dart';
import 'package:sakani_mobile_app/app/routes/app_routs_and_pages.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../utils/constants/app_constants.dart';
import 'products_details_controller.dart';
import 'widgets/bottom_navigation_buttons.dart';
import 'widgets/estimate_shipping_dialog_page/estimate_shipping_dialog_view.dart';
import 'widgets/get_tier_price_table_widget.dart';
import 'widgets/gift_cart_section_widget.dart';
import 'widgets/product_details_sliver_app_bar.dart';
import 'widgets/product_manufacturers_widget.dart';
import 'widgets/product_tags_widget.dart';
import 'widgets/rental_section_widget.dart';

class ProductsDetailsPage extends GetView<ProductsDetailsController> {
  static const String routeName = '/app/products_details_screen/:product_id';

  static String navToRoute(String id) => '${routeName.removeParams}/$id';

  const ProductsDetailsPage({super.key});

  onEstimateButtonTap() {
    var formValues = controller.attributeManager
        .getSelectedAttributes(AppConstants.productAttributePrefix);

    formValues.addAll(
      controller.getProductFormValues(
        controller.productDetails,
        controller.updateCart,
        controller.updateCartItemId,
      ),
    );

    Get.bottomSheet(
      EstimateShippingDialogView(
        estimateShipping: controller.productDetails!.productEstimateShipping!,
        estimationForProduct: true,
        preSelectedShippingMethod: controller.selectedShippingMethod,
        formValues: formValues,
      ),
      isScrollControlled: true,
    ).then((selectedMethod) {
      // logger.d(selectedMethod);
      if (selectedMethod != null && selectedMethod.toString().isNotEmpty) {
        controller.selectedShippingMethod = selectedMethod;
      }
    });
  }

  // @override
  // ProductsDetailsController get controller {
  //   if (!Get.isRegistered<ProductsDetailsController>()) {
  //     return Get.put(ProductsDetailsController());
  //   }
  //   return super.controller;
  // }

  @override
  Widget build(BuildContext context) {
    // var divider = Divider(color: Colors.grey[600]);
    // var titleStyle = Theme.of(Get.context!).textTheme.bodyMedium.withBoldFont;

    return GetBuilder<ProductsDetailsController>(
      builder: (controller) {
        return Scaffold(
          appBar: controller.showRetryButton
              ? CustomAppBar(
                  showCartIcon: false,
                  title: '',
                )
              : null,
          body: ScreenStatusWidgets(
            controller: controller,
            isEmpty: controller.productDetails == null,
            onRetry: controller.fetchProductDetails,
            dataWidget: controller.productDetails == null
                ? Offstage()
                : RefreshIndicator(
                    onRefresh: () async => controller.fetchProductDetails(),
                    child: CustomScrollView(
                      slivers: [
                        ProductDetailsSliverAppBar(
                          productDetails: controller.productDetails,
                          onAddToCart: () => controller.addToCartClick(
                            cartType: AppConstants.typeWishList,
                            redirectToCart: false,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UiHelper.verticalSpaceSmallMedium,
                                //region RatingAndReviewWidget
                                Row(
                                  children: [
                                    Spacer(),
                                    RatingAndReviewWidget(
                                      data: controller.productDetails,
                                    ),
                                  ],
                                ),
                                //endregion

                                //region name
                                Text(
                                  controller.productDetails?.name ?? '',
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyMedium
                                      ?.withBoldFont,
                                ).paddingOnly(bottom: 12.0.h),
                                //endregion

                                //region productPrice
                                if (controller.showPrice)
                                  ProductPriceWidget(
                                    productPrice: controller
                                        .productDetails!.productPrice!,
                                  ).paddingOnly(bottom: 12.0.h),
                                //endregion

                                //region customerEntersPrice manualPriceEntry
                                CustomerEntersPrice(
                                  productDetails: controller.productDetails,
                                ),
                                //endregion

                                //region CustomAttributes
                                if (controller.productDetails?.productAttributes
                                        .isNotNullOrEmpty ==
                                    true)
                                  controller.attributeManager
                                      .populateCustomAttributes(
                                        controller
                                            .productDetails?.productAttributes,
                                        Get.context!,
                                        disabledAttributeIds:
                                            controller.disabledAttributeIds,
                                      )
                                      .marginOnly(bottom: 16.h),
                                /*ProductCustomAttributes2(
                                // key: UniqueKey(),
                                attributePrefix:
                                    AppConstants.productAttributePrefix,
                                attributes: controller
                                    .productDetails?.productAttributes,
                                disabledAttributeIds:
                                    controller.disabledAttributeIds,
                                onClick:
                                    (priceAdjNeeded, getSelectedAttributes) {
                                  controller.postSelectedAttributes(
                                    controller.productId,
                                    getSelectedAttributes,
                                  );
                                },
                                // onFileSelected: (file, attributeId) {
                                //   if (file.path != null) {
                                //     controller.uploadFile(
                                //         file.path!, attributeId);
                                //   }
                                // },
                              ),*/
                                //endregion

                                //region GetTierPriceTableWidget
                                GetTierPriceTableWidget(),
                                //endregion

                                //region ProductAvailability,
                                ProductAvailabilityWidget(),
                                //endregion

                                //region btnEstimateShipping
                                if (controller.productDetails
                                        ?.productEstimateShipping?.enabled ==
                                    true)
                                  ActionButton(
                                    isOutLined: true,
                                    onPressed: onEstimateButtonTap,
                                    text: ConstStrings
                                        .CART_ESTIMATE_SHIPPING_BTN.translate,
                                  ).marginOnly(bottom: 16.h),
                                //endregion

                                //region SpecificationAttributes,
                                SpecificationAttributes(),
                                //endregion

                                //region fullDescription,
                                FullDescriptionWidget(
                                  fullDescription: controller
                                          .productDetails?.fullDescription ??
                                      controller
                                          .productDetails?.shortDescription,
                                ),
                                //endregion

                                //region AssociatedProducts
                                AssociatedProducts(),
                                //endregion

                                //region ProductTags
                                ProductTagsWidget(),
                                //endregion

                                //region productManufacturers,
                                ProductManufacturersAsTagsWidget(),
                                //endregion

                                //region productVendorW,
                                ProductVendorAsTagsWidget(),
                                //endregion

                                //region giftCartSection
                                GiftCartSectionWidget(),
                                //endregion

                                //region rentalSection,
                                RentalSectionWidget(),

                                //region relatedProductList
                                Obx(() {
                                  return controller
                                          .relatedProductList.isNullOrEmpty
                                      ? Offstage()
                                      : HorizontalProductList(
                                          title: ConstStrings
                                              .PRODUCT_RELATED_PRODUCT
                                              .translate,
                                          showSeeAllBtn: false,
                                          showSubcategories: false,
                                          subcategories: const [],
                                          productList:
                                              controller.relatedProductList,
                                        );
                                }),
                                //endregion

                                //region crossSellList
                                Obx(() {
                                  return controller.crossSellList.isNullOrEmpty
                                      ? Offstage()
                                      : HorizontalProductList(
                                          title: ConstStrings
                                              .PRODUCT_ALSO_PURCHASED.translate,
                                          showSeeAllBtn: false,
                                          showSubcategories: false,
                                          subcategories: const [],
                                          productList: controller.crossSellList,
                                        );
                                }),
                                //endregion
                              ]).paddingSymmetric(
                            horizontal: SharedStyle.horizontalScreenPadding,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          bottomNavigationBar: controller.busy || controller.showRetryButton
              ? null
              : BottomNavigationButtons(),
        );
      },
    );
  }
}

class TitleAndValueRow extends StatelessWidget {
  final String title;
  final String value;
  final double? placeHolderWidth;

  const TitleAndValueRow({
    super.key,
    required this.title,
    required this.value,
    this.placeHolderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton.replace(
      width: placeHolderWidth ?? double.infinity,
      height: 18.h,
      replacement: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title : ',
            style: Theme.of(Get.context!).textTheme.bodySmall.withBoldFont,
          ),
          Expanded(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}

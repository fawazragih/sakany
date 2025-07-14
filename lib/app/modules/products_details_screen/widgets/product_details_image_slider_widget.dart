import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/app_back_button.dart';
import 'package:sakani_mobile_app/app/global_widget/images_and_videos_widgets/image_slider_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import '../../../utils/constants/app_constants.dart';
import '../products_details_controller.dart';

class ProductDetailsImageSliderWidget
    extends GetWidget<ProductsDetailsController> {
  const ProductDetailsImageSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool showAddToCart =
        controller.productDetails?.addToCart?.disableBuyButton == false &&
            controller.productDetails?.productType != 10;
    return Stack(
      children: [
        ImageSliderWidget(
          viewportFraction: 1.0,
          showIndicators: false,
          indicatorsSize: 8.0,
          // aspectRatio: 1.09,
          // height:  0.5.sh,
          // height:  MediaQuery.of(context).size.height,
          height: double.infinity,
          fit: BoxFit.cover,
          autoPlayInterval: 15,
          // height: 0.5.sh,
          imageUrl: controller.productDetails?.pictureModels,
          getImageUrl: (e) => e.fullSizeImageUrl ?? '',
          onImageTap: (e) {
            //TODO byMe go to image viewer
            logger.d('TODO go to image viewer');
            // Navigator.pushNamed(
            //   context,
            //   ZoomableImageScreen.routeName,
            //   arguments: ZoomableImageScreenArguments(
            //     pictureModel: data.pictureModels,
            //     currentIndex: data.pictureModels?.indexOf(model),
            //   ),
            // );
          },
        ),
        if (controller.productDetails?.addToCart?.disableWishlistButton ==
            false)
          PositionedDirectional(
            bottom: 10,
            start: 10,
            child: AppCard(
              padding: EdgeInsets.all(4.0),
              radius: 20,
              onTap: () => controller.addToCartClick(cartType: AppConstants.typeWishList, redirectToCart: false),
              child: Icon(
                CupertinoIcons.heart,
                color: Theme.of(Get.context!).colorScheme.primary,
                size: 28,
              ),
            ),
          ),

        //region btnSampleDownload
        if (controller.showSampleDownloadBtn)
          PositionedDirectional(
            bottom: 10,
            end: 10,
            child: AppCard(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                CupertinoIcons.arrow_down_to_line_alt,
                color: Theme.of(Get.context!).colorScheme.primary,
                size: 28,
              ),
              onTap: () => controller.downloadSample(controller.productId),
            ),
          ),
        //endregion

        Positioned(
          top: 0,
          left: 12.w,
          right: 12.w,
          child: SafeArea(
            top: true,
            child: Row(
              children: [
                AppBackButton(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.zero,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  iconColor: Theme.of(context).primaryColorDark,
                ),
                Spacer(),
                if (showAddToCart)
                  AppCard(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.all(6),
                    borderColor: Theme.of(context).dividerColor,
                    color: Theme.of(context).colorScheme.secondary,
                    radius: 12,
                    onTap: () => controller.addToCartClick(
                      cartType: AppConstants.typeShoppingCart,
                      redirectToCart: false,
                    ),
                    child: Icon(
                      IconsaxPlusBroken.bag_2,
                      color: Theme.of(Get.context!).primaryColorDark,
                      size: 28,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

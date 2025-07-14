import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:sakani/app/data/models/product_details_response.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/customizable_space_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';

import '../../../global_widget/app_bar_widgets/app_back_button.dart';
import '../../../global_widget/my_card_design.dart';
import 'product_details_image_slider_widget.dart';

class ProductDetailsSliverAppBar extends StatelessWidget {
  final ProductDetails? productDetails;
  final VoidCallback onAddToCart;

  const ProductDetailsSliverAppBar(
      {super.key, required this.productDetails, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    bool showAddToCart = productDetails?.addToCart?.disableBuyButton == false &&
        productDetails?.productType != 10;
    return SliverAppBar(
      // expandedHeight: description.countAlphabets <= 45 ? 0.43.sh : 0.355.sh,
      expandedHeight: 0.40.sh,
      // toolbarHeight: 0.19.sh,
      toolbarHeight: UiHelper.appBarSize.height,
      pinned: true,
      floating: false,
      elevation: 0.5,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // leading:  AppBackButton(
      //     padding: EdgeInsets.all(6),
      //   backgroundColor: Theme.of(context).colorScheme.secondary,
      //   iconColor: Theme.of(context).primaryColorDark,
      // ),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        collapseMode: CollapseMode.parallax,
        centerTitle: true,
        // expandedTitleScale: 1,
        background: ProductDetailsImageSliderWidget(),
        title: CustomizableSpaceBar(
          builder: (context, scrollingRate) {
            // print(scrollingRate);
            return scrollingRate >= 1.0
                ? SafeArea(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      alignment: Alignment.center,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Row(
                        children: [
                          AppBackButton(
                            padding: EdgeInsets.all(6),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            iconColor: Theme.of(context).primaryColorDark,
                          ),
                          Spacer(),
                          if (showAddToCart)
                            AppCard(
                              padding: EdgeInsets.all(6),
                              borderColor: Theme.of(context).dividerColor,
                              color: Theme.of(context).colorScheme.secondary,
                              radius: 12,
                              onTap: onAddToCart,
                              child: Icon(
                                IconsaxPlusBroken.bag_2,
                                color: Theme.of(Get.context!).primaryColorDark,
                                size: 28,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : Offstage();
            // return _buildTitleContainer(context, scrollingRate);
          },
        ),
      ),
    );
  }
}

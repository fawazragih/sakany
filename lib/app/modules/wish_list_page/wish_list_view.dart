import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/wish_list_response.dart';
import 'package:sakani/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import 'widgets/wish_list_item_template.dart';
import 'wish_list_controller.dart';

class WishListPage extends GetView<WishListController> {
  static const String routeName = '/app/wish-list';

  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.ACCOUNT_WISHLIST.translate,
      ),
      body: GetBuilder<WishListController>(
        builder: (controller) {
          return controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchWishListData,
                )
              : SkeletonOfListView<WishListItem>(
                  padding:
                      SharedStyle.singleChildScrollViewHorizontalPadding.add(
                    EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  isLoading: controller.busy,
                  // isLoading: true,
                  showEmptyData: controller.data?.items?.isNullOrEmpty == true,
                  fakeObject: WishListItem.fake(),
                  realData: controller.data?.items,
                  itemBuilder: (item, index) {
                    return WishListItemTemplate(
                      item: item,
                      addToCart: () async {
                        if (item.id != null) {
                          controller.moveToCart([item.id!]);
                        }
                      },
                      onDeleteItem: () {
                        if (item.id != null) {
                          controller.removeItemFromWishlist(item.id!);
                        }
                      },
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: Obx(() {
        return controller.showAddAllToCartButton.value
            ? Padding(
                padding: SharedStyle.bottomNavigationPadding,
                child: ActionButton(
                  text: ConstStrings.WISHLIST_ADD_ALL_TO_CART.translate
                      .toUpperCase(),
                  onPressed: () {
                    // move all items from wishList to cart
                    // TODO: make sure of default values
                    controller.moveToCart(controller.data?.items
                            ?.map((e) => e.id ?? 0)
                            .toList() ??
                        []);
                  },
                ),
              )
            : Offstage();
      }),
    );
  }
}

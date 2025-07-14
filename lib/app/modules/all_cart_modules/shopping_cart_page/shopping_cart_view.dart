import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani/app/core/language_and_localization/app_strings.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';
import 'package:sakani/app/modules/all_cart_modules/shopping_cart_page/widgets/shopping_cart_bottom_widget.dart';

import 'shopping_cart_controller.dart';
import 'widgets/shopping_cart_data_widget.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  static const String routeName = '/app/shopping_cart_page';

  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.cart.tr.capitalizeFirst,
        showCartIcon: false,
        // showUserIcon: false,
      ),
      body: GetBuilder<ShoppingCartController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async => controller.fetchCartData(),
            child: ScreenStatusWidgets(
              controller: controller,
              isEmpty: controller.cartData?.cart?.items?.isNullOrEmpty == true,
              dataWidget: ShoppingCartDataWidget(
                controller: controller,
                cartData: controller.cartData,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<ShoppingCartController>(
        builder: (controller) {
          return controller.busy ||
                  controller.showRetryButton ||
                  controller.cartData?.cart?.items?.isNullOrEmpty == true
              ? Offstage()
              : ShoppingCartBottomWidget(
                  controller: controller,
                );
        },
      ),
    );
  }
}

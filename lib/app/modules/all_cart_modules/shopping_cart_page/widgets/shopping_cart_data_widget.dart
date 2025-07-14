import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/shopping_cart_response.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import '../shopping_cart_controller.dart';
import 'cart_list_item.dart';

class ShoppingCartDataWidget extends StatelessWidget {
  final ShoppingCartData? cartData;
  final ShoppingCartController controller;

  const ShoppingCartDataWidget({
    super.key,
    this.cartData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // primary: false,
      padding: SharedStyle.singleChildScrollViewHorizontalPadding
          .add(EdgeInsets.symmetric(
        vertical: 16.h,
      )),
      itemCount: cartData?.cart?.items?.length,
      itemBuilder: (context, index) {
        final cartItem = cartData?.cart?.items?[index];
        return CartListItem(
          item: cartItem,
          onUpdateQty: (v) => controller.updateItemQuantity(cartItem!, v),
          onDeleteItem: () => controller.removeItemFromCart(cartItem!.id ?? 0),
          editable: true,
          // onClick: (map) {
          //   if (cartItem != null) {
          //     switch (map['action']) {
          //       case 'plus':
          //         controller.updateItemQuantity(
          //             cartItem, (cartItem.quantity ?? 0) + 1);
          //         break;
          //
          //       case 'minus':
          //         controller.updateItemQuantity(
          //             cartItem, (cartItem.quantity ?? 1) - 1);
          //         break;
          //
          //       case 'setQuantity':
          //         controller.updateItemQuantity(
          //             cartItem, int.tryParse(map['quantity'] ?? '') ?? 0);
          //         break;
          //
          //       case 'remove':
          //         controller.removeItemFromCart(
          //             cartData?.cart?.items?[index].id ?? 0);
          //         break;
          //     }
          //   }
          // },
        ).marginOnly(bottom: 8.h);
      },
    );
  }
}

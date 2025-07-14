import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/modules/all_cart_modules/cart_helper/cart_init_and_check_helper.dart';

class CartIconButton extends StatelessWidget {
  final double? topMargin;
  final Color? color;
  final Color? borderColor;
  final Color? iconColor;
  final double? radius;
  final VoidCallback? onTap;

  const CartIconButton({
    super.key,
    this.topMargin,
    this.color,
    this.borderColor,
    this.radius,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int count = CartCheckAndInitHelper.instance.cartCount.value;
      // count = 2;
      // logger.w('cart count is =. $count');

      return Badge(
        label: Text(count.toString()),
        offset: Offset(1, 8),
        padding: EdgeInsets.zero,
        isLabelVisible: count > 0,
        alignment: AlignmentDirectional.topEnd,
        child: AppCard(
          // margin: EdgeInsets.symmetric(
          //   vertical: topMargin ?? 4.0.h,
          // ),
          withAlignment: false,
          color: color ?? Colors.transparent,
          borderWidth: 0.0,
          withShadow: false,
          hasBorder: borderColor != null,
          borderColor: borderColor,
          radius: radius,
          onTap: onTap,
          padding: EdgeInsets.all(12.0.w),
          child: Icon(
            IconsaxPlusLinear.bag_2,
            color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
            size: 24.r,
          ),
        ),
      );
    });
  }
}

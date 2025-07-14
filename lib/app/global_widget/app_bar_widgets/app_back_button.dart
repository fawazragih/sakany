import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';

class AppBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? iconData;
  final double? radius;
  final double? iconSize;

  final bool onlyIcon;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final dynamic resultOnBack;

  const AppBackButton({
    super.key,
    this.radius,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.resultOnBack,
    this.onlyIcon = true,
    this.margin,
    this.iconData,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    if (onlyIcon) {
      return Card(
        shape: CircleBorder(),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        elevation: 0.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 10),
          onTap: () => Get.back(result: resultOnBack),
          child: Icon(
            iconData ??
                (Directionality.of(context) == TextDirection.rtl
                    ? CupertinoIcons.arrow_right
                    : CupertinoIcons.arrow_left),
            size: iconSize ?? 24.sp,
            color: iconColor ?? Theme.of(context).appBarTheme.foregroundColor,
          ).paddingAll(5.0.r),
        ),
      );
    }
    return AppCard(
      withAlignment: false,
      onTap: () => Get.back(),
      radius: radius ?? 12,
      padding: padding ?? EdgeInsets.all(8.0),
      margin: margin ?? EdgeInsets.symmetric(vertical: 4),
      color: backgroundColor,
      borderColor: backgroundColor,
      child: Icon(
        iconData ??
            (Directionality.of(context) == TextDirection.rtl
                ? CupertinoIcons.arrow_right
                : CupertinoIcons.arrow_left),
        size: iconSize ?? 28.sp,
        color: iconColor ?? Theme.of(context).appBarTheme.foregroundColor,
      ),
    );

    return Card(
      margin: EdgeInsets.zero,
      shape: const CircleBorder(),
      color: Theme.of(context).primaryColorDark,
      child: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Directionality.of(context) == TextDirection.rtl
              ? CupertinoIcons.arrow_right
              : CupertinoIcons.arrow_left,
          size: 24.sp,
          color: iconColor ?? Theme.of(context).appBarTheme.foregroundColor,
        ).paddingAll(8.r),
      ),
    );

    // return Container(
    //   width: 40.w,
    //   height: 40.w,
    //   margin: EdgeInsets.zero,
    //   clipBehavior: Clip.antiAlias,
    //   padding: padding ??
    //       const EdgeInsets.all(
    //         4.0,
    //       ),
    //   decoration: BoxDecoration(
    //     color: backgroundColor ?? Theme.of(context).colorScheme.primary,
    //     shape: shape,
    //     borderRadius: shape == BoxShape.circle
    //         ? null
    //         : BorderRadius.circular(radius ?? 10),
    //   ),
    //   child: InkWell(
    //     onTap: () => Get.back(),
    //     borderRadius: BorderRadius.circular(100),
    //     child: RotatedBox(
    //       quarterTurns: 2,
    //       child: Icon(
    //         Directionality.of(context) == TextDirection.rtl
    //             ? AppIcons.arrowBack
    //             : AppIcons.arrow,
    //         size: 14.sp,
    //         color: iconColor ?? Theme.of(context).primaryColorDark,
    //       ),
    //     ),
    //   ),
    // );
  }
}

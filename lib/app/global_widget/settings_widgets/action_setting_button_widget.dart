import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../app_ui_helper/shared_style.dart';

class ActionSettingButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final bool iconFirst;
  final bool showArrowIcon;

  // final bool arrowIconFirst;
  final String? text;
  final MainAxisAlignment mainAxisAlignment;

  const ActionSettingButtonWidget({
    super.key,
    this.onTap,
    this.icon,
    this.text,
    this.borderColor,
    this.iconColor,
    this.iconFirst = true,
    // this.arrowIconFirst = false,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.showArrowIcon = true,
    this.textColor,
  });

  bool get showIconAtStart {
    return iconFirst && icon != null;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
          fixedSize:
              WidgetStateProperty.all<Size>(Size(double.infinity, 50.0.h)),
          backgroundColor: WidgetStateProperty.all<Color>(
            Get.theme.scaffoldBackgroundColor,
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: SharedStyle.contentCardBorderRadius,
              side: BorderSide(
                color: borderColor ?? Get.theme.colorScheme.surfaceTint,
              ),
            ),
          ),
          elevation: WidgetStateProperty.all<double>(0)),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (showIconAtStart)
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.secondary,
            ),
          Expanded(
            child: Text(
              text ?? AppStrings.logOut.tr.capitalizeFirst!,
              style: SharedStyle.subtitle2(
                bold: true,
                fontSizeWithSp: 14.0.sp,
                color: textColor,
              ),
              // textAlign: !showArrowIcon ? TextAlign.center : null,
            ).paddingSymmetric(
              horizontal: 16.0,
            ),
          ),
          if (!showIconAtStart && !showArrowIcon)
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.secondary,
            ),
          if (showArrowIcon)
            Icon(
              CupertinoIcons.forward,
              color: iconColor ?? Theme.of(context).colorScheme.secondary,
            ),
        ],
      ),
    );
  }
}

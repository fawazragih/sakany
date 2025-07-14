import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/language_and_localization/app_strings.dart';
import 'app_ui_helper/ui_helpers.dart';

class ListTitleAndViewAllRow extends StatelessWidget {
  final String title;
  final String? viewAllText;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onViewAll;

  // final Color? closeIconBgColor;
  // final VoidCallback? onClose;
  final bool showDivider;

  final bool showOverflow;
  final VoidCallback? onOverflowTap;

  final Color? titleColor;

  const ListTitleAndViewAllRow({
    super.key,
    required this.title,
    this.onViewAll,
    this.padding,
    this.titleColor,
    // this.onClose,
    this.viewAllText,
    this.showDivider = false,
    this.showOverflow = false,
    // this.closeIconBgColor,
    this.onOverflowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.withBoldFont
          ),
          if (showDivider)
            Expanded(
              child: const Divider(
                indent: 30,
                height: 0,
              ).marginOnly(
                top: 4.0,
              ),
            ),
          Spacer(),
          if (showOverflow && onOverflowTap != null)
            InkWell(
              onTap: onOverflowTap,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8.0,
                  end: 8.0,
                  top: 4.0,
                  bottom: 4.0,
                ),
                // child: const Icon(Icons.more_vert),
                child: Icon(
                  Icons.more_vert,
                  size: Theme.of(context).textTheme.bodySmall?.fontSize,
                  // size: 14.0.w,
                ),
              ),
            ),
          if (onViewAll != null)
            InkWell(
              onTap: onViewAll,
              borderRadius: BorderRadius.circular(8.0.h),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8.0,
                  end: 8.0,
                  top: 4.0,
                  bottom: 4.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Text(
                      viewAllText ?? AppStrings.viewAll.tr.capitalizeFirst!,
                      style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    UiHelper.horizontalSpaceTiny,
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: Get.textTheme.bodySmall?.fontSize,
                      // size: 14.0.w,
                    ),
                  ],
                ),
              ),
            ),

          // if (onClose != null)
          // AppIconButton(
          //   onTap: onClose!,
          //   leadingIconData: Icons.close,
          //   bgColor: closeIconBgColor ?? Get.theme.dividerColor,
          //   textColor: Get.theme.primaryColor,
          // )
        ],
      ),
    );
  }
}

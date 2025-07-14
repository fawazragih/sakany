// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
//
// import 'app_ui_helper/ui_helpers.dart';
//
// class AppIconAndTitleButton extends StatelessWidget {
//   final Color? bgColor;
//   final Color? borderColor;
//   final Color? textColor;
//   final IconData? leadingIconData;
//   final IconData? trailIconData;
//   // final bool? iconData;
//   final double? iconSize;
//   final EdgeInsetsGeometry? contentPadding;
//   final EdgeInsetsGeometry? margin;
//   final double? spaceBetweenIconAndText;
//   final VoidCallback onTap;
//   final String? label;
//   final double? cornerRadius;
//   final double? cornerSmoothing;
//   final double? borderWidth;
//   final MainAxisAlignment? mainAxisAlignment;
//   final MainAxisSize mainAxisSize;
//
//   const AppIconAndTitleButton({
//     super.key,
//     this.bgColor,
//     this.borderColor,
//     this.leadingIconData,
//     required this.onTap,
//     this.label,
//     this.textColor,
//     this.iconSize,
//     this.spaceBetweenIconAndText,
//     this.contentPadding,
//     this.trailIconData,
//     this.mainAxisAlignment,
//     this.cornerRadius,
//     this.cornerSmoothing,
//     this.margin,
//     this.borderWidth,
//     this.mainAxisSize = MainAxisSize.max,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     bool isIconButton = label == null;
//
//     return AppCard(
//       margin: margin,
//       padding: contentPadding ??
//           EdgeInsets.symmetric(
//             vertical: context.isPhone ? 12.h : 8.h,
//             horizontal: 10.w,
//           ),
//       radius: cornerRadius ?? (context.isPhone ? 16.r : 10.r),
//       borderColor: borderColor,
//       borderWidth: borderWidth,
//       alignment: Alignment.center,
//       color: bgColor ?? Theme.of(context).colorScheme.primary,
//       onTap: onTap,
//       child: isIconButton
//           ? Icon(
//               leadingIconData,
//               color: textColor ?? Theme.of(context).dividerColor,
//               size: iconSize ?? 24.r,
//             )
//           : Row(
//               mainAxisSize: mainAxisSize,
//               mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
//               children: [
//                 if (leadingIconData != null) ...[
//                   Icon(
//                     leadingIconData,
//                     size: iconSize,
//                     color: textColor ?? Colors.white,
//                   ),
//                   if (spaceBetweenIconAndText != null)
//                     UiHelper.horizontalSpace(
//                       spaceBetweenIconAndText!,
//                     ),
//                 ],
//                 AutoSizeText(
//                   label!,
//                   style: Get.textTheme.titleSmall?.copyWith(
//                     color: textColor ?? Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 if (trailIconData != null) ...[
//                   if (spaceBetweenIconAndText != null)
//                     UiHelper.horizontalSpace(
//                       spaceBetweenIconAndText!,
//                     ),
//                   Icon(
//                     trailIconData,
//                     size: iconSize,
//                     color: textColor ?? Colors.white,
//                   ),
//                 ] else
//                   UiHelper.horizontalSpaceSmall,
//               ],
//             ),
//     );
//   }
// }

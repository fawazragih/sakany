// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../core/app_icons/app_icons.dart';
// import '../core/language_and_localization/app_strings.dart';
// import 'all_form_widgets/date_picker_widget.dart';
// import 'app_ui_helper/ui_helpers.dart';
// import 'searching_widgets/search_placeholder_widget.dart';
//
// class PhoneAppFilterWidgets extends StatelessWidget {
//   final VoidCallback onClearSearch;
//   final bool showRestFilterButton;
//   final String? label;
//   // final double? textInputWidth;
//   final VoidCallback onResetAllFilters;
//   final ValueChanged<DateTimeRange?>? onDateChange;
//   final AsyncValueSetter<String?> onSearchChange;
//
//   const PhoneAppFilterWidgets({
//     super.key,
//     required this.onClearSearch,
//     required this.onSearchChange,
//     required this.onResetAllFilters,
//     this.label,
//     this.onDateChange,
//     required this.showRestFilterButton,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         if (label != null)
//           Expanded(
//             child: AutoSizeText(
//               label!,
//               style: Get.textTheme.titleLarge
//                   ?.copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//
//         // const Spacer(),
//
//         ///..SearchBarPlaceHolder
//         SearchBarPlaceHolder(
//           enableSearch: true,
//           // textInputWidth: 0.6.sw,
//           onClearSearch: onClearSearch,
//           onSearchChange: onSearchChange,
//           color: Get.theme.primaryColor,
//           // borderColor: Get.theme.colorScheme.primary.withOpacity(0.2),
//         ),
//
//         ///..DateRangePickerFormWidget
//         if (onDateChange != null) ...[
//           UiHelper.horizontalSpaceMedium,
//           DateRangePickerFormAsCircularButton(
//             keyName: '',
//             onChange: onDateChange,
//             fillColor: Get.theme.primaryColor,
//             prefixIcon: Icon(
//               AppIcons.date,
//               size: 22.r,
//               color: Theme.of(context)
//                   .textTheme
//                   .bodySmall
//                   ?.color
//                   ?.withOpacity(0.4),
//             ),
//             contentPadding: EdgeInsets.zero,
//             minIconConstraint: 55.r,
//             hintText: AppStrings.filterWithDateRange.tr.capitalizeFirst!,
//           ),
//         ],
//
//         ///..ResetAllFilters
//         if (showRestFilterButton) ...[
//           UiHelper.horizontalSpaceMedium,
//           Tooltip(
//             message: AppStrings.resetOfAllFilters.tr.capitalizeFirst!,
//             showDuration: Duration.zero,
//             child: Card(
//               elevation: 1.0,
//               shape: const CircleBorder(),
//               child: InkWell(
//                 onTap: onResetAllFilters,
//                 child: Icon(
//                   Icons.filter_alt_off,
//                   size: 32.sp,
//                 ).paddingAll(8.0),
//               ),
//             ),
//           )
//         ]
//       ],
//     );
//   }
// }
//
// class TabletAppFilterWidgets extends StatelessWidget {
//   final VoidCallback onClearSearch;
//   final bool showRestFilterButton;
//   final String? label;
//   final VoidCallback onResetAllFilters;
//   final ValueChanged<DateTimeRange?>? onDateChange;
//   final AsyncValueSetter<String?> onSearchChange;
//
//   const TabletAppFilterWidgets({
//     super.key,
//     required this.onClearSearch,
//     required this.onSearchChange,
//     required this.onResetAllFilters,
//     this.label,
//     this.onDateChange,
//     required this.showRestFilterButton,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         if (label != null)
//           Expanded(
//             child: AutoSizeText(
//               label!,
//               style: Get.textTheme.titleLarge
//                   ?.copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//         // CustomCardIconButton(
//         //   onTap: () {},
//         //   // label: AppStrings.resetFilter.tr.capitalizeFirst!,
//         //   iconData: Icons.refresh_sharp,
//         //   bgColor: Get.theme.primaryColorDark,
//         //   // borderColor: borderColor,
//         //   // textColor: textColor,
//         // ),
//         const Spacer(),
//
//         ///..SearchBarPlaceHolder
//         SearchBarPlaceHolder(
//           enableSearch: true,
//           // textInputWidth: 500.w,
//           onClearSearch: onClearSearch,
//           onSearchChange: onSearchChange,
//           color: Get.theme.primaryColor,
//           // borderColor: Get.theme.colorScheme.primary.withOpacity(0.2),
//         ),
//
//         ///..DateRangePickerFormWidget
//         if (onDateChange != null) ...[
//           UiHelper.horizontalSpaceMedium,
//           SizedBox(
//             width: 300.w,
//             // flex: 1,
//             child: DateRangePickerFormWidget(
//               keyName: '',
//               onChange: onDateChange,
//               fillColor: Get.theme.primaryColor,
//               prefixIcon: Icon(
//                 AppIcons.date,
//                 size: 22.r,
//                 color: Theme.of(context)
//                     .textTheme
//                     .bodySmall
//                     ?.color
//                     ?.withOpacity(0.4),
//               ),
//               contentPadding: EdgeInsets.zero,
//               minIconConstraint: 55.r,
//               hintText: AppStrings.filterWithDateRange.tr.capitalizeFirst!,
//             ),
//           ),
//         ],
//
//         ///..ResetAllFilters
//         if (showRestFilterButton) ...[
//           UiHelper.horizontalSpaceMedium,
//           Tooltip(
//             message: AppStrings.resetOfAllFilters.tr.capitalizeFirst!,
//             showDuration: Duration.zero,
//             child: Card(
//               elevation: 1.0,
//               shape: const CircleBorder(),
//               child: InkWell(
//                 onTap: onResetAllFilters,
//                 child: Icon(
//                   Icons.filter_alt_off,
//                   size: 32.sp,
//                 ).paddingAll(8.0),
//               ),
//             ),
//           )
//         ]
//       ],
//     );
//   }
// }

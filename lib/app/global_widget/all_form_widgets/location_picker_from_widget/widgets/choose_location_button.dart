// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ChooseLocationButton extends StatelessWidget {
//   const ChooseLocationButton({
//     super.key,
//     this.btnController,
//     required this.onTap,
//     required this.text,
//     this.bgColor,
//     this.showIcon = true,
//   });
//
//   final VoidCallback onTap;
//   final String text;
//   final bool showIcon;
//   final Color? bgColor;
//   // final RoundedLoadingButtonController? btnController;
//
//   @override
//   Widget build(BuildContext context) {
//     return ActionButton(
//       btnController: btnController,
//       backgroundColor: bgColor,
//       height: 60,
//       childWidget: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (showIcon) ...[
//             const Icon(
//               Icons.my_location,
//             ),
//             UiHelper.horizontalSpaceSmall,
//           ],
//           Text(
//             text,
//             style: Get.textTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: Get.theme.scaffoldBackgroundColor,
//             ),
//           ),
//         ],
//       ),
//       onPressed: onTap,
//     );
//   }
// }

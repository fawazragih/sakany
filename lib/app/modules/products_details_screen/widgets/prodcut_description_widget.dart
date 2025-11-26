// import 'package:app_extensions/app_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tamoily/app/core/language_and_localization/app_strings.dart';
// import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
//
// import '../../../data/models/product_model.dart';
//
// class ProductDescriptionWidget extends StatelessWidget {
//   final Product? productDetails;
//
//   const ProductDescriptionWidget({
//     super.key,
//     required this.productDetails,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Text(
//           AppStrings.description.tr.capitalizeFirst!,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//         ),
//         UiHelper.horizontalSpaceSmall,
//         // ...productDetails?.detail?.productDetails
//         //         ?.map((e) => Text.rich(
//         //               TextSpan(
//         //                 text: e.name ?? '',
//         //                 children: [
//         //                   const TextSpan(text: ' : '),
//         //                   TextSpan(text: e.value ?? ''),
//         //                 ],
//         //               ),
//         //             ))
//         //         .toList() ??
//         //     [],
//       ].withSpaceBetween(
//         height: 4.0,
//       ),
//     );
//   }
// }

// import 'package:app_extensions/app_extensions.dart';
// import 'package:auto_direction/auto_direction.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:tamoily/app/data/models/product_summary.dart';
// import 'package:tamoily/app/global_widget/images_and_videos_widgets/adutils_image_loader.dart';
// import 'package:tamoily/app/global_widget/my_card_design.dart';
// import '../../../../global_widget/app_ui_helper/ui_helpers.dart';
// import '../../../../global_widget/global_price_widget.dart';
//
// class ProductGridItemWidget extends StatelessWidget {
//   final int index;
//   final ProductSummary product;
//   final VoidCallback? onTap;
//   final VoidCallback? onAddToCart;
//
//   const ProductGridItemWidget({
//     super.key,
//     required this.product,
//     this.onTap,
//     this.onAddToCart,
//     required this.index,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AppCard(
//       padding: EdgeInsets.zero,
//       onTap: onTap,
//       radius: 8.0,
//       color: Theme.of(context).primaryColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Expanded(
//             child: AppImageLoader.network(
//               product.defaultPictureModel?.imageUrl ?? '',
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               UiHelper.verticalSpaceSmall,
//               AutoDirection(
//                 text: product.name ?? '',
//                 child: AutoSizeText(
//                   product.name ?? '',
//                   maxLines: 2,
//                   softWrap: true,
//                   wrapWords: false,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodySmall
//                       ?.copyWith(height: 1.5),
//                   overflow: TextOverflow.ellipsis,
//                 ).paddingDirection(start: 4.0, bottom: 2.0),
//               ),
//               GlobalPriceWidget(
//                   // salePrice: product.getRealSalePrice,
//                   // oldPriceAmount: product.getRealOldPrice,
//                   // discountPercent: product.getRealDiscountUnit,
//                   ),
//             ],
//           ),
//           // AddToCartButtons(
//           //   product: product,
//           // ),
//         ],
//       ),
//     );
//   }
// }

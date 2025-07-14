// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sakani/app/global_widget/empty_data_widget.dart';
// import 'package:sakani/app/modules/all_cart_modules/add_to_cart_bottome_sheet/bottom_sheet_add_to_cart.dart';
// import '../../../data/models/product_model.dart';
// import '../../../global_widget/pagination_list_builder.dart';
// import '../../../utils/refresh_data_listener.dart';
// import 'products_pagination_widget_controller.dart';
// import 'widgets/product_list_shimmer.dart';
// import 'widgets/product_template.dart';
//
// class ProductsPaginationWidget extends StatelessWidget {
//   final int? maxItems;
//   final VoidCallback? onViewAllTap;
//   final EdgeInsets? padding;
//   final ValueSetter<RefreshProductsDataListener>? exposeRefreshDataListener;
//
//   // final bool inGrid;
//
//   const ProductsPaginationWidget({
//     super.key,
//     this.maxItems,
//     this.onViewAllTap,
//     this.padding,
//     // this.inGrid = true,
//     this.exposeRefreshDataListener,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductsPaginationWidgetController>(
//       init: ProductsPaginationWidgetController(
//         maxItems,
//         exposeRefreshDataListener,
//       ),
//       global: false,
//       builder: (controller) {
//         return GridPaginationListBuilder<Product>(
//           pagingController: controller.pagingController,
//           // inHorizontal: true,
//           // showNoMoreWidget: true,
//           emptyDataWidget: EmptyDataWidget(imageHeigh: 0.2.sh),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12.0,
//             crossAxisSpacing: 8.0,
//             childAspectRatio: 0.6,
//           ),
//           pageProgressIndicatorBuilder: const ProductsShimmerList(
//             inGrid: true,
//             horizontal: false,
//             imageHeight: 120,
//             containerWidth: double.infinity,
//             itemCount: 12,
//           ),
//           itemBuilder: (item, index) {
//             // if (controller.showViewAllButton) {
//             //   return ActionButton(
//             //     isOutLined: true,
//             //     borderColor: Theme
//             //         .of(context)
//             //         .colorScheme
//             //         .primary,
//             //     backgroundColor: Colors.transparent,
//             //     text: AppStrings.viewAll.tr.capitalizeFirst,
//             //     onPressed: onViewAllTap,
//             //   );
//             // }
//             return ProductGridItemWidget(
//               product: item,
//               index: index,
//               onTap: () => controller.onProductTapped(item),
//               onAddToCart: () {
//                 Get.bottomSheet(
//                   AddToCartBottomSheet(product: item),
//                   useRootNavigator: true,
//                   settings: const RouteSettings(
//                     name: AddToCartBottomSheet.id,
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/foundation.dart';
// import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
// import 'package:sakani/app/data/models/filter_model.dart';
// import 'package:sakani/app/data/models/product_summary.dart';
//
// import '../../../base_controllers_and_listeners/pagination_logic_controller.dart';
// import '../../../utils/refresh_data_listener.dart';
// import 'repository/all_products_repository.dart';
//
// class ProductsPaginationWidgetController extends BaseController
//     with PaginationLogicController<ProductSummary>, RefreshProductsDataListener {
//   final AllProductsRepository _allProductsRepository = AllProductsRepository();
//
//   final int? maxItems;
//
//   // bool showViewAllButton = false;
//
//   ProductsPaginationWidgetController(
//     this.maxItems,
//     ValueSetter<RefreshProductsDataListener>? exposeRefreshDataListener,
//   ) {
//     exposeRefreshDataListener?.call(this);
//   }
//
//   ApiFilter? apiFilter;
//
//   @override
//   void onInit() {
//     super.onInit();
//     initPagingController();
//   }
//
//   @override
//   getData(int page) async {
//     return await _allProductsRepository.getMore(
//       // page: page,
//       // apiFilter: apiFilter,
//     );
//
//     /*if (maxItems == null ||
//         pagingController.itemList == null ||
//         pagingController.itemList!.length < maxItems!) {
//       logger.d(page);
//
//       if (page == 1) {
//         pagingController.itemList = null;
//       }
//
//       return _allProductsRepository.getMore(
//         page: page,
//         apiFilter: apiFilter,
//       );
//     } else {
//       // showViewAllButton = true;
//       return Future.value(
//         (
//           GeneralResponseModel(
//             data: <Product>[],
//             success: true,
//             hasMore: false,
//           ),
//           null
//         ),
//       );
//     }*/
//   }
//
//   @override
//   refreshData({ApiFilter? apiFilter}) async {
//     this.apiFilter = apiFilter;
//     pagingController.refresh();
//   }
//
//   @override
//   disposePaginationController() {
//     pagingController.dispose();
//   }
//
//   @override
//   void onClose() {
//     disposePaginationController();
//     super.onClose();
//   }
//
//   onAddToCart(ProductSummary item) {
//     toastMessage('TODO when have an api');
//   }
//
//   onProductTapped(ProductSummary item) {
//     // logger.d(item.toJson());
//     // var params = {
//     //   'goods_url_name': item.goodsUrlName ?? '',
//     //   // 'goods_url_name': 'SHEIN Mulvari Ladies Contrast Color Zipper Front Jacket And Pants Two Piece Set',
//     //   // 'cat_id': item.catId ?? '',
//     // }..removeWhere((key, value) => value.isNullOrEmpty);
//     //
//     // Get.toNamed(ProductsDetailsScreen.navToRoute(item.product!.goodsId!),
//       // ProductsDetailsScreen.navToRoute('1780', '27106292'),
//       // ProductsDetailsScreen.navToRoute('1780', '27295467'),
//       // parameters: params,
//     // );
//   }
// }

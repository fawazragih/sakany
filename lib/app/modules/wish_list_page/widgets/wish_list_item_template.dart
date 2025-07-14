import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/images_and_videos_widgets/app_image_loader.dart' show AppImageLoader;
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/arguments/product_details_screen_arguments.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../../data/models/wish_list_response.dart';

class WishListItemTemplate extends StatelessWidget {
  final WishListItem? item;
  final VoidCallback onDeleteItem;
  final VoidCallback addToCart;

  const WishListItemTemplate(
      {super.key,
      this.item,
      required this.onDeleteItem,
      required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      withAlignment: false,
      hasBorder: false,
      padding: EdgeInsets.zero,
      onTap: () {
        if (item?.productId != null) {
          Get.toNamed(
            ProductsDetailsPage.navToRoute(item!.productId.toString()),
            parameters: ProductDetailsScreenArguments(
              id: item?.productId ?? 0,
              name: item?.productName ?? '',
              updateCart: true,
              updateCartItemId: item?.id ?? 0,
            ).toJson(),
          );
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              AppImageLoader(
                imageUrl:item?.picture?.imageUrl ?? '',
                borderRadius: BorderRadius.circular(16),
                width: 110.w,
                height: 110.w,
                fit: BoxFit.cover,
              ),
              UiHelper.horizontalSpaceSmall,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiHelper.verticalSpaceSmall,
                    Text(
                      item?.productName ?? '',
                      style:
                          Theme.of(context).textTheme.labelMedium.withBoldFont,
                    ),

                    UiHelper.verticalSpaceTiny,
                    Text(
                      "${ConstStrings.QUANTITY.translate}: ${item?.quantity ?? 0}",
                      style:
                          Theme.of(context).textTheme.labelSmall.withBoldFont,
                    ),
                    UiHelper.verticalSpaceTiny,
                    Text(
                      "${ConstStrings.TOTAL.translate}: ${item?.subTotal}",
                      style:
                          Theme.of(context).textTheme.labelSmall.withBoldFont,
                    ),
                    UiHelper.verticalSpaceTiny,
                    Text(
                      "${ConstStrings.PRICE.translate}: ${item?.unitPrice}",
                      style:
                          Theme.of(context).textTheme.labelSmall.withBoldFont,
                    ),
                    if (item?.sku?.isNotEmpty == true) ...[
                      UiHelper.verticalSpaceTiny,
                      Text(
                        "${ConstStrings.SKU.translate}: ${item?.sku}",
                        style:
                            Theme.of(context).textTheme.labelSmall.withBoldFont,
                      ),
                    ],
                    //TODO find a way to show attribute info in cart list item
                    // if (item?.attributeInfo?.isNotNullOrEmpty == true) ...[
                    // UiHelper.verticalSpaceTiny,
                    // Html(
                    //   data: item?.attributeInfo ?? '',
                    //   style: htmlNoPaddingStyle(fontSize: 15.sp),
                    //   shrinkWrap: true,
                    // ),
                    // ],

                    UiHelper.verticalSpaceTiny,

                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //region delete and edit item buttons
                          // if (item.allowItemEditing)
                          Spacer(),
                          Card(
                            margin: EdgeInsets.zero,
                            color: Theme.of(context).colorScheme.secondary,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(16.0),
                              ),
                            ),
                            child: InkWell(
                              onTap: addToCart,
                              child: Icon(
                                CupertinoIcons.cart_badge_plus,
                                size: 20.0,
                              ).paddingSymmetric(
                                horizontal: 8.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          // VerticalContainerDivider(),

                          UiHelper.horizontalSpaceVeryTiny,

                          Card(
                            margin: EdgeInsets.zero,
                            color: Theme.of(context).colorScheme.secondary,
                            shape: const RoundedRectangleBorder(
                                // borderRadius: BorderRadiusDirectional.only(
                                //   topStart: Radius.circular(16.0),
                                // ),
                                ),
                            child: InkWell(
                              onTap: onDeleteItem,
                              child: const Icon(
                                CupertinoIcons.delete,
                                size: 20.0,
                              ).paddingSymmetric(
                                horizontal: 8.0,
                                vertical: 8.0,
                              ),
                            ),
                          ),
                          //endregion
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

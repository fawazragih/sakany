import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/helpers_methods.dart';
import 'package:sakani/app/core/language_and_localization/app_strings.dart';
import 'package:sakani/app/data/models/available_option.dart';
import 'package:sakani/app/data/models/shopping_cart_response.dart';
import 'package:sakani/app/global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/global_widget/images_and_videos_widgets/app_image_loader.dart' show AppImageLoader;
import 'package:sakani/app/global_widget/increment_and_decrement_buttons.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';
import 'package:sakani/app/global_widget/vertical_container_divider.dart';
import 'package:sakani/app/modules/products_details_screen/arguments/product_details_screen_arguments.dart';
import 'package:sakani/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

class CartListItem extends StatelessWidget {
  final AsyncValueSetterAndGetter<int, bool>? onUpdateQty;
  final AsyncValueGetter<bool>? onDeleteItem;
  final CartItem? item;

  // final Function(Map<String, String>)? onClick;
  final bool? editable;

  const CartListItem({
    super.key,
    this.item,
    // this.onClick,
    this.editable,
    this.onUpdateQty,
    this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    String warnings = '';
    if (item?.warnings?.isNotEmpty == true) {
      item?.warnings?.forEach((element) {
        warnings = ('$warnings$element\n');
      });
      warnings.trimRight();
    }

    return AppCard(
      withAlignment: false,
      hasBorder: false,
      padding: EdgeInsets.zero,
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
                    /*if (item?.attributeInfo?.isNotNullOrEmpty == true) ...[
                      // UiHelper.verticalSpaceTiny,
                      // Html(
                      //   data: item?.attributeInfo ?? '',
                      //   style: htmlNoPaddingStyle(fontSize: 15.sp),
                      //   shrinkWrap: true,
                      // ),
                    ],*/
                    UiHelper.verticalSpaceTiny,

                    //region warnings
                    if (warnings.isNotNullOrEmpty)
                      Text(
                        warnings,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    //endregion

                    if ((editable == true))
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //region quantity buttons
                          if (item?.allowedQuantities.isNullOrEmpty == true)
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    '${ConstStrings.QUANTITY.translate}:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        .withBoldFont,
                                  ),
                                  UiHelper.horizontalSpaceSmall,
                                  if (onUpdateQty != null) ...[
                                    Flexible(
                                      flex: 2,
                                      child: IncrementAndDecrementButtons(
                                        key: Key(
                                            '${item?.productId}-${item?.quantity}'),
                                        qty: item?.quantity ?? 0,
                                        onDecrement: onUpdateQty!,
                                        onIncrement: onUpdateQty!,
                                        iconBgColor:
                                            Theme.of(context).primaryColorDark,
                                        iconColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        iconSize: 22.0,
                                        circularIcons: false,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        iconPadding: EdgeInsets.all(0),
                                        textContentPadding:
                                            EdgeInsets.symmetric(
                                          vertical: 14.h,
                                          horizontal: 6.w,
                                        ),
                                        loadingProgressSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                  ] else
                                    Text(
                                      '${item?.quantity ?? 0}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          .withBoldFont,
                                    ),
                                ],
                              ),
                            ),
                          //endregion

                          //region allowedQuantityDropdown
                          if (onUpdateQty != null &&
                              item?.allowedQuantities.isNotNullOrEmpty == true)
                            Flexible(
                              child: AppDropDownMenuFormFieldWidget<
                                  AvailableOption?>(
                                keyName: 'keyName',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 5.h,
                                ),
                                hintText: AppStrings
                                    .selectQuantity.tr.capitalizeFirst,
                                isFill: false,
                                // inputBorder: InputBorder.none,
                                inputBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.0),
                                  ),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    width: 1.0,
                                  ),
                                ),
                                getItemName: (e) => e?.text ?? '',
                                onChanged: (value) {
                                  if (value != null) {
                                    onUpdateQty!.call(
                                        int.tryParse(value.value ?? '') ?? 0);
                                  }
                                  // if (onClick != null) {
                                  //   onClick!({
                                  //     'action': 'setQuantity',
                                  //     'quantity': value?.value ?? ''
                                  //   });
                                  // }
                                },
                                initialValue:
                                    item?.allowedQuantities?.firstWhereOrNull(
                                          (element) =>
                                              element.selected ?? false,
                                        ) ??
                                        item?.allowedQuantities?.firstOrNull,
                                itemsList:
                                    item?.allowedQuantities ?? List.empty(),
                              ).paddingDirection(
                                end: 8.w,
                              ),
                            ),
                          //endregion

                          //region delete and edit item buttons
                          // if (item.allowItemEditing)
                          Card(
                            margin: EdgeInsets.zero,
                            color: Theme.of(context).colorScheme.secondary,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(16.0),
                              ),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  //region item edit from shopping cart
                                  if (item?.allowItemEditing == true) ...[
                                    InkWell(
                                      onTap: () {
                                        if (item?.productId != null) {
                                          Get.toNamed(
                                            ProductsDetailsPage.navToRoute(
                                                item!.productId.toString()),
                                            parameters:
                                                ProductDetailsScreenArguments(
                                              id: item?.productId ?? 0,
                                              name: item?.productName ?? '',
                                              updateCart: true,
                                              updateCartItemId: item?.id ?? 0,
                                            ).toJson(),
                                          );
                                        }
                                      },
                                      child: Icon(
                                        CupertinoIcons.pencil,
                                        size: 20.0,
                                      ).paddingSymmetric(
                                        horizontal: 8.0,
                                        vertical: 8.0,
                                      ),
                                    ),
                                    VerticalContainerDivider()
                                  ],
                                  //endregion

                                  //region delete item from cart
                                  if (onDeleteItem != null)
                                    InkWell(
                                      // onTap: () {
                                      //   if (onClick != null) {
                                      //     onClick!({'action': 'remove'});
                                      //   }
                                      // },
                                      onTap: onDeleteItem,
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        size: 20.0,
                                      ).paddingSymmetric(
                                        horizontal: 8.0,
                                        vertical: 8.0,
                                      ),
                                    ),
                                  //endregion
                                ],
                              ),
                            ),
                          ),
                          //endregion
                        ],
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

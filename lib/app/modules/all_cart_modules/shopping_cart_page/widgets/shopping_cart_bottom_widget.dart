import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamoily/app/data/models/shopping_cart_response.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/horizontal_list_builder.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

import '../shopping_cart_controller.dart';
import 'order_total_table.dart';

class ShoppingCartBottomWidget extends StatelessWidget {
  final ShoppingCartController controller;

  const ShoppingCartBottomWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    ShoppingCartData? cartData = controller.cartData;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SharedStyle.horizontalScreenPadding,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(24.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).dividerColor,
              blurRadius: 8.0,
              // spreadRadius: 50.0,
              blurStyle: BlurStyle.normal,
              offset: Offset(0.0, -1.0),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          controller.attributeManager.populateCustomAttributes(
            cartData?.cart?.checkoutAttributes,
            context,
          ),

          //region couponCodeBox
          if (cartData?.cart?.discountBox?.display ?? false) ...[
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: InputTextFieldWidget(
                    keyName: ConstStrings.ENTER_YOUR_COUPON,
                    keyboardType: TextInputType.text,
                    autoFocus: false,
                    onChanged: (value) => controller.enteredCouponCode = value,
                    textInputAction: TextInputAction.next,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    hintText: ConstStrings.ENTER_YOUR_COUPON.translate,
                  ),
                ),
                UiHelper.horizontalSpaceTiny,
                Expanded(
                  child: ActionButton(
                    padding: 16.h,
                    onPressed: () {
                      context.removeFocusFromInputField;
                      if (controller.enteredCouponCode?.isNotEmpty ?? false) {
                        controller.applyDiscountCoupon(
                            controller.enteredCouponCode ?? '');
                      }
                    },
                    childWidget: Text(
                      ConstStrings.APPLY_COUPON.translate.toUpperCase(),
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          .withBoldFont
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                )
              ],
            ),
            if (cartData?.cart?.discountBox?.appliedDiscountsWithCodes
                    ?.isNotNullOrEmpty ==
                true)
              HorizontalListBuilder(
                  items: cartData?.cart?.discountBox?.appliedDiscountsWithCodes,
                  itemCount: cartData
                      ?.cart?.discountBox?.appliedDiscountsWithCodes?.length,
                  widget: (item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Chip(
                        label: Text(ConstStrings.ENTERED_COUPON_CODE
                            .getStringWithNumber(
                                int.tryParse(item.couponCode ?? '') ?? 0)),
                        deleteIcon: const Icon(Icons.cancel_rounded),
                        deleteIconColor: Colors.red,
                        onDeleted: () => controller.removeDiscountCoupon(item),
                      ),
                    );
                  }),
          ],
          //endregion

          //region giftCardBox
          if (cartData?.cart?.giftCardBox?.display ?? false) ...[
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: InputTextFieldWidget(
                    keyName: ConstStrings.ENTER_GIFT_CARD,
                    hintText: ConstStrings.ENTER_GIFT_CARD.translate,
                    keyboardType: TextInputType.text,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    autoFocus: false,
                    onChanged: (value) {
                      controller.enteredGiftCardCode = value;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                UiHelper.horizontalSpaceTiny,
                Expanded(
                  child: ActionButton(
                    padding: 16.h,
                    childWidget: Text(
                      ConstStrings.ADD_GIFT_CARD.translate,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          .withBoldFont
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    onPressed: () {
                      context.removeFocusFromInputField;
                      if (controller.enteredGiftCardCode?.isNotNullOrEmpty ??
                          false) {
                        controller
                            .applyGiftCard(controller.enteredGiftCardCode!);
                      }
                    },
                    // padding: 16,
                  ),
                )
              ],
            ),
            if (cartData?.orderTotals?.giftCards?.isNotNullOrEmpty == true)
              HorizontalListBuilder(
                  items: cartData?.orderTotals?.giftCards,
                  itemCount: cartData?.orderTotals?.giftCards?.length,
                  widget: (item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Chip(
                        label: Text(
                          ConstStrings.ENTERED_COUPON_CODE.getStringWithNumber(
                              int.tryParse(item.couponCode ?? '') ?? 0),
                        ),
                        deleteIcon: const Icon(Icons.cancel_rounded),
                        deleteIconColor: Colors.red,
                        onDeleted: () => controller.removeGiftCard(item),
                      ),
                    );
                  }),
          ],
          //endregion

          if (cartData?.cart?.giftCardBox?.display == true ||
              cartData?.cart?.discountBox?.display == true)
            UiHelper.verticalSpaceSmall,

          //region estimateShippingBox
          if (cartData?.estimateShipping?.enabled == true)
            ActionButton(
              padding: 16.h,
              isOutLined: true,
              onPressed: controller.showEstimateShippingDialog,
              childWidget: Text(
                ConstStrings.CART_ESTIMATE_SHIPPING_BTN.translate.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium.withBoldFont,
              ),
            ),
          //endregion

          //region orderTotalTable
          OrderTotalTable(orderTotals: cartData?.orderTotals),
          //endregion

          //region warningMsg
          if (controller.warningMsg.isNotEmpty)
            Text(
              controller.warningMsg,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  .withBoldFont
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          //endregion

          if (controller.warningMsg.isEmpty &&
              controller.cartData?.cart?.hideCheckoutButton != true)
            ActionButton(
              text: ConstStrings.CHECKOUT.translate.toUpperCase(),
              onPressed: controller.onCheckoutTap,
            ),
        ],
      ),
    );
  }
}

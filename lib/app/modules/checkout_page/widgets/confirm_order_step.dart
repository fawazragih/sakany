import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/get_billing_address_response.dart';
import 'package:sakani/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/modules/all_cart_modules/shopping_cart_page/widgets/cart_list_item.dart';
import 'package:sakani/app/modules/all_cart_modules/shopping_cart_page/widgets/order_total_table.dart';
import 'package:sakani/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:sakani/app/modules/products_details_screen/widgets/full_description_widget.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import '../../../global_widget/my_card_design.dart';

class ConfirmOrderStep extends StatelessWidget with CheckoutSharedMixin {
  const ConfirmOrderStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiHelper.verticalSpaceMedium,

            //region billingAddressCard
            if (confirmModel?.cart?.orderReviewData?.display ?? false)
              AppCard(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 8.0.h,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 6.0.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_pin),
                    UiHelper.horizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.BILLING_ADDRESS_TAB.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                .withBoldFont,
                          ),
                          Text(
                              confirmModel?.cart?.orderReviewData
                                      ?.billingAddress.getFormattedAddress ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    height: 1.3,
                                  )
                              // .withBoldFont,
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            //endregion

            //region shippingAddressCard
            if ((confirmModel?.cart?.orderReviewData?.display ?? false) &&
                (confirmModel?.cart?.orderReviewData?.isShippable ?? false) &&
                !(confirmModel?.cart?.orderReviewData?.selectedPickupInStore ??
                    false))
              AppCard(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 8.0.h,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 6.0.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_pin),
                    UiHelper.horizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.SHIPPING_ADDRESS_TAB.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                .withBoldFont,
                          ),
                          Text(
                              confirmModel?.cart?.orderReviewData
                                      ?.shippingAddress.getFormattedAddress ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    height: 1.3,
                                  )
                              // .withBoldFont,
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            //endregion

            //region storeAddressCard
            if ((confirmModel?.cart?.orderReviewData?.display ?? false) &&
                (confirmModel?.cart?.orderReviewData?.selectedPickupInStore ??
                    false))
              AppCard(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 8.0.h,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 6.0.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.pin_drop),
                    UiHelper.horizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.PICK_UP_POINT_ADDRESS.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                .withBoldFont,
                          ),
                          Text(
                              confirmModel?.cart?.orderReviewData?.pickupAddress
                                      .getFormattedAddress ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    height: 1.3,
                                  )
                              // .withBoldFont,
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            //endregion

            //region shippingMethodCard
            if (confirmModel?.cart?.orderReviewData?.display ?? false)
              AppCard(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 8.0.h,
                ),
                radius: 12.0.r,
                margin: EdgeInsets.symmetric(
                  vertical: 6.0.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.local_shipping),
                    UiHelper.horizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.SHIPPING_METHOD.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                .withBoldFont,
                          ),
                          Text(
                              confirmModel
                                      ?.cart?.orderReviewData?.shippingMethod ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    height: 1.3,
                                  )
                              // .withBoldFont,
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            //endregion

            //region paymentMethodCard
            if (confirmModel?.cart?.orderReviewData?.display ?? false)
              AppCard(
                radius: 12.0.r,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 8.0.h,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 6.0.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.payment_outlined),
                    UiHelper.horizontalSpaceSmall,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.PAYMENT_METHOD.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                .withBoldFont,
                          ),
                          Text(
                              confirmModel
                                      ?.cart?.orderReviewData?.paymentMethod ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    height: 1.3,
                                  )
                              // .withBoldFont,
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            //endregion

            //region selectedAttributes
            if (confirmModel?.selectedCheckoutAttributes?.isNotEmpty ?? false)
              AppCard(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0.w,
                  vertical: 8.0.h,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 6.0.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ConstStrings.SELECTED_ATTRIBUTES.translate,
                      style:
                          Theme.of(context).textTheme.labelSmall.withBoldFont,
                    ),
                    Html(
                      data: confirmModel?.selectedCheckoutAttributes ?? '',
                      style: htmlNoPaddingStyle(),
                      onLinkTap: (url, context, element) {},
                    ),
                  ],
                ),
              ),
            //endregion

            //region cartItems
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: confirmModel?.cart?.items?.length ?? 0,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return CartListItem(
                  item: confirmModel?.cart?.items?[index],
                  editable: false,
                );
              },
            ),
            //endregion

            //region orderTotal
            UiHelper.verticalSpaceSmallMedium,
            AppCard(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0.w,
                vertical: 8.0.h,
              ),
              child: OrderTotalTable(
                orderTotals: confirmModel?.orderTotals,
              ),
            ),
            //endregion

            //region warningMsg
            UiHelper.verticalSpaceSmall,
            if (checkoutController.warningMsg.isNotNullOrEmpty)
              Text(
                checkoutController.warningMsg ?? '',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.withBoldFont
                    ?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            //endregion

            UiHelper.verticalSpaceMedium,
          ],
        ),
      ),
      bottomNavigationBar: (confirmModel?.cart?.hideCheckoutButton != true)
          ? ActionButton(
              text: ConstStrings.CONFIRM_BUTTON.translate.toUpperCase(),
              onPressed: checkoutController.confirmOrder,
            ).paddingSymmetric(
              horizontal: SharedStyle.horizontalScreenPadding,
              vertical: 12.0,
            )
          : null,
    );
  }
}

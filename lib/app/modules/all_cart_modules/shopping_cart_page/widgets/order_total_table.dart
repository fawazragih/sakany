import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/shopping_cart_response.dart';
import 'package:sakani_mobile_app/app/global_widget/dashed_divider_widget.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

class OrderTotalTable extends StatelessWidget {
  final OrderTotals? orderTotals;

  const OrderTotalTable({super.key, this.orderTotals});

  @override
  Widget build(BuildContext context) {
    var rowNameStyle = Theme.of(context).textTheme.labelMedium;

    var rowValueStyle = Theme.of(context).textTheme.labelMedium.withBoldFont;

    const flexStart = 4;
    const flexEnd = 6;

    var inBetweenSpace = SizedBox(
      height: 3.h,
    );

    String? discountValue =
        orderTotals?.subTotalDiscount.isNotNullOrEmpty == true
            ? orderTotals?.subTotalDiscount
            : orderTotals?.orderTotalDiscount?.isNotNullOrEmpty == true
                ? orderTotals?.orderTotalDiscount
                : '';

    Widget dashDivider = Expanded(
      child: DashedDividerWidget(
        color: Theme.of(context).dividerColor,
        strokeWidth: 0.5,
        dashSpace: 3.w,
        dashWidth: 3.0.w,
        margin: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
      ),
    );

    return Column(
      children: [
        Row(
          children: [
            Text(
              ConstStrings.SUB_TOTAL.translate,
              style: rowNameStyle,
            ),
            dashDivider,
            Text(
              orderTotals?.subTotal ?? '',
              style: rowValueStyle,
              textAlign: TextAlign.end,
            ),
          ],
        ),
        inBetweenSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ConstStrings.SHIPPING.translate +
                  (orderTotals?.selectedShippingMethod?.isNotEmpty == true
                      ? ' (${orderTotals?.selectedShippingMethod})'
                      : ''),
              style: rowNameStyle,
            ),
            dashDivider,
            Text(
              orderTotals?.shipping?.isNotEmpty == true
                  ? orderTotals!.shipping!
                  : ConstStrings.CALCULATED_DURING_CHECKOUT.translate,
              style: rowValueStyle,
              textAlign: TextAlign.end,
            ),
          ],
        ),
        inBetweenSpace,
        if (discountValue?.isNotEmpty == true) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ConstStrings.DISCOUNT.translate,
                style: rowNameStyle,
              ),
              dashDivider,
              Text(
                discountValue ?? '',
                style: rowValueStyle,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          inBetweenSpace,
        ],
        if (orderTotals?.displayTax == true) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ConstStrings.TAX.translate,
                style: rowNameStyle,
              ),
              dashDivider,
              Text(
                orderTotals?.tax ?? '',
                style: rowValueStyle,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          inBetweenSpace,
        ],
        if (orderTotals?.displayTaxRates == true) ...[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: orderTotals?.taxRates?.length,
            itemBuilder: (context, index) {
              return Text(
                  "${ConstStrings.TAX.translate} ${orderTotals?.taxRates?[index].rate}%"
                  " -- ${orderTotals?.taxRates?[index].value}");
            },
          ),
          inBetweenSpace,
        ],
        if (orderTotals?.giftCards?.isNotEmpty ?? false) ...[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: orderTotals?.giftCards?.length,
            itemBuilder: (context, index) {
              final textPart1 =
                  '${ConstStrings.GIFT_CARD.translate} (${orderTotals?.giftCards?[index].couponCode})';
              //TODO:make sure of remaining default value
              final textPart2 = orderTotals?.giftCards?[index].remaining != null
                  ? '\n${ConstStrings.GIFT_CARD_REMAINING.getStringWithNumberStr(orderTotals?.giftCards?[index].remaining ?? '')}'
                  : '';
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$textPart1$textPart2',
                    style: rowNameStyle,
                  ),
                  dashDivider,
                  Text(
                    orderTotals?.giftCards?[index].amount ?? '',
                    style: rowValueStyle,
                    textAlign: TextAlign.end,
                  ),
                ],
              );
            },
          ),
          inBetweenSpace,
        ],
        if ((orderTotals?.redeemedRewardPoints ?? 0) > 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ConstStrings.ORDER_REWARD_POINTS.getStringWithNumber(
                    orderTotals?.redeemedRewardPoints?.toInt() ?? 0),
                style: rowNameStyle,
              ),
              dashDivider,
              Text(
                orderTotals?.redeemedRewardPointsAmount ?? '',
                style: rowValueStyle,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          inBetweenSpace,
        ],
        if (orderTotals?.paymentMethodAdditionalFee != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ConstStrings.PAYMENT_FEE.translate,
                style: rowNameStyle,
              ),
              dashDivider,
              Text(
                orderTotals?.paymentMethodAdditionalFee ?? '',
                style: rowValueStyle,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          inBetweenSpace,
        ],
        if (orderTotals?.willEarnRewardPoints != null &&
            orderTotals?.willEarnRewardPoints != 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ConstStrings.WILL_EARN.translate,
                style: rowNameStyle,
              ),
              dashDivider,
              Text(
                ConstStrings.POINTS.getStringWithNumber(
                  orderTotals?.willEarnRewardPoints?.toInt() ?? 0,
                ),
                style: rowValueStyle,
                textAlign: TextAlign.end,
              ),
            ],
          ),
          inBetweenSpace,
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ConstStrings.TOTAL.translate,
              style: rowNameStyle,
            ),
            dashDivider,
            Text(
              orderTotals?.orderTotal?.isNotEmpty == true
                  ? orderTotals!.orderTotal!
                  : ConstStrings.CALCULATED_DURING_CHECKOUT.translate,
              style: rowValueStyle,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    ).marginSymmetric(
      vertical: 8.h,
    );
  }
}

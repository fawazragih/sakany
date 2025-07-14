import 'package:flutter/material.dart';
import 'package:sakani/app/data/models/product_summary.dart';

class GlobalPriceWidget extends StatelessWidget {
  final String? title;
  final TextStyle? textStyle;
  final TextStyle? oldPriceTextStyle;
  final TextAlign? textAlign;
  final ProductSummaryPrice? salePrice;
  final ProductSummaryPrice? oldPriceAmount;
  final String? discountPercent;

  const GlobalPriceWidget({
    super.key,
    this.textStyle,
    this.textAlign,
    this.oldPriceTextStyle,
    this.salePrice,
    this.oldPriceAmount,
    this.title,
    this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {

    return Container();
   /* String oldPriceToShow = oldPriceAmount?.amount ?? '0.0';
    String? currencyToShow = oldPriceAmount?.currency;
    String currentPriceToShow = salePrice?.amount ?? '0.0';
    String? currentCurrencyToShow = salePrice?.currency;

    late Widget widget;

    if (oldPriceAmount != null) {
      widget = Text.rich(
        TextSpan(
            text:
                '$currencyToShow $oldPriceToShow',
            style: textStyle?.copyWith(
                  decoration: TextDecoration.lineThrough,
                ) ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
            children: [
              TextSpan(
                text: '  ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextSpan(
                text:
                    '$currentCurrencyToShow $currentPriceToShow',
                style: textStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
              )
            ]),
        textAlign: textAlign,
      ).paddingSymmetric(
        horizontal: 12.0,
        vertical: 8.0,
      );
    } else {
      widget = Text(
        // price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 1)
        '$currentPriceToShow $currentCurrencyToShow ',
        style: textStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
        textAlign: textAlign,
        textDirection: TextDirection.ltr,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null && title!.isNotEmpty)
          Flexible(
            child: Text(
              title!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        Flexible(child: widget),
        if (discountPercent != null)
          Card(
            color: Colors.amber,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              16.0,
            )),
            margin: EdgeInsets.zero,
            child: Text(
              discountPercent == null ? '' : '${discountPercent?.toString()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.1,
                  ),
            ).paddingSymmetric(
              horizontal: 4.0,
              vertical: 2.0,
            ),
          )
      ],
    );*/
  }
}

// class PriceWidget extends StatelessWidget {
//   final Price? salePrice;
//   final Price? oldPrice;
//
//   final String? unitPrice;
//
//   const PriceWidget(
//       {super.key, this.salePrice, this.oldPrice, this.unitPrice,});
//
//   @override
//   Widget build(BuildContext context) {
//     Text.rich(
//         TextSpan(
//             text:
//         )
//     );
//     return Text(
//       // price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 1)
//       // '${HelpersMethods.formatNumbersWithSeparators(currentPriceToShow)} $currentCurrencyToShow ',
//       style: textStyle ?? Theme
//           .of(context)
//           .textTheme
//           .bodyMedium,
//       textAlign: textAlign,
//       textDirection: TextDirection.ltr,
//     );
//   }
// }

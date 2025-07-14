import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../../data/models/product_details_response.dart';

class ProductPriceWidget extends StatelessWidget{
  final ProductPrice productPrice;

  const ProductPriceWidget({
    super.key,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    // if not group product
    var priceText = '';
    if (productPrice.callForPrice == true) {
      priceText = ConstStrings.PRODUCT_CALL_FOR_PRICE.translate;
    } else if (productPrice.isRental == true) {
      priceText = productPrice.rentalPrice ?? '';
    } else {
      priceText = productPrice.priceWithDiscount ?? productPrice.price ?? '';
    }

    var oldPriceText = '';

    if (productPrice.priceWithDiscount != null && productPrice.price != null) {
      oldPriceText = productPrice.price ?? '';
    } else if (productPrice.priceWithDiscount == null &&
        productPrice.oldPrice != null) {
      oldPriceText = productPrice.oldPrice ?? '';
    }

    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: priceText,
          style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.error,
              ),
        ),
        const TextSpan(text: '   '),
        TextSpan(
          text: oldPriceText,
          style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).disabledColor.withOpacity(0.8),
                decoration: TextDecoration.lineThrough,
              ),
        ),
      ]),
    );
  }
}

class CustomerEntersPrice extends StatelessWidget {

  final   ProductDetails? productDetails;
  const CustomerEntersPrice({super.key, this.productDetails});

  @override
  Widget build(BuildContext context) {
    //TODO extract max and min number to make validation
    // String? input = controller.productDetails?.addToCart?.customerEnteredPriceRange;
    // String input = "The price is 123.45 dollars and 67.89 cents 375٫00";
    // input.replaceAll('٫', '.');
    // logger.d(input?.extractNumbers());

    if (productDetails?.addToCart?.customerEntersPrice == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.enterYourCustomPrice.tr,
            style: Theme.of(context).textTheme.bodySmall.withBoldFont,
          ),
          UiHelper.verticalSpaceMedium,
          TextFormField(
            keyboardType: const TextInputType.numberWithOptions(
              signed: false,
              decimal: true,
            ),
            autofocus: false,
            decoration: InputDecoration(
              labelText:productDetails?.addToCart?.customerEnteredPriceRange,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                // return _globalService.getStringWithNumberStr(ConstStrings.IS_REQUIRED, '');
                return ConstStrings.IS_REQUIRED.getStringWithNumberStr('');
              }
              return null;
            },
            onChanged: (value) =>productDetails?.addToCart
                ?.customerEnteredPrice = num.tryParse(value) ?? 0,
            initialValue: productDetails?.addToCart?.customerEnteredPrice
                    .toString() ??
                '0',
            textInputAction: TextInputAction.done,
          ),
        ],
      );
    }

    return Offstage();
  }
}

extension NumberExtractor on String {
  List<double> extractNumbers() {
    // Regular expression to match both Arabic and English numbers (including decimals and thousands separators)
    RegExp regExp = RegExp(
        r'(\d{1,3}(,\d{3})*(\.\d+)?|\u0660-\u0669+(٫[\u0660-\u0669]+)?)');

    // Find all matches in the input string
    Iterable<Match> matches = regExp.allMatches(this);

    // Extract numbers and convert them to double
    return matches
        .map((match) {
          String number = match.group(0)!;

          // Handle English numerals with thousands separators
          if (RegExp(r'^\d{1,3}(,\d{3})*(\.\d+)?$').hasMatch(number)) {
            // Remove thousands separators and parse the number
            String standardNumber = number.replaceAll(',', '');
            return double.parse(standardNumber);
          }
          // Handle Arabic numerals
          else if (RegExp(r'^[\u0660-\u0669]+(٫[\u0660-\u0669]+)?$')
              .hasMatch(number)) {
            // Convert Arabic numeral string to standard numeral string
            String standardNumber = number
                .replaceAll('\u0660', '0')
                .replaceAll('\u0661', '1')
                .replaceAll('\u0662', '2')
                .replaceAll('\u0663', '3')
                .replaceAll('\u0664', '4')
                .replaceAll('\u0665', '5')
                .replaceAll('\u0666', '6')
                .replaceAll('\u0667', '7')
                .replaceAll('\u0668', '8')
                .replaceAll('\u0669', '9')
                .replaceAll(
                    '٫', '.'); // Replace Arabic decimal separator with the dot

            return double.parse(standardNumber);
          }

          return null; // Return null for non-matching cases
        })
        .whereType<double>()
        .toList(); // Filter out nulls
  }
}

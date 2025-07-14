import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';
import 'package:sakani/app/modules/products_details_screen/products_details_controller.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:sakani/app/utils/nop_custom_attribute_manager/validation_mixin.dart';

import '../../../data/models/product_details_response.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';

class GiftCartSectionWidget extends GetWidget<ProductsDetailsController>
    with ValidationMixin {
  // final String title;

  const GiftCartSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final GlobalService globalService = GlobalService();

    if (controller.productDetails?.giftCard?.isGiftCard == true) {
      final ProductDetails data = controller.productDetails!;

      final GlobalKey<FormState> formKey = controller.giftCardFormKey;

      return AppCard(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ConstStrings.GIFT_CARD.translate,
              style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
            ),
            UiHelper.verticalSpaceSmallMedium,
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ConstStrings.PRODUCT_GIFT_CARD_SENDER.translate;
                      }
                      return null;
                    },
                    onChanged: (value) => data.giftCard?.senderName = value,
                    initialValue: data.giftCard?.senderName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      // labelText: ConstStrings.PRODUCT_GIFT_CARD_SENDER.translate,
                      hintText: ConstStrings.PRODUCT_GIFT_CARD_SENDER.translate,
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // decoration: inputDecor(ConstStrings.PRODUCT_GIFT_CARD_SENDER, true, context),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ConstStrings
                            .PRODUCT_GIFT_CARD_SENDER_EMAIL.translate;
                      }
                      return null;
                    },
                    onChanged: (value) => data.giftCard?.senderEmail = value,
                    initialValue: data.giftCard?.senderEmail,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      // labelText: ConstStrings.PRODUCT_GIFT_CARD_SENDER_EMAIL.translate,
                      hintText:
                          ConstStrings.PRODUCT_GIFT_CARD_SENDER_EMAIL.translate,
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // decoration: inputDecor(
                    //     ConstStrings.PRODUCT_GIFT_CARD_SENDER_EMAIL.translate,
                    //     true,
                    //     context),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ConstStrings
                            .PRODUCT_GIFT_CARD_RECIPIENT.translate;
                      }
                      return null;
                    },
                    onChanged: (value) => data.giftCard?.recipientName = value,
                    initialValue: data.giftCard?.recipientName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      // labelText: ConstStrings.PRODUCT_GIFT_CARD_RECIPIENT.translate,
                      hintText:
                          ConstStrings.PRODUCT_GIFT_CARD_RECIPIENT.translate,
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // decoration: inputDecor(
                    //     ConstStrings.PRODUCT_GIFT_CARD_RECIPIENT.translate,
                    //     true,
                    //     context),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ConstStrings
                            .PRODUCT_GIFT_CARD_RECIPIENT_EMAIL.translate;
                      }
                      return null;
                    },
                    onChanged: (value) => data.giftCard?.recipientEmail = value,
                    initialValue: data.giftCard?.recipientEmail,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      // labelText: ConstStrings.PRODUCT_GIFT_CARD_RECIPIENT_EMAIL.translate,
                      hintText: ConstStrings
                          .PRODUCT_GIFT_CARD_RECIPIENT_EMAIL.translate,
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // decoration: inputDecor(
                    //     ConstStrings.PRODUCT_GIFT_CARD_RECIPIENT_EMAIL.translate,
                    //     true,
                    //     context),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    minLines: 1,
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ConstStrings.PRODUCT_GIFT_CARD_MESSAGE.translate;
                      }
                      return null;
                    },
                    onChanged: (value) => data.giftCard?.message = value,
                    initialValue: data.giftCard?.message,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      // labelText: ConstStrings.PRODUCT_GIFT_CARD_MESSAGE.translate,
                      hintText:
                          ConstStrings.PRODUCT_GIFT_CARD_MESSAGE.translate,
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    // decoration: inputDecor(
                    //   ConstStrings.PRODUCT_GIFT_CARD_MESSAGE.translate,
                    //   true,
                    //   context,
                    // ),
                  ),
                ].withSpaceBetween(height: 12.0),
              ),
            ),
          ],
        ).marginOnly(bottom: 16.h),
      );
    }
    return Offstage();
  }
}

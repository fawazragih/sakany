import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/increment_and_decrement_buttons.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_controller.dart';
import '../../../data/models/available_option.dart';
import '../../../utils/constants/const_strings.dart';

class QuantityBoxWidget extends GetWidget<ProductsDetailsController> {
  final bool showTitle;

  const QuantityBoxWidget({super.key, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    bool showDropDown = controller
            .productDetails?.addToCart?.allowedQuantities?.isNotNullOrEmpty ==
        true;

    if (showDropDown) {
      return AppDropDownMenuFormFieldWidget<AvailableOption>(
        keyName: 'keyName',
        itemsList:
            controller.productDetails!.addToCart?.allowedQuantities ?? [],
        initialValue: controller
            .productDetails!.addToCart?.allowedQuantities?.firstOrNull,
        labelText: ConstStrings.PRODUCT_QUANTITY.translate,
        getItemName: (item) => item.text ?? '',
        alignment: Alignment.center,
        onChanged: (value) => controller.selectedQuantity = value,
        inputBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorLight,
            ),
            borderRadius: BorderRadius.circular(12)),
      );
    }

    if (!showDropDown &&
        controller.productDetails?.productType != 10 &&
        (controller.productDetails?.displayBackInStockSubscription ?? false) ==
            false) {
      final data = controller.productDetails;

      return Row(
        children: [
          if (showTitle) ...[
            Flexible(
              flex: 1,
              child: Text(
                ConstStrings.PRODUCT_QUANTITY.translate,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            UiHelper.horizontalSpaceSmallMedium,
          ],
          Flexible(
            flex: 2,
            child: IncrementAndDecrementButtons(
              iconBgColor: Theme.of(context).colorScheme.primary,
              iconSize: 24.0,
              circularIcons: false,
              iconPadding: EdgeInsets.all(8),
              textContentPadding: EdgeInsets.symmetric(vertical: 14),
              qty: data?.addToCart?.enteredQuantity ?? 1,
              onDecrement: (value) async {
                if (controller.productDetails!.addToCart?.enteredQuantity !=
                        null &&
                    controller.productDetails!.addToCart!.enteredQuantity! <=
                        1) {
                  controller.buildInfoSnack(
                      msg: ConstStrings.PRODUCT_QUANTITY_POSITIVE.translate);
                  return false;
                } else {
                  if (data?.addToCart?.enteredQuantity != null) {
                    data?.addToCart!.enteredQuantity = value;
                    return true;
                  }
                }
                return false;
              },
              onIncrement: (value) async {
                if (data?.addToCart?.enteredQuantity != null) {
                  data?.addToCart?.enteredQuantity = value;
                  return true;
                }
                return false;
              },
            ),
          ),
        ],
      );
    }

    return Offstage();
  }
}

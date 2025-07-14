import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/product_summary.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';
import 'add_to_cart_controller.dart';

class AddToCartBottomSheet extends StatelessWidget {
  static const String id = '/AddToCartBottomSheet';
  final ProductSummary product;

  const AddToCartBottomSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.0),
      )),
      elevation: 0.0,
      color: Theme.of(context).primaryColor,
      child: GetBuilder<AddToCartBottomSheetController>(
        init: AddToCartBottomSheetController(product),
        builder: (controller) {
          return controller.busy
              ? SizedBox(
                  height: UiHelper.appBarSize.height,
                  child: UiHelper.horizontalSpaceSpinKitProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    size: 50,
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        bool showDelete = controller.qty.value == 0 &&
                            controller.initialValueOProduct != 0;
                        return ElevatedButton(
                          onPressed: () => controller.addToCart(),
                          style: TextButton.styleFrom(
                            backgroundColor: showDelete
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.primary,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: showDelete
                                  ? BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    )
                                  : BorderSide.none,
                            ),
                          ),
                          child: Text(
                            showDelete
                                ? AppStrings.removeFromCart.tr.capitalizeFirst!
                                : AppStrings.addToCart.tr.capitalizeFirst!,
                            style: Get.textTheme.titleSmall?.copyWith(
                              color: showDelete
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }),
                    ),
                    IconButton(
                      onPressed: () => controller.decrementQuantity(),
                      iconSize: 30,
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Obx(() {
                      return Text(
                        controller.qty.value.toString(),
                        style: Get.textTheme.titleSmall,
                        textScaleFactor: 1.2,
                      );
                    }),
                    IconButton(
                      onPressed: () => controller.incrementQuantity(),
                      iconSize: 30,
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                );
        },
      ).paddingSymmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
    );
  }
}

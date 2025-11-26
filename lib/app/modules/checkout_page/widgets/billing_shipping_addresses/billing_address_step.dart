import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/core/language_and_localization/app_strings.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/empty_data_widget.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import 'package:tamoily/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';

import '../../../../global_widget/all_form_widgets/check_box_form_field.dart';
import '../../../../global_widget/app_ui_helper/ui_helpers.dart';
import 'add_new_address_form.dart';
import 'user_address_template.dart';

class BillingAddressStep extends StatefulWidget {
  const BillingAddressStep({super.key});

  @override
  State<BillingAddressStep> createState() => _BillingAddressStepState();
}

class _BillingAddressStepState extends State<BillingAddressStep>
    with CheckoutSharedMixin {
  late CustomAttributeManager attributeManager;

  @override
  void initState() {
    super.initState();
    attributeManager = CustomAttributeManager(
      context: context,
      onClick: (priceAdjNeeded) {
        setState(() {
          // updating UI to show selected attribute values
        });
      },
    );
  }

  void onAddNewAddressTap() {
    if (billingData?.billingAddress?.billingNewAddress == null) {
      checkoutController.buildErrorSnackBar(
          msg:
              'billingData?.billingAddress?.billingNewAddress CAN NOT Be NULL');
      return;
    }
    Get.bottomSheet(
      NewAddressForm(
        formKey: checkoutController.formKey,
        bloc: checkoutController,
        attributeManager: attributeManager,
        formData: billingData!.billingAddress!.billingNewAddress!,
        onSubmit: () {
          // form validation
          if (checkoutController.formKey.currentState?.validate() ?? false) {
            checkoutController.formKey.currentState?.save();

            String errMsg = attributeManager.checkRequiredAttributes(
              billingData?.billingAddress?.billingNewAddress
                      ?.customAddressAttributes ??
                  [],
            );
            if (errMsg.isNotEmpty) {
              checkoutController.buildErrorSnackBar(msg: errMsg);
            } else {
              Get.close(1);
              checkoutController.saveBillingAddress(
                newAddress: true,
                address: billingData?.billingAddress?.billingNewAddress,
                formValue:
                    attributeManager.getSelectedAttributes('address_attribute'),
                // onDone: () => setState(() {}),
              );
            }
          }
        },
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UiHelper.verticalSpaceLarge,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ConstStrings.BILLING_ADDRESS_TAB.translate.capitalizeFirst!,
                  style: Theme.of(context).textTheme.labelLarge?.withBoldFont,
                ),
                const Spacer(),
                AppCard(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  radius: 16.r,
                  color: Theme.of(context).colorScheme.primary,
                  onTap: onAddNewAddressTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.addNew.translate,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary
                            // color: Get.theme.scaffoldBackgroundColor,
                            ),
                      ),
                      UiHelper.horizontalSpaceTiny,
                      Icon(
                        CupertinoIcons.add,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 16.0,
                      ),
                    ],
                  ),
                )
              ],
            ).paddingSymmetric(
              horizontal: 4.0,
            ),
            UiHelper.verticalSpaceLarge,
            Flexible(
              child: checkoutController.existingBillingAddress?.isNullOrEmpty ==
                      true
                  ? const EmptyDataWidget(
                      // showWithImage: true,
                      )
                  : ListView.builder(
                      itemCount:
                          checkoutController.existingBillingAddress?.length ??
                              0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var address =
                            checkoutController.existingBillingAddress![index];
                        return UserAddressTemplate(
                          address: address,
                          index: index,
                          isSelected:
                              checkoutController.selectedBillingAddress?.id ==
                                  address.id,
                          onDelete: () {},
                          onTap: () {
                            checkoutController.selectedBillingAddress = address;
                            setState(() {});
                            // controller.setSelected(address);
                            // onDataChange.call(
                            //   controller.selectedAddress,
                            // );
                          },
                        );
                      },
                    ),
            ),
            // UiHelper.verticalSpaceMedium,
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (billingData?.billingAddress?.shipToSameAddressAllowed == true)
            CheckBoxFormFieldWidget(
              keyName: ConstStrings.SHIP_TO_SAME_ADDRESS.translate,
              label: ConstStrings.SHIP_TO_SAME_ADDRESS.translate,
              initialValue: checkoutController.shipToSameAddress,
              contentPadding: EdgeInsets.zero,
              onChanged: (bool? isSelected) {
                checkoutController.shipToSameAddress = isSelected;
              },
            ),
          ActionButton(
            text: ConstStrings.CONTINUE.translate.toUpperCase(),
            onPressed: () {
              if ((checkoutController.selectedBillingAddress?.id ?? -1) != -1) {
                checkoutController.saveBillingAddress(newAddress: false);
              }
            },
          ),
        ],
      ).paddingSymmetric(
        horizontal: SharedStyle.horizontalScreenPadding,
        vertical: 12.0,
      ),
    );
  }
}

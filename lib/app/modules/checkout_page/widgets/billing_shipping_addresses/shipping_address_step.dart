import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/all_form_widgets/check_box_form_field.dart';
import 'package:sakani_mobile_app/app/global_widget/empty_data_widget.dart';
import 'package:sakani_mobile_app/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import 'package:sakani_mobile_app/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../global_widget/action_buttons/action_button.dart';
import '../../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../../global_widget/app_ui_helper/ui_helpers.dart';
import '../../../../global_widget/my_card_design.dart';
import 'add_new_address_form.dart';
import 'user_address_template.dart';

class ShippingAddressStep extends StatefulWidget {
  const ShippingAddressStep({super.key});

  @override
  State<ShippingAddressStep> createState() => _ShippingAddressStepState();
}

class _ShippingAddressStepState extends State<ShippingAddressStep>
    with CheckoutSharedMixin {
  late CustomAttributeManager attributeManager;

  @override
  void initState() {
    super.initState();

    // if (isBillingAddress == false) {
    checkoutController.existingShippingAddress = [
      ...shippingAddress?.existingAddresses ?? []
    ];

    checkoutController.storePickup = false;

    checkoutController.selectedShippingAddress =
        shippingAddress?.existingAddresses?.isNotEmpty == true
            ? shippingAddress?.existingAddresses?.first
            : null;

    checkoutController.pickupPointAddress = [
      ...shippingAddress?.pickupPointsModel?.pickupPoints ?? []
    ];
    checkoutController.selectedPickupAddress =
        shippingAddress?.pickupPointsModel?.pickupPoints?.isNotEmpty == true
            ? shippingAddress?.pickupPointsModel?.pickupPoints?.first
            : null;

    checkoutController.selectedCountry =
        shippingAddress?.shippingNewAddress?.availableCountries?.firstOrNull;
    // }

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
    Get.bottomSheet(
      NewAddressForm(
        formKey: checkoutController.formKey,
        bloc: checkoutController,
        attributeManager: attributeManager,
        formData: shippingAddress!.shippingNewAddress!,
        onSubmit: () {
          if (checkoutController.storePickup == false &&
              (checkoutController.selectedShippingAddress?.id ?? -1) == -1) {
            if (checkoutController.formKey.currentState?.validate() ?? false) {
              checkoutController.formKey.currentState?.save();

              String errMsg = attributeManager.checkRequiredAttributes(
                      shippingAddress
                              ?.shippingNewAddress?.customAddressAttributes ??
                          []) ??
                  '';
              if (errMsg.isNotEmpty) {
                checkoutController.buildErrorSnackBar(msg: errMsg);
              } else {
                checkoutController.saveShippingAddress(
                  isNewAddress: true,
                  address: shippingAddress?.shippingNewAddress,
                  formValue: attributeManager
                      .getSelectedAttributes('address_attribute'),
                );
              }
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
                  ConstStrings.SHIPPING_ADDRESS_TAB.translate.capitalizeFirst!,
                  style: Theme.of(context).textTheme.labelLarge?.withBoldFont,
                ),
                const Spacer(),
                if (checkoutController.storePickup == false)
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
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

            //region storePickup address
            if (checkoutController.storePickup == true)
              Flexible(
                child: checkoutController.pickupPointAddress?.isNullOrEmpty ==
                        true
                    ? const EmptyDataWidget()
                    : ListView.builder(
                        itemCount:
                            checkoutController.pickupPointAddress?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var pickupPoint =
                              checkoutController.pickupPointAddress![index];
                          bool isSelected =
                              checkoutController.selectedPickupAddress?.id ==
                                  pickupPoint.id;
                          return AppCard(
                            onTap: () {
                              setState(() {
                                checkoutController.selectedPickupAddress =
                                    pickupPoint;
                              });
                            },
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w,
                              vertical: 8.0.h,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? CupertinoIcons.check_mark_circled
                                      : CupertinoIcons.circle,
                                ),
                                UiHelper.horizontalSpaceSmall,
                                Text(
                                  '${pickupPoint.name ?? ''}, ${pickupPoint.address ?? ''}, ${pickupPoint.city ?? ''} ${pickupPoint.countryName ?? ''}'
                                      .trim(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              )
            //endregion
            else
              Flexible(
                child:
                    checkoutController.existingShippingAddress?.isNullOrEmpty ==
                            true
                        ? const EmptyDataWidget(
                            // showWithImage: true,
                            )
                        : ListView.builder(
                            itemCount: checkoutController
                                    .existingShippingAddress?.length ??
                                0,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var address = checkoutController
                                  .existingShippingAddress![index];
                              return UserAddressTemplate(
                                address: address,
                                index: index,
                                isSelected: checkoutController
                                        .selectedShippingAddress?.id ==
                                    address.id,
                                onDelete: () {},
                                onTap: () {
                                  // checkoutController.showNewShippingAddress = address.id == -1;
                                  setState(() {
                                    checkoutController.selectedShippingAddress =
                                        address;
                                  });
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
          if (shippingAddress?.displayPickupInStore == true &&
              shippingAddress?.pickupPointsModel?.allowPickupInStore == true)
            CheckBoxFormFieldWidget(
              keyName: ConstStrings.CHECKOUT_PICKUP_FROM_STORE,
              initialValue: checkoutController.storePickup,
              contentPadding: EdgeInsets.zero,
              label: ConstStrings.CHECKOUT_PICKUP_FROM_STORE.translate,
              onChanged: (bool? isSelected) {
                setState(() {
                  checkoutController.storePickup = isSelected;
                  /*  if (isSelected ==true) {
                    checkoutController.showNewShippingAddress = false;
                  }*/
                });
              },
            ),
          ActionButton(
            text: ConstStrings.CONTINUE.translate.toUpperCase(),
            onPressed: () {
              checkoutController.saveShippingAddress(
                isNewAddress: false,
              );
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

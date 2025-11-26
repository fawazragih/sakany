import 'package:app_extensions/app_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/save_billing_response.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/check_box_form_field.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/empty_data_widget.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:tamoily/app/modules/products_details_screen/products_details_view.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

import '../../../core/language_and_localization/app_strings.dart';

class ShippingMethodStep extends StatefulWidget {
  const ShippingMethodStep({
    super.key,
  });

  @override
  State<ShippingMethodStep> createState() => _ShippingMethodStepState();
}

class _ShippingMethodStepState extends State<ShippingMethodStep>
    with CheckoutSharedMixin {
  @override
  void initState() {
    super.initState();

    // shippingMethodModel = widget.shippingMethodModel;

    checkoutController.selectedShippingMethod =
        shippingMethodModel?.shippingMethods?.firstWhereOrNull(
              (element) => element.selected == true,
            ) ??
            shippingMethodModel?.shippingMethods?.firstOrNull;

    checkoutController.storePickup = false;
    checkoutController.pickupPointAddress = [
      ...shippingMethodModel?.pickupPointsModel?.pickupPoints ?? []
    ];
    checkoutController.selectedPickupAddress =
        shippingMethodModel?.pickupPointsModel?.pickupPoints?.isNotEmpty == true
            ? shippingMethodModel?.pickupPointsModel?.pickupPoints?.first
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding,
        child: shippingMethodModel?.shippingMethods?.isNotEmpty == true
            ? Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.pleaseSelectYourPreferredShippingMethod.translate
                        .capitalizeFirst!,
                    style: Theme.of(context).textTheme.labelMedium.withBoldFont,
                  ).marginSymmetric(
                    vertical: 16.0.h,
                  ),
                  if (shippingMethodModel?.displayPickupInStore == true &&
                      shippingMethodModel
                              ?.pickupPointsModel?.allowPickupInStore ==
                          true)
                    CheckBoxFormFieldWidget(
                      keyName: ConstStrings.CHECKOUT_PICKUP_FROM_STORE,
                      initialValue: checkoutController.storePickup,
                      label: ConstStrings.CHECKOUT_PICKUP_FROM_STORE.translate,
                      onChanged: (bool? isSelected) {
                        setState(() {
                          checkoutController.storePickup = isSelected;
                          if (isSelected ?? false) {
                            checkoutController.showNewShippingAddress = false;
                          }
                        });
                      },
                    ),
                  (checkoutController.storePickup == true)
                      ? AppDropDownMenuFormFieldWidget<PickupPoint?>(
                          keyName: 'pickup_point_address',
                          initialValue: checkoutController
                              .pickupPointAddress?.firstOrNull,
                          itemsList:
                              checkoutController.pickupPointAddress ?? [],
                          getItemName: (value) =>
                              '${value?.name ?? ''}, ${value?.address ?? ''}, ${value?.city ?? ''} ${value?.countryName ?? ''}'
                                  .trim(),
                          onChanged: (value) {
                            setState(() {
                              checkoutController.selectedPickupAddress = value;
                            });
                          },
                          onSaved: (newValue) {
                            /*_checkoutController.selectedCountry = newValue;
                           formData.countryId = int.tryParse(newValue.value);*/
                          },
                          // validator: (value) {
                          //   /*if (formData.countyEnabled && (value == null || value.value == '0'))
                          //     return _globalService.getString(ConstStrings.COUNTRY_REQUIRED);*/
                          //   return null;
                          // },
                        )
                      : ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount:
                              shippingMethodModel?.shippingMethods?.length ?? 0,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.0.h),
                          itemBuilder: (context, index) {
                            var method =
                                shippingMethodModel?.shippingMethods?[index];
                            return AppCard(
                              withAlignment: false,
                              borderColor: method ==
                                      checkoutController.selectedShippingMethod
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0.w,
                                vertical: 12.0.h,
                              ),
                              onTap: () {
                                setState(() {
                                  checkoutController.selectedShippingMethod =
                                      method;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TitleAndValueRow(
                                    title: AppStrings
                                        .way.translate.capitalizeFirst!,
                                    value: method?.name ?? '',
                                  ),
                                  TitleAndValueRow(
                                    title: ConstStrings
                                        .PRICE.translate.capitalizeFirst!,
                                    value: method?.fee ?? '',
                                  ),
                                  TitleAndValueRow(
                                    title: AppStrings
                                        .description.translate.capitalizeFirst!,
                                    value: method?.description ?? '',
                                  ),
                                ].withSpaceBetween(
                                  height: 8.0.h,
                                ),
                              ),
                            );
                          },
                        ),
                  UiHelper.verticalSpaceMassive,
                ],
              )
            : EmptyDataWidget(
                text: ConstStrings.COMMON_NO_DATA.translate.translate,
              ),
      ),
      bottomNavigationBar: ActionButton(
        text: ConstStrings.CONTINUE.translate,
        onPressed: () => checkoutController.saveShippingMethod(),
      ).paddingSymmetric(
        horizontal: SharedStyle.horizontalScreenPadding,
        vertical: 12.0,
      ),
    );
  }
}

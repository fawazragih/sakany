import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/core/language_and_localization/app_strings.dart';
import 'package:tamoily/app/data/models/available_option.dart';
import 'package:tamoily/app/data/models/estimate_shipping.dart';
import 'package:tamoily/app/data/models/estimate_shipping_response.dart';
import 'package:tamoily/app/data/models/requestbody/form_value.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/dynamic_choice_chips_form_widget.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/app_back_button.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/loading_progress_bar.dart';
import 'package:tamoily/app/global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'package:tamoily/app/modules/products_details_screen/widgets/estimate_shipping_dialog_page/estimate_shipping_dialog_controller.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import 'package:tamoily/app/utils/nop_custom_attribute_manager/validation_mixin.dart';
import '../../../../global_widget/all_form_widgets/input_text_field_widget.dart';

class EstimateShippingDialogView extends StatelessWidget with ValidationMixin {
  EstimateShippingDialogView({
    super.key,
    required this.estimateShipping,
    this.formValues,
    required this.estimationForProduct,
    required this.preSelectedShippingMethod,
  });

  final EstimateShipping estimateShipping;
  final List<FormValue>? formValues;
  final bool estimationForProduct;
  final String preSelectedShippingMethod;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          // horizontal: 12.w,
          // vertical: 24.h,
          ),
      shape: SharedStyle.bottomSheetShape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Directionality(
            textDirection:
                ConstStrings.ESTIMATE_SHIPPING_TITLE.translate.getTextDirection,
            child: Row(
              children: [
                Text(
                  ConstStrings.ESTIMATE_SHIPPING_TITLE.translate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium.withBoldFont,
                ),
                Spacer(),
                AppBackButton(
                  onlyIcon: false,
                  radius: 14.r,
                  padding: EdgeInsets.all(4),
                  backgroundColor: Theme.of(context).primaryColorLight,
                  iconColor: Theme.of(context).disabledColor,
                  iconData: CupertinoIcons.xmark,
                  iconSize: 20.sp,
                ),
              ],
            ).marginSymmetric(
              horizontal: SharedStyle.horizontalScreenPadding,
              vertical: 24.h,
            ),
          ),
          GetBuilder<EstimateShippingDialogController>(
            init: Get.isRegistered<EstimateShippingDialogController>()
                ? Get.find<EstimateShippingDialogController>()
                : EstimateShippingDialogController(
                    estimateShipping: estimateShipping,
                    estimationForProduct: estimationForProduct,
                    preSelectedShippingMethod: preSelectedShippingMethod,
                    passedFormValue: formValues,
                  ),
            builder: (controller) {
              return SingleChildScrollView(
                padding: SharedStyle.singleChildScrollViewHorizontalPadding,
                child: controller.busy
                    ? LoadingProgressBar().marginOnly(bottom: 16.0)
                    : controller.showRetryButton
                        ? RetryWidget(onRetry: controller.initData)
                        : FormBuilder(
                            key: controller.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //region Country Dropdown
                                AppDropDownMenuFormFieldWidget<
                                    AvailableOption?>(
                                  keyName: ConstStrings.SELECT_COUNTRY,
                                  labelText:
                                      ConstStrings.SELECT_COUNTRY.translate,
                                  hintText:
                                      ConstStrings.SELECT_COUNTRY.translate,
                                  onChanged: (country) {
                                    // estimateShipping.countryId = int.tryParse(country?.value ?? '-1');
                                    if (country != null) {
                                      int countryId = int.tryParse(country.value ?? '-1') ?? -1;
                                      controller.fetchStates(countryId);
                                    }
                                  },
                                  onSaved: (newValue) {
                                    estimateShipping.countryId =
                                        int.tryParse(newValue?.value ?? '-1');
                                  },
                                  validator: (value) {
                                    if (value == null || value.serverValue == '0') {
                                      return ConstStrings
                                          .COUNTRY_REQUIRED.translate;
                                    }
                                    return null;
                                  },
                                  initialValue: estimateShipping
                                      .availableCountries
                                      ?.firstWhereOrNull((element) =>
                                          element.selected ?? false),
                                  itemsList:
                                      estimateShipping.availableCountries ?? [],
                                  getItemName: (AvailableOption? value) =>
                                      kDebugMode
                                          ? '${value?.value} - ${value?.text}'
                                          : value?.text ?? '',
                                ),
                                //endregion

                                //region States Dropdown
                                Obx(() {
                                  controller.statesList;
                                  return controller.loadingStates.value
                                      ? UiHelper
                                          .horizontalSpaceSpinKitProgressIndicator(
                                              size: 40)
                                      : AppDropDownMenuFormFieldWidget<AvailableOption?>(
                                          keyName: ConstStrings.SELECT_STATE,
                                          labelText: ConstStrings
                                              .SELECT_STATE.translate,
                                          hintText: ConstStrings
                                              .SELECT_STATE.translate,
                                          /*onChanged: (value) {
                                            estimateShipping.stateProvinceId =
                                                int.tryParse(
                                                    value?.value ?? '-1');
                                          },*/
                                          onSaved: (newValue) {
                                            estimateShipping.stateProvinceId =
                                                int.tryParse(
                                                    newValue?.value ?? '-1');
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.serverValue == '-1') {
                                              return ConstStrings.STATE_REQUIRED.translate;
                                            }
                                            return null;
                                          },
                                          initialValue: controller.statesList
                                                  .firstWhereOrNull(
                                                (element) =>
                                                    element.selected ?? false,
                                              ) ??
                                              controller.statesList.firstOrNull,
                                          itemsList: controller.statesList,
                                          getItemName: (AvailableOption?
                                                  value) =>
                                              kDebugMode
                                                  ? '${value?.value} - ${value?.text}'
                                                  : value?.text ?? '',
                                        );
                                }),
                                //endregion

                                //region zipPostalCode
                                InputTextFieldWidget(
                                  keyName: AppStrings.city,
                                  keyboardType: TextInputType.streetAddress,
                                  autoFocus: false,
                                  initialValue: estimateShipping.useCity == true
                                      ? estimateShipping.city ?? ''
                                      : estimateShipping.zipPostalCode ?? '',
                                  // textInputAction: TextInputAction.next,
                                  labelText: (estimateShipping.useCity ?? false)
                                      ? ConstStrings.CITY.translate
                                      : ConstStrings
                                          .ESTIMATE_SHIPPING_ZIP.translate,
                                  isRequired: false,
                                  onSaved: (newValue) {
                                    logger.d('onSaved');
                                    if (estimateShipping.useCity == true) {
                                      estimateShipping.city = newValue;
                                    } else {
                                      estimateShipping.zipPostalCode = newValue;
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return (estimateShipping.useCity == true)
                                          ? ConstStrings.CITY.translate
                                          : ConstStrings.ZIP_REQUIRED.translate;
                                    }
                                    return null;
                                  },
                                ),
                                //endregion

                                Obx(() {
                                  return Column(
                                    children: [
                                      controller.estimateShippingResult.value ==
                                                  null ||
                                              controller
                                                      .estimateShippingResult
                                                      .value
                                                      ?.shippingOptions
                                                      ?.isNullOrEmpty ==
                                                  true
                                          ? Text(
                                              ConstStrings
                                                  .ESTIMATE_SHIPPING_NO_OPTION
                                                  .translate,
                                            )
                                          : DynamicChoiceChipsFormWidget<
                                              ShippingOption>(
                                              keyName: 'shippingOptions',
                                              isRequired: false,
                                              labelText: AppStrings
                                                  .availableShippingEstimation
                                                  .tr
                                                  .capitalizeFirst!,
                                              inHorizontalListBuilder: false,
                                              choices: controller
                                                      .estimateShippingResult
                                                      .value
                                                      ?.shippingOptions ??
                                                  [],
                                              onChange: (value) {
                                                if (value != null) {
                                                  controller.selectedMethod =
                                                      controller
                                                          .getMethodId(value);
                                                }
                                              },
                                              getName: (option) =>
                                                  '${option.name ?? ''} (${option.price ?? ''})' ??
                                                  '',
                                            ),
                                      UiHelper.verticalSpaceMedium,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ActionButton(
                                              onPressed: controller.onSubmit,
                                              text: ConstStrings
                                                  .CART_ESTIMATE_SHIPPING_BTN
                                                  .translate,
                                            ),
                                          ),
                                          if (controller
                                                  .estimateShippingResult
                                                  .value
                                                  ?.shippingOptions
                                                  ?.isNotNullOrEmpty ==
                                              true) ...[
                                            UiHelper.horizontalSpaceSmallMedium,
                                            Expanded(
                                              child: ActionButton(
                                                isOutLined: true,
                                                onPressed: () => Get.back(
                                                    result: controller
                                                        .selectedMethod),
                                                text: ConstStrings
                                                    .ESTIMATE_SHIPPING_APPLY
                                                    .translate,
                                              ),
                                            ),
                                          ]
                                        ],
                                      ),
                                    ],
                                  );
                                }),

                                UiHelper.verticalSpaceMedium,
                              ].withSpaceBetween(height: 12.0),
                            ),
                          ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/core/language_and_localization/app_strings.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/available_option.dart';
import 'package:tamoily/app/data/models/estimate_shipping.dart';
import 'package:tamoily/app/data/models/estimate_shipping_response.dart';
import 'package:tamoily/app/data/models/requestbody/estimate_shipping_req_body.dart';
import 'package:tamoily/app/data/models/requestbody/form_value.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/different_dialogs.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';

import 'repository/estimate_shipping_repository.dart';

class EstimateShippingDialogController extends BaseController {
  // {Data:
  // {ProductId: 90,
  // RequestDelay: 300,
  // Enabled: true,
  // CountryId: 12,
  // StateProvinceId: 1,
  // ZipPostalCode: dd,
  // UseCity: false,
  // City: null,
  // AvailableCountries: [],
  // AvailableStates: [],
  // CustomProperties: {}},
  // FormValues: [{Key: product_attribute_19, Value: 8},
  // {Key: addtocart_90.EnteredQuantity, Value: 1}]
  // }
  final EstimateShippingRepository _repository = EstimateShippingRepository();

  Rx<EstimateShippingData?> estimateShippingResult = Rx(null);

  String? selectedMethod;

  late EstimateShipping estimateShipping;
  late bool estimationForProduct;
  late String preSelectedShippingMethod;
  late List<FormValue>? passedFormValue;

  EstimateShippingDialogController({
    required this.estimateShipping,
    required this.estimationForProduct,
    required this.passedFormValue,
    required this.preSelectedShippingMethod,
  }) {
    initData();
  }

  initData() {
    for (AvailableOption element
        in (estimateShipping.availableCountries ?? [])) {
      if (element.selected == true) {
        estimateShipping.countryId = int.tryParse(element.value ?? '0') ?? 0;
        break;
      }
    }

    for (AvailableOption element in (estimateShipping.availableStates ?? [])) {
      if (element.selected == true) {
        estimateShipping.stateProvinceId =
            int.tryParse(element.value ?? '0') ?? 0;
        break;
      }
    }

    if ((estimateShipping.countryId ?? 0) > 0 &&
        (estimateShipping.stateProvinceId ?? 0) > 0) {
      estimationForProduct
          ? estimateShippingForProduct(
              estimateShipping,
              passedFormValue ?? [],
              showInitialLoading: true,
            )
          : estimateShippingForCart(
              estimateShipping,
              showInitialLoading: true,
            );
    }
  }
/*
  //region States logic
  RxBool loadingStates = RxBool(false);
  RxList<AvailableOption> statesList = RxList();

  fetchStates(AvailableOption country) async {
    int countryId = int.tryParse(country.value ?? '') ?? -1;

    if (countryId == -1) return;
    loadingStates.value = true;

    SuccessOrError response = await _repository.getStatesByCountry(countryId);
    loadingStates.value = false;
    if (response.success) {
      List<AvailableStates> availableStates = response.response?.data ?? [];
      statesList.value = availableStates
          .map((e) => AvailableOption(text: e.name, value: e.id.toString()))
          .toList();
    } else {
      buildErrorSnackBar(msg: response.error.toString());
    }
  }
  //endregion
*/

  estimateShippingForCart(
    EstimateShipping estimateShipping, {
    bool showInitialLoading = false,
  }) async {
    if (showInitialLoading) {
      setBusy(true);
    } else {
      DifferentDialogs.showProgressDialog();
    }
    EstimateShippingReqBody reqBody = EstimateShippingReqBody(
      data: estimateShipping
          .copyWith(availableCountries: [], availableStates: []),
      formValues: [],
    );

    SuccessOrError result = await _repository.estimateShipping(reqBody);

    if (result.success) {
      if (showInitialLoading) {
        setBusy(false);
      } else {
        DifferentDialogs.hideProgressDialog();
      }
      defineSelectedItem(result.response?.data);
      estimateShippingResult.value = result.response?.data;
    } else {
      if (showInitialLoading) {
        setShowRetryButton(true);
      } else {
        DifferentDialogs.hideProgressDialog();
      }
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void estimateShippingForProduct(
    EstimateShipping estimateShipping,
    List<FormValue> productFormValues, {
    bool showInitialLoading = false,
  }) async {
    if (showInitialLoading) {
      setBusy(true);
    } else {
      DifferentDialogs.showProgressDialog();
    }
    EstimateShippingReqBody reqBody = EstimateShippingReqBody(
        data: estimateShipping
            .copyWith(availableCountries: [], availableStates: []),
        formValues: productFormValues);

    SuccessOrError result = await _repository.productEstimateShipping(reqBody);

    if (result.success) {
      if (showInitialLoading) {
        setBusy(false);
      } else {
        DifferentDialogs.hideProgressDialog();
      }
      defineSelectedItem(result.response?.data);
      estimateShippingResult.value = result.response?.data;
    } else {
      if (showInitialLoading) {
        setShowRetryButton(true);
      } else {
        DifferentDialogs.hideProgressDialog();
      }
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void defineSelectedItem(EstimateShippingData response) {
    if (preSelectedShippingMethod.isNotEmpty) {
      selectedMethod = preSelectedShippingMethod;
      preSelectedShippingMethod = '';
    } else {
      response.shippingOptions?.forEach((element) {
        if (element.selected == true) {
          selectedMethod = getMethodId(element);
        }
      });
    }
  }

  void onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      Map<String, dynamic> allValues = formKey.currentState!.value;

      logger.d(allValues);

      if (estimationForProduct && passedFormValue != null) {
        estimateShippingForProduct(
          estimateShipping,
          passedFormValue!,
        );
      } else {
        estimateShippingForCart(estimateShipping);
      }
    } else {
      toastMessage(AppStrings.fillAllData.tr);
    }
    removeFocusFromInputField();
  }

  void removeFocusFromInputField() {
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  String getMethodId(ShippingOption element) {
    return '${element.name}_${element.shippingRateComputationMethodSystemName}';
  }
}

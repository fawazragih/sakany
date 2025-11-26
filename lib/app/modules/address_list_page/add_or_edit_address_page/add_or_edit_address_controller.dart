import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/address_form_response.dart';
import 'package:tamoily/app/data/models/requestbody/form_value.dart';
import 'package:tamoily/app/utils/constants/app_constants.dart';
import 'package:tamoily/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';

import '../../../data/models/get_billing_address_response.dart';
import '../repository/address_list_repository.dart';
import 'arguments/add_or_edit_address_page_args.dart';

class AddOrEditAddressController extends BaseController {
  final AddressListRepository _repository = AddressListRepository();
  late AddOrEditAddressPageArgs argument;

  Address? address;

  late CustomAttributeManager attributeManager;

  bool get isEditMode {
    return argument.isEditMode == true &&
        argument.addressId != null &&
        argument.addressId != -1;
  }

  @override
  void onInit() {
    super.onInit();
    argument = AddOrEditAddressPageArgs.fromJson(Get.parameters);
    attributeManager = CustomAttributeManager(
      context: Get.context,
      onClick: (priceAdjNeeded) {
        update();
        // setState(() {
        //   // updating UI to show selected attribute values
        // });
      },
    );

    initData();
  }

  void initData() {
    if (isEditMode) {
      _fetchExistingAddress(argument.addressId!);
    } else {
      _fetchNewAddressForm();
    }
  }

  _fetchExistingAddress(int addressId) async {
    setBusy(true);

    SuccessOrError result = await _repository.fetchExistingAddress(addressId);

    if (result.success) {
      AddressFormData responseData = result.response?.data;
      address = responseData.address;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  _fetchNewAddressForm() async {
    setBusy(true);

    SuccessOrError result = await _repository.fetchNewAddressForm();

    if (result.success) {
      AddressFormData responseData = result.response?.data;
      address = responseData.address;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  /*
  //region States logic
  RxBool loadingStates = RxBool(false);

  // RxList<AvailableOption> statesList = RxList();
  fetchStatesByCountryId(int countryId) async {
    if (countryId == -1) return;
    loadingStates.value = true;

    SuccessOrError response = await _repository.getStatesByCountry(countryId);

    if (response.success) {
      List<AvailableStates> availableStates = response.response?.data ?? [];
      // statesList.value = availableStates.map((e) => AvailableOption(text: e.name, value: e.id.toString())).toList();
      address?.availableStates = availableStates
          .map((e) => AvailableOption(text: e.name, value: e.id.toString()))
          .toList();
    } else {
      address?.availableStates = List<AvailableOption>.empty();
      buildErrorSnackBar(msg: response.error.toString());
    }

    loadingStates.value = false;
  }
//endregion
*/

  saveAddress() async {
    hideSoftKeyBoard();

    String errMsg = attributeManager
        .checkRequiredAttributes(address?.customAddressAttributes ?? []);
    if (errMsg.isNotEmpty) {
      buildErrorSnackBar(msg: errMsg);
    } else {
      // logger.d(formKey.currentState?.validate().toString());
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState?.save();

        if (isEditMode) {
          editAddress(
            argument.addressId!,
            address!,
            attributeManager
                .getSelectedAttributes(AppConstants.addressAttributePrefix),
          );
        } else {
          saveNewAddress(
            address!,
            attributeManager
                .getSelectedAttributes(AppConstants.addressAttributePrefix),
          );
        }
      }
    }
  }

  void editAddress(
      int addressId, Address address, List<FormValue> formValues) async {
    showProgressDialog();
    SuccessOrError response = await _repository.updateExistingAddress(
        addressId,
        AddressFormResponse(
          data: AddressFormData(
            address: address.copyWith(
              availableStates: [],
              availableCountries: [],
              customAddressAttributes: [],
            ),
          ),
          formValues: formValues,
        ));

    hideProgressDialog();

    if (response.success) {
      Get.back(result: AppConstants.keyRefreshContent);
      buildSuccessSnackBar();
    } else {
      buildErrorSnackBar(msg: response.error.toString());
    }
  }

  void saveNewAddress(Address address, List<FormValue> formValues) async {
    showProgressDialog();
    SuccessOrError response = await _repository.saveNewAddress(
      AddressFormResponse(
        data: AddressFormData(
          address: address.copyWith(
            availableStates: [],
            availableCountries: [],
            customAddressAttributes: [],
          ),
        ),
        formValues: formValues,
      ),
    );

    hideProgressDialog();

    if (response.success) {
      Get.back(result: AppConstants.keyRefreshContent);
      buildSuccessSnackBar();
    } else {
      buildErrorSnackBar(msg: response.error.toString());
    }
  }
}

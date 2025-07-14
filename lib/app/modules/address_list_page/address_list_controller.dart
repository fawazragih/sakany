import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/address_list_response.dart';
import 'package:sakani/app/data/models/get_billing_address_response.dart';
import 'package:sakani/app/modules/address_list_page/add_or_edit_address_page/add_or_edit_address_view.dart';
import 'package:sakani/app/utils/constants/app_constants.dart';

import '../../utils/api_env_config/app_logger_config.dart';
import 'add_or_edit_address_page/arguments/add_or_edit_address_page_args.dart';
import 'repository/address_list_repository.dart';

class AddressListController extends BaseController {
  final AddressListRepository _repository = AddressListRepository();

  AddressListData? addressListData;

  @override
  void onInit() {
    super.onInit();
    fetchAddressList();
  }

  void fetchAddressList() async {
    // addressListSink.add(ApiResponse.loading());
    // try {
    //   AddressListResponse response = await _repository.fetchCustomerAddresses();
    //   cachedAddressList = response;
    //   addressListSink.add(ApiResponse.completed(response));
    // } catch (e) {
    //   addressListSink.add(ApiResponse.error(e.toString()));
    //   logger.e(e);
    // }

    setBusy(true);
    SuccessOrError result = await _repository.fetchCustomerAddresses();
    hideProgressDialog();
    if (result.success) {
      addressListData = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  deleteAddress(int addressId) async {
    showProgressDialog();
    SuccessOrError result = await _repository.deleteAddressById(addressId);
    hideProgressDialog();
    if (result.success) {
      // remove item from list
      addressListData?.addresses
          ?.removeWhere((element) => element.id == addressId);
      update();
      buildSuccessSnackBar();
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void onDeleteAddress(Address address) {
    if (address.id != null) {
      //TODO byMe show onDeleteAddress
      logger.d('TODO');
      // showDialog(
      //     context: context,
      //     builder: (_) => getDeleteConfirmationDialog(address.id!));
    }
  }

  void addNewAddress() {
    Get.toNamed(
      AddOrEditAddressPage.routeName,
      parameters: AddOrEditAddressPageArgs(
        isEditMode: false,
        addressId: -1,
      ).toJson(),
    )?.then((value) {
      if (value.toString() == AppConstants.keyRefreshContent) {
        fetchAddressList();
      }
    });
  }
}

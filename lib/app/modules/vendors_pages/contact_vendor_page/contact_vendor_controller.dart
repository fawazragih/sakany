import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/contact_vendor_response.dart';

import '../repository/vendor_repository.dart';

class ContactVendorController extends BaseController {
  final VendorRepository _repository = VendorRepository();

  int? vendorId;

  ContactVendorData? formData;

  @override
  void onInit() {
    super.onInit();
    vendorId = int.tryParse(Get.parameters['vendorId'] ?? '');
    if (vendorId == null) {
      setShowRetryButton(true, errorMsg: 'no vendor id passed');
    } else {
      fetchFormData();
    }
  }

  fetchFormData() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchFormData(vendorId!);
    if (result.success) {
      formData = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void postEnquiry(ContactVendorData formData) async {
    showProgressDialog();
    SuccessOrError result =
        await _repository.postEnquiry(ContactVendorResponse(data: formData));
    hideProgressDialog();
    if (result.success) {
      Get.back();
      buildSuccessSnackBar(msg: result.response?.message ?? '');
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void submit() {
    hideSoftKeyBoard();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      postEnquiry(formData!);
    }
  }
}

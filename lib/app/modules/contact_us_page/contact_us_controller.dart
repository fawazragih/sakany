import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/contact_us_response.dart';

import 'repository/contact_us_repository.dart';

class ContactUsController extends BaseController {
  final ContactUsRepository _repository = ContactUsRepository();

  ContactUsData? formData;

  @override
  void onInit() {
    super.onInit();
    fetchFormData();
  }

  fetchFormData() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchFormData();
    if (result.success) {
      formData = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void postEnquiry() async {
    hideSoftKeyBoard();

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      showProgressDialog();
      SuccessOrError result =
          await _repository.postEnquiry(ContactUsResponse(data: formData));
      hideProgressDialog();
      if (result.success) {
        Get.back();
        buildSuccessSnackBar(msg: result.response?.message ?? '');
      } else {
        buildErrorSnackBar(msg: result.error.toString());
      }
    }
  }
}

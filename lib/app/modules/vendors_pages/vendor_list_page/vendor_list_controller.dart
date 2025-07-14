import 'package:sakani_mobile_app/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/models/all_vendors_response.dart';
import 'package:sakani_mobile_app/app/modules/vendors_pages/repository/vendor_repository.dart';

class VendorListController extends BaseController {
  final VendorRepository _repository = VendorRepository();
  List<VendorDetails> data = [];

  @override
  void onInit() {
    super.onInit();
    fetchAllVendors();
  }

  fetchAllVendors() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchVendorList();
    if (result.success) {
      data = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }
}

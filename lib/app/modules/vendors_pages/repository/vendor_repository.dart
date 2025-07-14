import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/api_providers/vendor_api.dart';
import 'package:sakani_mobile_app/app/data/models/contact_vendor_response.dart';

class VendorRepository {
  final VendorApi _api = VendorApi();

  Future<SuccessOrError> fetchVendorList() => _api.fetchVendorList();

  Future<SuccessOrError> fetchFormData(int vendorId) =>
      _api.fetchFormData(vendorId);

  Future<SuccessOrError> postEnquiry(ContactVendorResponse reqBody) =>
      _api.postEnquiry(reqBody);
}

import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/api_providers/contact_us_api.dart';
import 'package:sakani_mobile_app/app/data/models/contact_us_response.dart';

class ContactUsRepository {
  final ContactUsApi _api = ContactUsApi();

  Future<SuccessOrError> fetchFormData() => _api.fetchFormData();

  Future<SuccessOrError> postEnquiry(ContactUsResponse reqBody) =>
      _api.postEnquiry(reqBody);
}

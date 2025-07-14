import 'package:sakani_mobile_app/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani_mobile_app/app/data/models/all_vendors_response.dart';
import 'package:sakani_mobile_app/app/data/models/contact_vendor_response.dart';

import 'api_response_models/general_response_model.dart';
import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class VendorApi extends BaseApi {
  Future<SuccessOrError> fetchVendorList() async {
    // final response = await _helper.get(Endpoints.allVendors);
    // return AllVendorsResponse.fromJson(response);

    return await dio.get(ApiEndpoints.allVendors).mapFromResponse(
          (data) =>
              GeneralResponseModel<List<VendorDetails>, VendorDetails>.fromJson(
            json: data,
            serialize: VendorDetails.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchFormData(int vendorId) async {
    // final response = await _helper.get('${Endpoints.contactVendor}/$vendorId');
    // return ContactVendorResponse.fromJson(response);
    // ContactVendorData

    return await dio
        .get('${ApiEndpoints.contactVendor}/$vendorId')
        .mapFromResponse(
          (data) => GeneralResponseModel<ContactVendorData,
              ContactVendorData>.fromJson(
            json: data,
            serialize: ContactVendorData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> postEnquiry(ContactVendorResponse reqBody) async {
    // final response = await _helper.post(Endpoints.contactVendor, reqBody);
    // return ContactVendorResponse.fromJson(response);
    return await dio
        .post(
          ApiEndpoints.contactVendor,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<ContactVendorData,
              ContactVendorData>.fromJson(
            json: data,
            serialize: ContactVendorData.fromJson,
          ),
        );
  }
}

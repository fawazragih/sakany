import 'package:tamoily/app/data/api_providers/api_response_models/general_response_model.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/contact_us_response.dart';

import 'base_configs/api_paths.dart';
import 'base_configs/base_api.dart';

class ContactUsApi extends BaseApi {
  Future<SuccessOrError> fetchFormData() async {
    // final response = await _helper.get(Endpoints.contactUs);
    // return ContactUsResponse.fromJson(response);
    return await dio.get(ApiEndpoints.contactUs).mapFromResponse(
          (data) => GeneralResponseModel<ContactUsData, ContactUsData>.fromJson(
            json: data,
            serialize: ContactUsData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> postEnquiry(ContactUsResponse reqBody) async {
    // final response = await _helper.post(Endpoints.contactUs, reqBody);
    // return ContactUsResponse.fromJson(response);
    return await dio
        .post(
          ApiEndpoints.contactUs,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<ContactUsData, ContactUsData>.fromJson(
            json: data,
            serialize: ContactUsData.fromJson,
          ),
        );
  }
}

import 'package:sakani/app/data/api_providers/base_configs/api_paths.dart';
import 'package:sakani/app/data/api_providers/base_configs/base_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/api_providers/share_api.dart';
import 'package:sakani/app/data/models/address_form_response.dart';

import '../models/BaseResponse.dart';
import '../models/address_list_response.dart';
import 'api_response_models/general_response_model.dart';

class AddressApi extends BaseApi with SharedApi {
  Future<SuccessOrError> fetchCustomerAddresses() async {
    return await dio.get(ApiEndpoints.addressList).mapFromResponse(
          (data) =>
              GeneralResponseModel<AddressListData, AddressListData>.fromJson(
            json: data,
            serialize: AddressListData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> deleteAddressById(int addressId) async {
    return await dio.post(
      '${ApiEndpoints.deleteAddress}/$addressId',
      data: {},
    ).mapFromResponse(
      (data) => GeneralResponseModel.fromJson(
        json: data,
      ),
    );
  }

  Future<SuccessOrError> fetchNewAddressForm() async {
    return await dio.get(ApiEndpoints.addAddress).mapFromResponse(
          (data) =>
              GeneralResponseModel<AddressFormData, AddressFormData>.fromJson(
            json: data,
            serialize: AddressFormData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> saveNewAddress(AddressFormResponse reqBody) async {
    return await dio
        .post(
          ApiEndpoints.addAddress,
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<BaseResponse, BaseResponse>.fromJson(
            json: data,
            serialize: BaseResponse.fromJson,
          ),
        );
  }

  Future<SuccessOrError> fetchExistingAddress(int addressId) async {
    return await dio
        .get('${ApiEndpoints.editAddress}/$addressId')
        .mapFromResponse(
          (data) =>
              GeneralResponseModel<AddressFormData, AddressFormData>.fromJson(
            json: data,
            serialize: AddressFormData.fromJson,
          ),
        );
  }

  Future<SuccessOrError> updateExistingAddress(
    int addressId,
    AddressFormResponse reqBody,
  ) async {
    // final response = await _helper.post();
    // return BaseResponse.fromJson(response);

    return await dio
        .post(
          '${ApiEndpoints.editAddress}/$addressId',
          data: reqBody.toJson(),
        )
        .mapFromResponse(
          (data) => GeneralResponseModel<BaseResponse, BaseResponse>.fromJson(
            json: data,
            serialize: BaseResponse.fromJson,
          ),
        );
  }
}

import 'package:sakani/app/data/api_providers/address_api.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/address_form_response.dart';

class AddressListRepository {
  final AddressApi _api = AddressApi();

  Future<SuccessOrError> fetchCustomerAddresses() =>
      _api.fetchCustomerAddresses();

  Future<SuccessOrError> getStatesByCountry(int countryId) =>
      _api.getStatesByCountry(countryId);

  Future<SuccessOrError> deleteAddressById(int addressId) =>
      _api.deleteAddressById(addressId);

  Future<SuccessOrError> fetchNewAddressForm() => _api.fetchNewAddressForm();

  Future<SuccessOrError> saveNewAddress(AddressFormResponse address) =>
      _api.saveNewAddress(address);

  Future<SuccessOrError> fetchExistingAddress(int addressId) =>
      _api.fetchExistingAddress(addressId);

  Future<SuccessOrError>  updateExistingAddress(
          int addressId, AddressFormResponse addressFormResponse) =>
      _api.updateExistingAddress(addressId, addressFormResponse);
}

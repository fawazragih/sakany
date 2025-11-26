import 'dart:async';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/requestbody/form_values_request_body.dart';
import 'package:tamoily/app/data/models/requestbody/save_billing_req_body.dart';
import 'package:tamoily/app/data/models/requestbody/save_payment_req_body.dart';
import 'package:tamoily/app/data/models/requestbody/save_shipping_req_body.dart';
import '../../../base_controllers_and_listeners/shared_repository.dart';

class CheckoutRepository extends SharedRepository {
  // final CheckoutApi checkoutApi = CheckoutApi();

  Future<SuccessOrError> fetchBillingAddress() =>
      checkoutApi.fetchBillingAddress();

  Future<SuccessOrError> saveBillingAddress(SaveBillingReqBody reqBody) =>
      checkoutApi.saveBillingAddress(reqBody);

  Future<SuccessOrError> saveShippingAddress(SaveShippingReqBody reqBody) =>
      checkoutApi.saveShippingAddress(reqBody);

  Future<SuccessOrError> saveShippingMethod(FormValuesRequestBody reqBody) =>
      checkoutApi.saveShippingMethod(reqBody);

  Future<SuccessOrError> savePaymentMethod(SavePaymentReqBody reqBody) => checkoutApi.savePaymentMethod(reqBody);

  Future<SuccessOrError> callBasPaymentInfo(String basAuthId) =>
      checkoutApi.callBasPaymentInfo(basAuthId);

  Future<SuccessOrError> getConfirmOrder() => checkoutApi.getConfirmOrder();

  Future<SuccessOrError> confirmOrder() => checkoutApi.confirmOrder();

  Future<SuccessOrError> orderComplete() => checkoutApi.orderComplete();
}

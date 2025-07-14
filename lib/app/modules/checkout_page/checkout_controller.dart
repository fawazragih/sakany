import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/models/available_option.dart';
import 'package:sakani/app/data/models/bas_checkout_payment_info.dart';
import 'package:sakani/app/data/models/requestbody/form_value.dart';
import 'package:sakani/app/data/models/requestbody/form_values_request_body.dart';
import 'package:sakani/app/data/models/requestbody/save_billing_req_body.dart';
import 'package:sakani/app/data/models/requestbody/save_payment_req_body.dart';
import 'package:sakani/app/data/models/requestbody/save_shipping_req_body.dart';
import 'package:sakani/app/data/models/save_billing_response.dart';
import 'package:sakani/app/data/models/shopping_cart_response.dart';
import '../../data/api_providers/base_configs/handling_dio_response.dart';
import '../../data/models/get_billing_address_response.dart';
import '../../utils/api_env_config/app_logger_config.dart';
import 'checkout_shared_mixin.dart';
import 'repository/checkout_repository.dart';

class CheckoutController extends BaseController {
  final CheckoutRepository _repository = CheckoutRepository();
  List<int> doneWithSuccess = [];

  CheckoutSteps _currentStep = CheckoutSteps.getStep(1);

  CheckoutSteps get currentStep => _currentStep;

  set currentStep(CheckoutSteps value) {
    _currentStep = value;
    logger.d('currentStep: ${value.serverValue}-${value.name}');
    update();
  }

  GetBillingData? billingData;

  CheckoutPostResponseData? _checkoutPostResponseData;

  CheckoutPostResponseData? get checkoutPostResponseData =>
      _checkoutPostResponseData;

  set checkoutPostResponseData(CheckoutPostResponseData? value) {
    _checkoutPostResponseData = value;
    currentStep =
        _checkoutPostResponseData?.nextStep ?? CheckoutSteps.getStep(-1);
    // it will be updated in the currentStep setter;
    // update();
  }

  // address
  AvailableOption? selectedCountry;

  // billing address
  List<Address>? existingBillingAddress;
  bool? showNewBillingAddress;
  bool? shipToSameAddress;
  Address? selectedBillingAddress;

  // shipping address
  List<Address>? existingShippingAddress;
  bool? showNewShippingAddress;
  bool? storePickup;
  Address? selectedShippingAddress;
  List<PickupPoint>? pickupPointAddress;
  PickupPoint? selectedPickupAddress;

  // shipping method
  ShippingMethod? selectedShippingMethod;

  // payment method
  PaymentMethod? selectedPaymentMethod;
  bool userRewardPoint = false;

  // order complete
  int orderId = 0;
  String? orderNumber;
  String? warningMsg = '';

  @override
  void onInit() {
    super.onInit();
    fetchBillingAddress();
  }

  void fetchBillingAddress() async {
    /*getBillingSink.add(ApiResponse.loading());

    try {
      GetBillingAddressResponse response =  await _repository.fetchBillingAddress();

      existingBillingAddress = [
        ...?response.data?.billingAddress?.existingAddresses
      ];
      existingBillingAddress?.add(Address(
        id: -1,
      )); // New address option to show on dropdown menu

      showNewBillingAddress = response.data?.billingAddress?.existingAddresses?.isEmpty == true;
      shipToSameAddress =
          response.data?.billingAddress?.shipToSameAddress ?? false;
      selectedExistingBillingAddress =
          response.data?.billingAddress?.existingAddresses?.safeFirst();
      selectedCountry = response
          .data?.billingAddress?.billingNewAddress?.availableCountries
          ?.safeFirst();

      getBillingSink.add(ApiResponse.completed(response));
    } catch (e) {
      getBillingSink.add(ApiResponse.error(e.toString()));
      print(e);
    }*/

    setBusy(true);
    SuccessOrError result = await _repository.fetchBillingAddress();
    if (result.success) {
      billingData = result.response?.data;
      existingBillingAddress = [
        ...(billingData?.billingAddress?.existingAddresses ?? [])
      ];

      showNewBillingAddress =
          billingData?.billingAddress?.existingAddresses?.isEmpty == true;
      shipToSameAddress =
          billingData?.billingAddress?.shipToSameAddress ?? false;
      selectedBillingAddress =
          billingData?.billingAddress?.existingAddresses?.firstOrNull;
      selectedCountry = billingData
          ?.billingAddress?.billingNewAddress?.availableCountries?.firstOrNull;

      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void saveBillingAddress({
    required bool newAddress,
    List<FormValue>? formValue,
    Address? address,
    VoidCallback? onDone,
  }) async {
    SaveBillingReqBody reqBody;

    if (!newAddress) {
      reqBody = SaveBillingReqBody(
        data: SaveBillingData(
          shipToSameAddress: shipToSameAddress,
        ),
        formValues: [
          FormValue(
            key: 'billing_address_id',
            value: selectedBillingAddress?.id.toString(),
          )
        ],
      );
    } else {
      reqBody = SaveBillingReqBody(
        data: SaveBillingData(
          shipToSameAddress: shipToSameAddress,
          billingNewAddress: address?.copyWith(
            availableStates: [],
          ),
        ),
        formValues: formValue ?? [],
      );
    }

    showProgressDialog();
    SuccessOrError result = await _repository.saveBillingAddress(reqBody);
    hideProgressDialog();
    if (result.success) {
      CheckoutPostResponseData response = result.response?.data;
      // logger.d(response.toJson());
      // currentStep = response.nextStep ?? CheckoutSteps.getStep(-1);
      checkoutPostResponseData = response;
      onDone?.call();
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void saveShippingAddress({
    required bool isNewAddress,
    List<FormValue>? formValue,
    Address? address,
  }) async {
    SaveShippingReqBody reqBody;

    if (storePickup ?? false) {
      reqBody = SaveShippingReqBody(formValues: [
        FormValue(
          key: 'pickup-points-id',
          value: '${selectedPickupAddress?.id}___Pickup.PickupInStore',
        ),
        FormValue(
          key: 'pickupinstore',
          value: 'true',
        ),
      ]);
    } else {
      if (isNewAddress) {
        reqBody = SaveShippingReqBody(
          data: SaveShippingReqData(
            shippingNewAddress: address,
          ),
          formValues: formValue ?? [],
        );
      } else {
        reqBody = SaveShippingReqBody(formValues: [
          FormValue(
            key: 'shipping_address_id',
            value: selectedShippingAddress?.id.toString(),
          )
        ]);
      }
    }

    /*checkoutPostSink.add(ApiResponse.loading());
   try {
      CheckoutPostResponse response =  await _repository.saveShippingAddress(reqBody);
      currentStep = response.data?.nextStep ?? -1;

      checkoutPostSink.add(ApiResponse.completed(response));
    } catch (e) {
      checkoutPostSink.add(ApiResponse.error(e.toString()));
      print(e);
    }*/

    showProgressDialog();
    SuccessOrError result = await _repository.saveShippingAddress(reqBody);
    hideProgressDialog();
    if (result.success) {
      CheckoutPostResponseData response = result.response?.data;
      // currentStep = response.nextStep ?? CheckoutSteps.getStep(-1);
      checkoutPostResponseData = response;
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void saveShippingMethod() async {
    FormValuesRequestBody reqBody = FormValuesRequestBody(
      formValues: [
        FormValue(
          key: 'pickupinstore',
          value: storePickup.toString(),
        ),
        if (storePickup ?? false)
          FormValue(
            key: 'pickup-points-id',
            value: '${selectedPickupAddress?.id}___Pickup.PickupInStore',
          ),
        if (storePickup == false)
          FormValue(
              key: 'shippingoption',
              value:
                  '${selectedShippingMethod?.name}___${selectedShippingMethod?.shippingRateComputationMethodSystemName}'),
      ],
    );

    /*
    checkoutPostSink.add(ApiResponse.loading());
    try {
      CheckoutPostResponse response = await _repository.saveShippingMethod(reqBody);
      currentStep = response.data?.nextStep ?? -1;

      checkoutPostSink.add(ApiResponse.completed(response));
    } catch (e) {
      checkoutPostSink.add(ApiResponse.error(e.toString()));
      print(e);
    }*/

    showProgressDialog();
    SuccessOrError result = await _repository.saveShippingMethod(reqBody);
    hideProgressDialog();
    if (result.success) {
      CheckoutPostResponseData response = result.response?.data;
      // currentStep = response.nextStep ?? CheckoutSteps.getStep(-1);
      checkoutPostResponseData = response;
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void savePaymentMethod() async {
    SavePaymentReqBody reqBody = SavePaymentReqBody(
      data: SavePaymentData(useRewardPoints: userRewardPoint),
      formValues: [
        FormValue(
            key: 'paymentmethod',
            value: selectedPaymentMethod?.paymentMethodSystemName),
      ],
    );

    /* checkoutPostSink.add(ApiResponse.loading());
    try {
      CheckoutPostResponse response = await _repository.savePaymentMethod(reqBody);
      currentStep = response.data?.nextStep ?? -1;
      checkoutPostSink.add(ApiResponse.completed(response));
    } catch (e) {
      checkoutPostSink.add(ApiResponse.error(e.toString()));
      print(e);
    }*/

    showProgressDialog();
    SuccessOrError result = await _repository.savePaymentMethod(reqBody);
    hideProgressDialog();
    if (result.success) {
      CheckoutPostResponseData response = result.response?.data;
      // currentStep = response.nextStep ?? CheckoutSteps.getStep(-1);
      checkoutPostResponseData = response;
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  Future<BasCheckoutPaymentInfo?> basPaymentInfo(
    CheckoutPostResponseData? previousData,
  ) async {
    //TODO byMe call bas payment info
    logger.d('TODO call bas payment info');
    return null;
    /*try {
      // checkoutPostSink.add(ApiResponse.loading());

      ///..1- get bas settings
      BasSettingsData basSettingsResult = await _repository.getBasSettings();
      if (basSettingsResult.data?.clientId.isNullOrEmpty == true) {
        checkoutPostSink.add(ApiResponse.error(
            basSettingsResult.message ?? 'bas settings can not be null'));
      } else {
        ///..2- pass bas settings to get auth code from [BasService.getBasAuthCode]
        /// to get AuthData
        var (AuthCodeData? authData, String? error) = await BasService.instance
            .getBasAuthCode(basSettingsResult.data!.clientId!);

        if (error.isNotNullOrEmpty) {
          logger.e(error);
          checkoutPostSink.add(ApiResponse.error(error));
          return null;
        }

        ///..3- pass AuthData to get PaymentInfo from backend;
        BasCheckoutPaymentInfo response =
            await _repository.callBasPaymentInfo(authData!.authId!);

        printBasResult('callBasPaymentInfo.response=>$response');

        return response;
        // currentStep = CheckoutConstants.ConfirmOrder;

        // checkoutPostSink.add(ApiResponse.completed(previousData));

        // checkoutPostSink.add(ApiResponse.completed(
        //   CheckoutPostResponse(
        //     data: CheckoutPostResponseData(
        //       nextStep: 6,
        //     ),
        //   ),
        // ));
        ///TODO ..4- pass PaymentInfo to call BasPayment method;
        // var (TransactionData? trxData, String? error2) = await BasService.callBasPayment(_repository.clientId);

        ///TODO..5- call CheckPaymentTransaction Status.
        // currentStep = response.data?.nextStep ?? -1;
        // logger.d(response);
      }
    } catch (e) {
      checkoutPostSink.add(ApiResponse.error(e.toString()));
      return null;
    }
    return null;*/
  }

  void gotoNextStep(CheckoutSteps step) {
    if (step == CheckoutSteps.confirmOrder) {
      getConfirmOrderData();
    } else if (step == CheckoutSteps.completed) {
      checkoutPostResponseData?.nextStep = CheckoutSteps.completed;
      checkoutPostResponseData = _checkoutPostResponseData;
    } else if (step == CheckoutSteps.doneCheckout) {
      checkoutPostResponseData?.nextStep = CheckoutSteps.doneCheckout;
      checkoutPostResponseData = _checkoutPostResponseData;
    }
  }

  void getConfirmOrderData() async {
    showProgressDialog();
    SuccessOrError result = await _repository.getConfirmOrder();
    hideProgressDialog();
    if (result.success) {
      ConfirmModel response = result.response?.data;
      // currentStep = CheckoutSteps.getStep(6);
      _updateWarningMessage(response.cart);
      checkoutPostResponseData = CheckoutPostResponseData(
        nextStep: CheckoutSteps.confirmOrder,
        confirmModel: response,
      );
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  void confirmOrder() async {

    if(warningMsg.isNotNullOrEmpty){
      buildErrorSnackBar(msg: warningMsg);
      return;
    }

    showProgressDialog();
    SuccessOrError result = await _repository.confirmOrder();
    hideProgressDialog();
    if (result.success) {
      CheckoutPostResponseData response = result.response?.data;
      _updateWarningMessage(response.confirmModel?.cart);
      // currentStep = response.nextStep ?? CheckoutSteps.getStep(-1);
      checkoutPostResponseData = response;
    } else {
      buildErrorSnackBar(msg: result.error.toString());
    }
  }

  /// Not updating UI for this API call
  orderComplete() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showProgressDialog();
      SuccessOrError result = await _repository.orderComplete();
      hideProgressDialog();
      if (result.success) {
        CheckoutPostResponseData response = result.response?.data;
        // currentStep = response.nextStep ?? CheckoutSteps.getStep(-1);
        orderId = response.completedModel?.orderId ?? 0;
        orderNumber = response.completedModel?.customOrderNumber ?? '';
        checkoutPostResponseData = response;
      } else {
        buildErrorSnackBar(msg: result.error.toString());
      }
    });
  }

  void _updateWarningMessage(Cart? cart) {
    warningMsg = '';
    var hasMinValueWaring = cart?.minOrderSubtotalWarning != null &&
        cart?.minOrderSubtotalWarning?.isNotEmpty == true;

    if (hasMinValueWaring) {
      warningMsg = '$warningMsg${cart?.minOrderSubtotalWarning ?? ''}\n';
    }
    cart?.warnings?.forEach((element) {
      warningMsg = '$warningMsg$element\n';
    });
    warningMsg?.trimRight();
  }
}

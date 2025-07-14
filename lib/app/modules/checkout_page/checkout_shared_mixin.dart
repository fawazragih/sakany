import 'package:get/get.dart';
import 'package:sakani/app/data/models/get_billing_address_response.dart';
import 'package:sakani/app/data/models/save_billing_response.dart';
import 'package:sakani/app/modules/checkout_page/checkout_controller.dart';


enum CheckoutSteps {
  doneCheckout(0,7),
  billingAddress(1,0),
  shippingAddress(2,1),
  shippingMethod(3,2),
  paymentMethod(4,3),
  paymentInfo(5,4),
  confirmOrder(6,5),
  redirectToGateway(7,6),
  completed(8,7),

// Used from order details screen
  retryPayment(123,-1);

  final int serverValue;
  final int uiIndex;

  const CheckoutSteps(this.serverValue,this.uiIndex);

  static CheckoutSteps getStep(int index) {
    return CheckoutSteps.values.firstWhereOrNull((e) => e.serverValue == index) ??
        CheckoutSteps.retryPayment;
  }
}

mixin CheckoutSharedMixin {
  CheckoutController get checkoutController => Get.find<CheckoutController>();

  GetBillingData? get billingData => checkoutController.billingData;

  ShippingAddressModel? get shippingAddress =>
      checkoutController.checkoutPostResponseData?.shippingAddressModel;

  ShippingMethodModel? get shippingMethodModel =>
      checkoutController.checkoutPostResponseData?.shippingMethodModel;

  PaymentMethodModel? get paymentMethodModel =>
      checkoutController.checkoutPostResponseData?.paymentMethodModel;

  CheckoutPostResponseData? get previousData =>
      checkoutController.checkoutPostResponseData;

  // CheckoutWebViewArgument get checkoutWebViewArgument =>
  //     CheckoutWebViewArgument(
  //       checkoutStep: checkoutController.checkoutPostResponseData?.nextStep ==
  //               CheckoutSteps.redirectToGateway
  //           ? CheckoutSteps.redirectToGateway.value
  //           : CheckoutSteps.paymentInfo.value,
  //       screenTitle: checkoutController.checkoutPostResponseData?.nextStep ==
  //               CheckoutSteps.redirectToGateway
  //           ? ConstStrings.ONLINE_PAYMENT.translate
  //           : checkoutController.selectedPaymentMethod?.name ?? '',
  //       onDone: checkoutController.checkoutPostResponseData?.nextStep ==
  //               CheckoutSteps.redirectToGateway
  //           ? onDoneRedirectToGateway
  //           : onDonePaymentInfo,
  //     );

/*  onDonePaymentInfo(int? nextStep) {
    int nextStepInt = int.tryParse(nextStep.toString()) ?? 0;
    logger.w('nextStepInt: $nextStepInt');
    if (nextStepInt == 0) {
      // nextStep 0 in payment info means server can't identify the customer from the WebView. This is backend bug.
      checkoutController.buildErrorSnackBar(
        msg: ConstStrings.COMMON_SOMETHING_WENT_WRONG.translate,
      );
    } else {
      checkoutController.gotoNextStep(CheckoutSteps.getStep(nextStepInt));
    }
  }*/

/* onDoneRedirectToGateway(int? orderId) {
    logger.w('orderId: $orderId');
    if (orderId != null && orderId > 0) {
      checkoutController.orderId = orderId;
      checkoutController.gotoNextStep(CheckoutSteps.leaveCheckout);
    } else {
      checkoutController.gotoNextStep(CheckoutSteps.completed);
    }
  }*/

  ConfirmModel? get confirmModel =>
      checkoutController.checkoutPostResponseData?.confirmModel;
}

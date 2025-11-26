import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/api_providers/base_configs/api_paths.dart';
import 'package:tamoily/app/data/api_providers/base_configs/app_dio_interceptor.dart';
import 'package:tamoily/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:tamoily/app/modules/checkout_page/widgets/checkout_web_view/arguments/checkout_web_view_argument.dart';
import '../../../../utils/api_env_config/app_logger_config.dart';
import '../../../../utils/constants/const_strings.dart';

class StepCheckoutWebViewController extends BaseController
    with CheckoutSharedMixin {
  final CookieManager cookieManager = CookieManager.instance();

  RxInt progress = RxInt(0);
  final InAppWebViewSettings options = InAppWebViewSettings(
    //region android AndroidInAppWebViewOptions
    useHybridComposition: true,
    thirdPartyCookiesEnabled: true,
    //endregion

    //region ios IOSInAppWebViewOptions
    allowsInlineMediaPlayback: true,
    sharedCookiesEnabled: true,
    //endregion

    //region crossPlatform InAppWebViewOptions
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    javaScriptCanOpenWindowsAutomatically: true,
    javaScriptEnabled: true,
    userAgent:
        "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
    disableContextMenu: true,
    // enterpriseAuthenticationAppLinkPolicyEnabled:
    //endregion
  );

  Map<String, String>? headers ;
  Future<bool> clearCookie() async {
    await cookieManager.deleteAllCookies();
    headers = await AppAuthInterceptor.getRequestHeader;
    return true;
  }

  //TODO handle arguments when come from orderDetail page.
  CheckoutWebViewArgument? argument;

  @override
  void onInit() {
    super.onInit();
    argument = CheckoutWebViewArgument.fromJson(Get.parameters);
  }


  String get url {
    var url = checkoutStep == CheckoutSteps.paymentInfo.serverValue
        ? ApiEndpoints.paymentInfoUrl
        : ApiEndpoints.redirectUrl;

    // add order id in case of repost payment
    if (checkoutStep == CheckoutSteps.retryPayment.serverValue) {
      //TODO handle argument?.orderId when come from orderDetail page.
      url = '$url&orderId=${argument?.orderId}';
    }
    return url;
  }

  int get checkoutStep =>
      //TODO handle argument?.action when come from orderDetail page.
      (checkoutController.checkoutPostResponseData?.nextStep ==
              CheckoutSteps.redirectToGateway
          ? CheckoutSteps.redirectToGateway.serverValue
          : CheckoutSteps.paymentInfo.serverValue);

  String get screenTitle =>
      //TODO handle argument?.screenTitle when come from orderDetail page.
      checkoutController.checkoutPostResponseData?.nextStep ==
              CheckoutSteps.redirectToGateway
          ? ConstStrings.ONLINE_PAYMENT.translate
          : checkoutController.selectedPaymentMethod?.name ?? '';

  get onDone => checkoutController.checkoutPostResponseData?.nextStep ==
          CheckoutSteps.redirectToGateway
      ? onDoneRedirectToGateway
      : onDonePaymentInfo;

  onDonePaymentInfo(int? nextStep) {
    int nextStepInt = int.tryParse(nextStep.toString()) ?? 0;
    logger.w('nextStepInt: $nextStepInt');
    if (nextStepInt == 0) {
      // nextStep 0 in payment info means server can't identify the customer from the WebView. This is backend bug.
      buildErrorSnackBar(
        msg: ConstStrings.COMMON_SOMETHING_WENT_WRONG.translate,
      );
    } else {
      checkoutController.gotoNextStep(CheckoutSteps.getStep(nextStepInt));
    }
  }

  onDoneRedirectToGateway(int? orderId) {
    logger.w('orderId: $orderId');
    if (orderId != null && orderId > 0) {
      checkoutController.orderId = orderId;
      checkoutController.gotoNextStep(CheckoutSteps.doneCheckout);
    } else {
      checkoutController.gotoNextStep(CheckoutSteps.completed);
    }
  }
}

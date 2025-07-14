import 'package:bas_sdk/bas_sdk.dart';
import 'package:flutter/foundation.dart';

class BasService {
  BasService._();

  static final BasService instance = BasService._();

  final BasSDK _bas = BasSDK();

  //region init and check if app is in bas super app
  final bool _useBasSdk = true;

  // set useBasSdk(bool value) {
  //   _useBasSdk = value;
  // }

  bool get inBasApp => kIsWeb && _useBasSdk == true;

  /* BasEnvType _envType = BasEnvType.stage;

  initBasEnvType(BasEnvType? envType) {
    _envType = envType ?? BasEnvType.stage;
  }*/

  // BasMode _envType = BasMode.stage;
  // initBasEnvType(BasMode? envType) {
  //   _envType = envType ?? BasMode.stage;
  // }

  initAndStartCheckIfIsInBasSuperApp() async {

    // var res=  await _bas.onReady(mode: BasMode.sandbox);
    // printBasResult('onReady.res=>${res.toJson().toString() }');

    // return ;

    BasSuperAppConfigs? basSuperAppConfigs = await _bas.onReady(mode: BasMode.sandbox);
    printBasResult(basSuperAppConfigs.toJson().toString() ?? '');

    // initBasEnvType(basSuperAppConfigs?.envType);

    if (basSuperAppConfigs.status == 1 &&
        basSuperAppConfigs.isInBasSuperApp == true) {
      //TODO handle this
      // useBasSdk = basSuperAppConfigs.isInBasSuperApp ?? false;
      printBasResult('useBasSdk=>$_useBasSdk');
      if (basSuperAppConfigs.locale != null &&
          basSuperAppConfigs.locale?.isNotEmpty == true) {
        // Get.find<AppLanguage>()
        //     .changeLanguage(Locale(basSuperAppConfigs.locale));
        //TODO change app lang depend on bas super app lang.
      }
    }
  }

  //endregion.............

  Future<(AuthCodeData?, String?)> getBasAuthCode(String basClientId) async {
    printBasResult("bas.fetchAuthCode with $basClientId");
    // printBasResult("bas.fetchAuthCode STARTED");

    AuthCode? basAuthIdResult = await _bas.fetchAuthCode(clientId: basClientId);
    // printBasResult("bas.fetchAuthCode Result status :${basAuthIdResult?.status}");
    // printBasResult("bas.fetchAuthCode Result messages :${basAuthIdResult?.messages}");
    printBasResult(
        "bas.fetchAuthCode Result data :${basAuthIdResult?.toJson()}");

    if (basAuthIdResult?.status == 1 && basAuthIdResult?.data?.authId != null) {
      return (basAuthIdResult?.data, null);
    } else {
      return (null, basAuthIdResult?.messages?.join(','));
      // buildFailedSnackBar(msg: basAuthIdResult.messages.join(','));
    }
  }

  Future<(TransactionData?, String?)> callBasPayment(
      String amount,
      String orderId,
      String trxToken,
      String basAppId,
      String? currency) async {
    printBasResult("callBasPayment STARTED");
    try {
      Transaction? basTransactionResult = await _bas.payment(
        amount: amount,
        currency: currency ?? 'YER',
        orderId: orderId,
        trxToken: trxToken,
        appId: basAppId,
      );
      printBasResult("=================================================");
      printBasResult("callBasPayment status:${basTransactionResult?.status}");
      printBasResult(
          "callBasPayment messages :${basTransactionResult?.messages}");
      printBasResult(
          "callBasPayment data :${basTransactionResult?.data?.toJson()}");
      printBasResult("callBasPayment Go call check order status");
      printBasResult("=================================================");
      if (basTransactionResult?.status == 1 &&
          basTransactionResult?.data != null) {
        return (basTransactionResult?.data, null);
      } else {
        printBasResult(
            "////////// callBasPayment error in call bas payment return data//////");
        return (null, basTransactionResult?.messages?.join(','));
      }
    } catch (e) {
      printBasResult('callBasPayment.error=>${e.toString()}');
      return (null, e.toString());
    }
  }
}

printBasResult(String message) {
  // if (kDebugMode) {
    print(message);
  // }
}

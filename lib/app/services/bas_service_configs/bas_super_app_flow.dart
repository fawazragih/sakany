
//TODO byMe call and handle all this code
class BasSuperAppFlow {
  // static loginFlow(AuthBloc authBlock, BuildContext context) async {
  //   DialogBuilder(context).showLoader();
  //
  //   ApiResponse<UserLoginData> event =
  //       await authBlock.newPostLoginWithBasAuth();
  //
  //   DialogBuilder(context).hideLoader();
  //
  //   printBasResult('basLoginFlow.event=>${event.data?.toJson()}');
  //   printBasResult('event.status=>${event.status}');
  //   if (event.status == Status.ERROR) {
  //     printBasResult('eventError=>${event.message}');
  //     showSnackBar(context, event.message ?? "", true);
  //   } else /*if (event.status == Status.COMPLETED)*/ {
  //     printBasResult('start handle post login response');
  //
  //     if (event.data!.needToRegister == true &&
  //         event.data!.basUserInfo != null) {
  //       // logger.d('needToRegister=>${event.data?.needToRegister}');
  //       printBasResult('needToRegister=>${event.data?.needToRegister}');
  //       printBasResult('basUserInfo=>${event.data?.basUserInfo?.toJson()}');
  //       DialogBuilder(context).hideLoader();
  //       Navigator.of(context)
  //           .pushNamed(
  //         RegistrationScreen.routeName,
  //         arguments: RegistrationScreenArguments(
  //           getCustomerInfo: false,
  //           completeRegisterWithBasUserData: true,
  //           basUserInfo: event.data?.basUserInfo,
  //         ),
  //       )
  //           .then((value) {
  //         printBasResult('login after register with value=>$value');
  //         if (value is Map) {
  //           printBasResult('value is Map');
  //           authBlock.newPostLoginWithBasAuth();
  //           // _bloc.postLoginFormData(LoginFormData(
  //           //   password: value['pass'],
  //           //   email: value['email'],
  //           // ));
  //         }
  //       });
  //       return;
  //     }
  //
  //     // save user session & goto home
  //     if (event.data?.token != null && event.data?.customerInfo != null) {
  //       var session = SessionData();
  //       session
  //           .setUserSession(event.data!.token!, event.data!.customerInfo)
  //           .then((value) {
  //         DialogBuilder(context).hideLoader();
  //         Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
  //       });
  //     }
  //   }
  // }
  //
  // static final _globalService = GlobalService();
  //
  // static onConfirmPayment(
  //     BuildContext context, String orderPaymentInfoTempKey) async {
  //   try {
  //     DialogBuilder(context).showLoader();
  //
  //     var (BasCheckoutConfirm? result, String? err) =
  //         await callConfirmApi(orderPaymentInfoTempKey);
  //
  //     if (err.isNotNullOrEmpty) {
  //       DialogBuilder(context).hideLoader();
  //       showSnackBar(
  //         context,
  //         _globalService.getString(err.toString()),
  //         true,
  //       );
  //       return;
  //     } else {
  //       if (result?.data?.customOrderNumber.isNotNullOrEmpty == true) {
  //         printBasResult(
  //             'onConfirm.customOrderNumber=>${result!.data?.customOrderNumber}');
  //         var (BasCheckoutStatus? firstStatus, String? err) =
  //             await callCheckStatus(result.data!.customOrderNumber!);
  //
  //         if (err.isNotNullOrEmpty) {
  //           DialogBuilder(context).hideLoader();
  //           showSnackBar(
  //             context,
  //             _globalService.getString(err.toString()),
  //             true,
  //           );
  //           return;
  //         }
  //
  //         printBasResult(
  //             'basCheckoutStatus.firstStatus=>${firstStatus?.toJson()}');
  //
  //         if (firstStatus?.data?.status == 0) {
  //           DialogBuilder(context).hideLoader();
  //           callBasPayment(
  //             firstStatus!.data!.confirmData!,
  //             context,
  //           );
  //         } else {
  //           // setHasError(firstStatus?.message ?? '');
  //           DialogBuilder(context).hideLoader();
  //           showSnackBar(
  //             context,
  //             firstStatus?.message ?? 'firstStatus?.data?.status != 0',
  //             true,
  //           );
  //         }
  //       } else {
  //         DialogBuilder(context).hideLoader();
  //         // setHasError(error)
  //         showSnackBar(
  //           context,
  //           'customOrderNumber can not be null',
  //           true,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     showSnackBar(
  //       context,
  //       e.toString(),
  //       true,
  //     );
  //     printBasResult('BasCheckoutConfirm.error=>$e');
  //     DialogBuilder(context).hideLoader();
  //   }
  // }
  //
  // static Future<(BasCheckoutConfirm?, String? err)> callConfirmApi(
  //     String orderPaymentInfoTempKey) async {
  //   try {
  //     var response = await ApiBaseHelper()
  //         .post(Endpoints.basCheckoutConfirm(orderPaymentInfoTempKey), null);
  //     // printBasResult('callConfirmApi.response=>$response');
  //     BasCheckoutConfirm result = BasCheckoutConfirm.fromJson(response);
  //     printBasResult('callConfirmApi.result=>${result.toJson()}');
  //     return (result, null);
  //   } catch (e) {
  //     printBasResult('callConfirmApi.error=>$e');
  //     return (null, e.toString());
  //   }
  // }
  //
  // static Future<(BasCheckoutStatus?, String? err)> callCheckStatus(
  //   String orderId,
  // ) async {
  //   try {
  //     var statusResponse1 =
  //         await ApiBaseHelper().get(Endpoints.basCheckoutStatus(orderId));
  //     printBasResult('basCheckoutStatus.statusResponse1=>$statusResponse1');
  //     BasCheckoutStatus firstStatus =
  //         BasCheckoutStatus.fromJson(statusResponse1);
  //     printBasResult('basCheckoutStatus.firstStatus=>${firstStatus.toJson()}');
  //     return (firstStatus, null);
  //   } catch (e) {
  //     printBasResult('basCheckoutStatus.Error=>${e.toString()}');
  //     return (null, e.toString());
  //   }
  // }
  //
  // static callBasPayment(Order firstStatus, BuildContext context) async {
  //   printBasResult('start callBasPayment');
  //   String? amount = firstStatus.amount?.value?.toString();
  //   String? currency = firstStatus.amount?.currency?.toString();
  //   String? orderId = firstStatus.orderId;
  //   String? trxToken = firstStatus.transactionToken;
  //   String? appId = firstStatus.appId;
  //
  //   if (amount.isNotNullOrEmpty &&
  //       orderId.isNotNullOrEmpty &&
  //       trxToken.isNotNullOrEmpty &&
  //       appId.isNotNullOrEmpty) {
  //     var (TransactionData? trxData, String? error) =
  //         await BasService.instance.callBasPayment(
  //       amount!,
  //       orderId!,
  //       trxToken!,
  //       appId!,
  //       currency,
  //     );
  //
  //     if (error.isNotNullOrEmpty) {
  //       showSnackBar(
  //         context,
  //         error!,
  //         true,
  //       );
  //     } else {
  //       DialogBuilder(context).showLoader();
  //       var (BasCheckoutStatus? result, String? err) =
  //           await callCheckStatus(trxData!.orderId);
  //       DialogBuilder(context).hideLoader();
  //
  //       if (err.isNotNullOrEmpty) {
  //         showSnackBar(
  //           context,
  //           error!,
  //           true,
  //         );
  //         return;
  //       }
  //
  //       if (result?.data?.status == 1) {
  //         printBasResult(
  //             'originalOrderId=>${result?.data?.confirmData?.originalOrderId}');
  //         _globalService.updateCartCount(0);
  //         showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (context) {
  //             return orderCompleteDialog(
  //               result?.data?.confirmData?.originalOrderId,
  //               context,
  //             );
  //           },
  //         );
  //       } else {
  //         showSnackBar(
  //           context,
  //           result?.message ?? 'result?.data?.status != 1',
  //           false,
  //         );
  //       }
  //     }
  //   } else {
  //     showSnackBar(
  //       context,
  //       '[amount,orderId,trxToken,appId] must have a value',
  //       true,
  //     );
  //     return;
  //   }
  // }
  //
  // static Widget orderCompleteDialog(int? orderId, BuildContext context) {
  //   // String content = orderId == null
  //   // ? _globalService.getString(Const.ORDER_PROCESSED)
  //   // : _globalService.getString(Const.ORDER_PROCESSED) +
  //   //     (orderId > 0
  //   //         ? '\n${_globalService.getString(Const.ORDER_NUMBER)}: ...'
  //   //         : '');
  //
  //   String content = _globalService.getString(Const.ORDER_PROCESSED);
  //
  //   return WillPopScope(
  //     child: AlertDialog(
  //       title: Text(_globalService.getString(Const.THANK_YOU)),
  //       content: Text(content),
  //       actions: [
  //         if (orderId != null && orderId > 0)
  //           TextButton(
  //             onPressed: () {
  //               // clear stack and go to order details page
  //               Navigator.of(context).pushNamedAndRemoveUntil(
  //                 OrderDetailsScreen.routeName,
  //                 (route) => route.isFirst,
  //                 arguments: OrderDetailsScreenArguments(orderId: orderId),
  //               );
  //             },
  //             child: Text(_globalService.getString(Const.TITLE_ORDER_DETAILS)),
  //           ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).popUntil(
  //                 (route) => route.settings.name == TabsScreen.routeName);
  //           },
  //           child: Text(_globalService.getString(Const.CONTINUE)),
  //         ),
  //       ],
  //     ),
  //     onWillPop: () async {
  //       return false;
  //     },
  //   );
  // }
}

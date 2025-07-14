import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/loading_progress_bar.dart';
import 'package:sakani_mobile_app/app/modules/checkout_page/widgets/checkout_web_view/checkout_web_view_controller.dart';

class CheckoutWebViewStep extends StatelessWidget {
  static const routeName = '/app/checkoutWebView';

  const CheckoutWebViewStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StepCheckoutWebViewController>(
        init: StepCheckoutWebViewController(),
        builder: (controller) {
          return FutureBuilder(
            future: controller.clearCookie(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data == true) {
                return Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri(controller.url),
                        headers: controller.headers,
                      ),
                      onReceivedServerTrustAuthRequest:
                          (controller, challenge) async {
                        // Allow web view to proceed even if the certificate is invalid
                        // Allow all certificates
                        return ServerTrustAuthResponse(
                            action: ServerTrustAuthResponseAction.PROCEED);
                      },
                      initialSettings: controller.options,
                      onWebViewCreated: (inAppWebViewController) async {
                        await inAppWebViewController.setSettings(
                            settings: controller.options);
                      },
                      onProgressChanged: (controllerInApp, progress) {
                        controller.progress.value = progress;
                      },
                      onLoadStop: (inAppWebViewController, mUrl) async {
                        final url = mUrl.toString();
                        if (url.contains("/step/")) {
                          var nextStep = url[url.length - 1];
                          // Get.back(result: nextStep);
                          controller.onDone?.call(int.tryParse(nextStep ?? ''));
                        } else if (url.contains("/completed/")) {
                          // || url.contains("/orderdetails")

                          int orderId = int.tryParse(url.split('/').last) ?? -1;
                          // Navigator.pop(context, orderId);
                          controller.onDone?.call(orderId);
                        }
                      },
                    ),
                    Obx(() {
                      return controller.progress.value < 100
                          ? Positioned.fill(
                              child: Container(
                                alignment: Alignment.center,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: LoadingProgressBar(),
                              ),
                            )
                          : Offstage();
                    }),
                  ],
                );
              }
              return Center(child: LoadingProgressBar());
            },
          );
        },
      ),
    );
  }
}

// class _CheckoutWebViewState extends State<CheckoutWebView> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text('not Available inside bas app'),
//       ),
//     );
//   }
// }

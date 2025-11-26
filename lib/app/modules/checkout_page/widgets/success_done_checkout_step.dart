import 'package:animate_do/animate_do.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:tamoily/app/modules/orders_pages/order_details_page/order_details_view.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

import '../../tabs_screen/tabs_screen_view.dart';

class SuccessDoneCheckoutStep extends StatelessWidget with CheckoutSharedMixin {
  const SuccessDoneCheckoutStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Pulse(
              // key: UniqueKey(),
              infinite: true,
              delay: Duration(milliseconds: 500),
              duration: Duration(seconds: 10),
              child: Icon(
                CupertinoIcons.check_mark_circled,
                size: 70.sp,
                color: Colors.green,
              ),
            ),
            UiHelper.verticalSpaceLarge,
            Text(
              ConstStrings.THANK_YOU.translate,
              style: Theme.of(context).textTheme.titleLarge.withBoldFont,
            ),
            UiHelper.verticalSpaceSmallMedium,
            Text(
              ConstStrings.ORDER_PROCESSED.translate +
                  (checkoutController.orderId > 0
                      ? '\n${ConstStrings.ORDER_NUMBER.translate}: ${checkoutController.orderNumber}'
                      : ''),
              style: Theme.of(context).textTheme.labelLarge.withBoldFont,
              textAlign: TextAlign.center,
            ),
            if (checkoutController.orderId > 0) ...[
              UiHelper.verticalSpaceSmallMedium,
              ActionButton(
                isOutLined: true,
                onPressed: () {
                  Get.offNamedUntil(
                    OrderDetailsPage.navToRoute(
                        checkoutController.orderId.toString()),
                    (route) =>
                        route.isFirst ||
                        route.settings.name == TabsScreenView.routeName,
                  );
                },
                text: ConstStrings.TITLE_ORDER_DETAILS.translate,
              ),
            ],
            UiHelper.verticalSpaceSmallMedium,
            ActionButton(
              onPressed: () {
                // Navigator.of(context).popUntil((route) => route.isFirst);
                Get.offNamedUntil(
                  TabsScreenView.routeName,
                  (route) =>
                      route.isFirst ||
                      route.settings.name == TabsScreenView.routeName,
                );
              },
              text: ConstStrings.CONTINUE.translate,
            ),
          ],
        ),
      ),
    );
    // return WillPopScope(
    //   child: AlertDialog(
    //     title: Text(ConstStrings.THANK_YOU.translate),
    //     content: Text(
    //       ConstStrings.ORDER_PROCESSED.translate +
    //           (orderId > 0
    //               ? '\n${ConstStrings.ORDER_NUMBER.translate}: ${controller.orderNumber}'
    //               : ''),
    //     ),
    //     actions: [
    //       if (orderId > 0)
    //         TextButton(
    //           onPressed: () {
    //             // clear stack and go to order details page
    //             // Navigator.of(context).pushNamedAndRemoveUntil(
    //             //   OrderDetailsPage.routeName,
    //             //   (route) => route.isFirst,
    //             //   arguments: OrderDetailsScreenArguments(orderId: orderId),
    //             // );
    //
    //             Get.offNamedUntil(
    //               OrderDetailsPage.navToRoute(orderId.toString()),
    //               (route) =>
    //                   route.isFirst ||
    //                   route.settings.name == TabsScreenView.routeName,
    //             );
    //           },
    //           child: Text(
    //             ConstStrings.TITLE_ORDER_DETAILS.translate,
    //           ),
    //         ),
    //       TextButton(
    //         onPressed: () {
    //           // Navigator.of(context).popUntil((route) => route.isFirst);
    //           Get.offNamedUntil(
    //             TabsScreenView.routeName,
    //             (route) =>
    //                 route.isFirst ||
    //                 route.settings.name == TabsScreenView.routeName,
    //           );
    //         },
    //         child: Text(
    //           ConstStrings.CONTINUE.translate,
    //         ),
    //       ),
    //     ],
    //   ),
    //   onWillPop: () async {
    //     return false;
    //   },
    // );
  }
}

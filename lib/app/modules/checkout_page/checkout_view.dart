import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/core/language_and_localization/app_strings.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:tamoily/app/modules/checkout_page/widgets/checkout_web_view/checkout_web_view.dart';
import 'package:tamoily/app/modules/checkout_page/widgets/success_done_checkout_step.dart';
import 'package:tamoily/app/modules/checkout_page/widgets/confirm_order_step.dart';
import 'package:tamoily/app/modules/checkout_page/widgets/payment_method_step.dart';
import 'package:tamoily/app/modules/checkout_page/widgets/shipping_method_step.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import '../../global_widget/loading_progress_bar.dart';
import '../../global_widget/retry_and_errors_widgets/retry_widget.dart';
import 'checkout_controller.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'checkout_shared_mixin.dart';
import 'widgets/billing_shipping_addresses/billing_address_step.dart';
import 'widgets/billing_shipping_addresses/shipping_address_step.dart';

class CheckoutPage extends GetView<CheckoutController> {
  static const String routeName = '/app/checkout';

  const CheckoutPage({super.key});

  //leaveCheckout = 0;

  //billingAddress = 1;
  //shippingAddress = 2;
  //shippingMethod = 3;
  //paymentMethod = 4;
  //paymentInfo = 5;
  //confirmOrder = 6;

  //redirectToGateway = 7;
  //completed = 8;

  List<Map<String, dynamic>> get tabsDataList => [
        {
          'step': CheckoutSteps.billingAddress,
          'iconData': Icons.share_location_rounded,
          'title': ConstStrings.BILLING_ADDRESS_TAB.translate.capitalizeFirst!,
        },
        {
          'step': CheckoutSteps.shippingAddress,
          'iconData': Icons.pin_drop_outlined,
          'title': ConstStrings.SHIPPING_ADDRESS_TAB.translate.capitalizeFirst!,
        },
        {
          'step': CheckoutSteps.shippingMethod,
          'iconData': Icons.local_shipping_outlined,
          'title': ConstStrings.SHIPPING_METHOD.translate.capitalizeFirst!,
        },
        {
          'step': CheckoutSteps.paymentMethod,
          'iconData': Icons.attach_money_sharp,
          'title': ConstStrings.PAYMENT_METHOD.translate.capitalizeFirst!,
        },
        {
          'step': CheckoutSteps.paymentInfo,
          'iconData': Icons.account_balance_outlined,
          'title': AppStrings.paymentInfo.translate.capitalizeFirst!,
        },
        {
          'step': CheckoutSteps.confirmOrder,
          'iconData': Icons.checklist_outlined,
          'title': ConstStrings.CONFIRM_TAB.translate.capitalizeFirst!,
        },
        // {
        //   'step': CheckoutSteps.completed,
        //   'iconData': Icons.check_circle_outline_outlined,
        //   'title': AppStrings.completedTab.translate.capitalizeFirst!,
        // },
        {
          'step': CheckoutSteps.doneCheckout,
          'iconData': Icons.check_circle_outline_outlined,
          'title': AppStrings.success.translate.capitalizeFirst!,
        },
        // {
        //   'iconData': Icons.payment_outlined,
        //   'title': ConstStrings.PAYMENT_TAB.translate.capitalizeFirst!,
        // },
      ];

  @override
  Widget build(BuildContext context) {
    // logger.d(controller.currentIndex);
    return Scaffold(
      appBar: CustomAppBar(
        showCartIcon: false,
        title: ConstStrings.CHECKOUT.translate.capitalizeFirst!,
        color: Colors.transparent,
        forgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: GetBuilder<CheckoutController>(
        builder: (controller) {
          return controller.busy
              ? const Center(
                  child: LoadingProgressBar(),
                )
              : controller.showRetryButton
                  ? RetryWidget(
                      onRetry: controller.fetchBillingAddress,
                    )
                  : Column(
                      children: [
                        CheckoutStepper(
                          // activeStep:  controller.currentIndex,
                          activeStep: controller.currentStep,
                          tabsDataList: tabsDataList,
                        ),
                        Expanded(
                          child: Container(
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(32.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, -1),
                                  blurRadius: 32,
                                  // spreadRadius: 10,
                                  color: Get.theme.dividerColor,
                                )
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CheckoutStepContentWidget(
                              step: controller.currentStep,
                            ),
                            // child: CheckoutConstants.widgetList[controller.currentIndex]

                            // child: IndexedStack(
                            //   index: controller.currentIndex,
                            //   children: CheckoutConstants.widgetList,
                            // ),
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}

class CheckoutStepContentWidget extends StatelessWidget {
  final CheckoutSteps step;

  const CheckoutStepContentWidget({
    super.key,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case CheckoutSteps.doneCheckout:
        return SuccessDoneCheckoutStep();
      case CheckoutSteps.billingAddress:
        return BillingAddressStep();
      case CheckoutSteps.shippingAddress:
        return ShippingAddressStep();
      case CheckoutSteps.shippingMethod:
        return ShippingMethodStep();
      case CheckoutSteps.paymentMethod:
        return PaymentMethodStep();
      case CheckoutSteps.paymentInfo:
        return CheckoutWebViewStep();
      case CheckoutSteps.confirmOrder:
        return ConfirmOrderStep();
      case CheckoutSteps.redirectToGateway:
        return CheckoutWebViewStep();
      case CheckoutSteps.completed:
        Get.find<CheckoutController>().orderComplete();
        return Center(child: LoadingProgressBar());
      case CheckoutSteps.retryPayment:
        return CheckoutWebViewStep();
    }
  }
}

class CheckoutStepper extends StatelessWidget {
  // final int activeStep;
  final CheckoutSteps activeStep;
  final List<Map<String, dynamic>> tabsDataList;

  const CheckoutStepper(
      {super.key, required this.activeStep, required this.tabsDataList});

  @override
  Widget build(BuildContext context) {
    Color activeColor = Theme.of(context).colorScheme.primary;
    Color unActiveColor = Theme.of(context).dividerColor;

    return EasyStepper(
      // key: UniqueKey(),
      activeStep: activeStep.uiIndex,
      stepShape: StepShape.rRectangle,
      defaultStepBorderType: BorderType.dotted,
      stepBorderRadius: 12.r,
      // borderThickness: 8.0,
      // fitWidth: true,
      finishedStepBorderColor: Theme.of(context).colorScheme.secondary,
      finishedStepTextColor: Theme.of(context).colorScheme.secondary,
      finishedStepBackgroundColor: Colors.transparent,
      activeStepIconColor: activeColor,
      activeStepBorderColor: activeColor,
      showLoadingAnimation: false,
      padding: EdgeInsets.zero,
      // padding: EdgeInsets.symmetric(
      //   vertical: 0,
      //   horizontal: 0.0,
      // ),
      // internalPadding: 0,
      stepRadius: 20,
      enableStepTapping: false,
      alignment: Alignment.topCenter,
      lineStyle: LineStyle(),
      // onStepReached: (index) => setState(() => activeStep = index),
      // titlesAreLargerThanSteps: false,
      steps: tabsDataList.asMap().entries.map((e) {
        return EasyStep(
          topTitle: false,
          customStep: Opacity(
            opacity: activeStep.uiIndex == e.key ? 1 : 0.3,
            child: Icon(
              activeStep.uiIndex > e.key ? Icons.check : e.value['iconData'],
            ),
          ),
          customTitle: Opacity(
            opacity: activeStep.uiIndex == e.key ? 1 : 0.3,
            child: Text(
              e.value['title'] ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.withBoldFont,
            ),
          ),
        );
      }).toList(),
    );
  }
}

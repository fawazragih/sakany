import 'package:app_extensions/app_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/images_and_videos_widgets/app_image_loader.dart'
    show AppImageLoader;
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'package:tamoily/app/services/bas_service_configs/bas_service.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

import '../../../core/language_and_localization/app_strings.dart';
import 'checkout_web_view/check_payment_method.dart';

class PaymentMethodStep extends StatefulWidget {
  const PaymentMethodStep({super.key});

  @override
  State<PaymentMethodStep> createState() => _PaymentMethodStepState();
}

class _PaymentMethodStepState extends State<PaymentMethodStep>
    with CheckoutSharedMixin {
  // PaymentMethodModel? paymentMethodModel;

  @override
  void initState() {
    super.initState();

    if (BasService.instance.inBasApp) {
      paymentMethodModel?.paymentMethods?.removeWhere(
        (e) => e.paymentMethodSystemName != 'Payments.KitsysBAS',
      );
    }

    checkoutController.selectedPaymentMethod = paymentMethodModel
            ?.paymentMethods
            ?.firstWhereOrNull((element) => element.selected == true) ??
        paymentMethodModel?.paymentMethods?.firstOrNull;

    checkoutController.userRewardPoint =
        paymentMethodModel?.useRewardPoints ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding,
        child: paymentMethodModel?.paymentMethods?.isNotEmpty == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.pleaseSelectYourPreferredPaymentMethod.translate
                        .capitalizeFirst!,
                    style: Theme.of(context).textTheme.labelMedium.withBoldFont,
                  ).marginSymmetric(
                    vertical: 16.0.h,
                  ),
                  if (paymentMethodModel?.displayRewardPoints ?? false)
                    CheckboxListTile(
                      value: checkoutController.userRewardPoint,
                      title: Text(
                        ConstStrings.USE_REWARD_POINTS.translate
                            .replaceFirst(
                              '{0}',
                              paymentMethodModel?.rewardPointsBalance
                                      ?.toString() ??
                                  '0',
                            )
                            .replaceFirst(
                              '{1}',
                              paymentMethodModel?.rewardPointsAmount ?? '0',
                            ),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            checkoutController.userRewardPoint = value;
                          });
                        }
                      },
                    ),
                  if (paymentMethodModel?.useRewardPoints ?? false) Divider(),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: paymentMethodModel?.paymentMethods?.length ?? 0,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 12.0.h,
                    ),
                    itemBuilder: (context, index) {
                      var method = paymentMethodModel?.paymentMethods?[index];
                      var fee = method?.fee?.isNotEmpty == true
                          ? '(${method?.fee})'
                          : '';
                      return AppCard(
                        onTap: () {
                          setState(() {
                            checkoutController.selectedPaymentMethod = method;
                          });
                        },
                        borderColor:
                            method == checkoutController.selectedPaymentMethod
                                ? Theme.of(context).colorScheme.primary
                                : null,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0.w,
                          vertical: 8.0.h,
                        ),
                        child: Row(
                          children: [
                            AppImageLoader(
                              imageUrl: method?.logoUrl ?? 'http://',
                              width: 60,
                              height: 60,
                              shape: BoxShape.circle,
                              // fit: BoxFit.cover,
                              // backgroundColor: Theme.of(context).primaryColorDark,
                              borderColor:
                                  Theme.of(context).colorScheme.secondary,
                              // borderWidth: 0.5,
                            ),
                            UiHelper.horizontalSpaceSmall,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${method?.name} $fee',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        .withBoldFont,
                                  ),
                                  UiHelper.verticalSpaceSmall,
                                  Text(method?.description ?? '',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.labelSmall
                                      // .withBoldFont,
                                      )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ConstStrings.COMMON_NO_DATA.translate,
                ),
              ),
      ),
      bottomNavigationBar: ActionButton(
        text: ConstStrings.CONTINUE.translate.toUpperCase(),
         onPressed: () async {
        //   if (checkoutController.selectedPaymentMethod?.name == "TamwelyPay") {
        //     print('Please select payment method');
        //     final result = await showAccountBottomSheet(context);
        //
        //     if (result == false) {
        //       print("اختار: لا");
        //     } else if (result is Map) {
        //       print("تم: ${result['accountNumber']} - ${result['value1']} - ${result['value2']} - ${result['value3']}");
        //     }
        //
        //   }
        //   return;
          if (checkoutController
                  .selectedPaymentMethod?.paymentMethodSystemName ==
              'Payments.KitsysBAS') {
            checkoutController.basPaymentInfo(previousData).then((value) {
              // DialogBuilder(context).hideLoader();
              printBasResult('value is bool && value=>$value');

              String? orderPaymentInfoTempKey =
                  value?.data?.customProperties?.orderPaymentInfoTempKey;

              if (orderPaymentInfoTempKey.isNotNullOrEmpty) {
                //TODO byMe call BasSuperAppFlow.onConfirmPayment;
                logger.d('TODO call BasSuperAppFlow.onConfirmPayment');
                // BasSuperAppFlow.onConfirmPayment(
                //   context,
                //   orderPaymentInfoTempKey!,
                // );
              }
            });
          } else {
            checkoutController.savePaymentMethod();
          }
        },
      ).paddingSymmetric(
        horizontal: SharedStyle.horizontalScreenPadding,
        vertical: 12.0,
      ),
    );
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/app_landing_response.dart';
import 'package:sakani/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/app_back_button.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

import 'change_default_currency_controller.dart';

class ChangeDefaultCurrencyWidget extends StatelessWidget {
  const ChangeDefaultCurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: SharedStyle.bottomSheetShape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Directionality(
            textDirection:
                ConstStrings.SETTINGS_CURRENCY.translate.getTextDirection,
            child: Row(
              children: [
                Text(
                  ConstStrings.SETTINGS_CURRENCY.translate,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium.withBoldFont,
                ),
                Spacer(),
                AppBackButton(
                  onlyIcon: false,
                  radius: 14.r,
                  padding: EdgeInsets.all(4),
                  backgroundColor: Theme.of(context).primaryColorLight,
                  iconColor: Theme.of(context).disabledColor,
                  iconData: CupertinoIcons.xmark,
                  iconSize: 20.sp,
                ),
              ],
            ).marginSymmetric(
              horizontal: SharedStyle.horizontalScreenPadding,
              vertical: 24.h,
            ),
          ),
          Flexible(
            child: GetBuilder<ChangeDefaultCurrencyController>(
              init: ChangeDefaultCurrencyController(),
              builder: (controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.currencyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          AvailableCurrencies currency =
                              controller.currencyList[index];
                          return RadioListTile<int?>(
                            value: currency.id,
                            groupValue: controller.currentCurrencyId,
                            onChanged: controller.changeDefaultCurrency,
                            title: Text(
                              '${currency.name.translate} (${currency.currencySymbol})',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  .withBoldFont,
                            ),
                            dense: true,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: SharedStyle.bottomNavigationPadding,
                      child: ActionButton(
                        btnController: controller.btnController,
                        text: ConstStrings.CONFIRM_BUTTON.translate,
                        onPressed: controller.confirmDefaultCurrency,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/action_buttons/action_button.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/screen_status_widgets.dart';
import 'package:tamoily/app/routes/app_routs_and_pages.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import 'return_request_controller.dart';
import 'widgets/return_request_data_form.dart';

class ReturnRequestPage extends GetView<ReturnRequestController> {
  static const String routeName = '/app/return-request-page/:order_id';

  static String navToRoute(String id) => '${routeName.removeParams}/$id';

  const ReturnRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReturnRequestController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: ConstStrings.ORDER_RETURN_ITEMS.translate,
          ),
          body: ScreenStatusWidgets(
            controller: controller,
            isEmpty: controller.returnRequestData == null,
            dataWidget: ReturnRequestDataForm(
              controller: controller,
              data: controller.returnRequestData,
            ),
          ),
          bottomNavigationBar: controller.busy || controller.showRetryButton
              ? null
              : ActionButton(
                  text: ConstStrings.RETURN_REQ_SUBMIT.translate.toUpperCase(),
                  onPressed: controller.submitForm,
                ).paddingSymmetric(
                  horizontal: SharedStyle.horizontalScreenPadding,
                  vertical: 12.0,
                ),
        );
      },
    );
  }
}

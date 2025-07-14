import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/global_html_view_widget.dart';
import 'package:sakani/app/global_widget/screen_status_widgets.dart';

import 'topic_controller.dart';

class TopicPage extends GetView<TopicController> {
  static const String routeName = '/app/topic-page';

  const TopicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: controller.data != null ? controller.data!.title : '',
          ),
          body: ScreenStatusWidgets(
            controller: controller,
            isEmpty: controller.data == null,
            onRetry: controller.fetchData,
            dataWidget: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SharedStyle.horizontalScreenPadding,
                vertical: 16.h,
              ),
              child: GlobalHtmlViewWidget(
                data:
                    '${controller.data?.body}\n ${controller.data?.body}' ?? '',
              ),
            ),
          ),
        );
      },
    );
  }
}

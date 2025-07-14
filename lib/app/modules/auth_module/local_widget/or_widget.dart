import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildExpanded,
          UiHelper.horizontalSpaceSmall,
          Text(
            AppStrings.or.tr.capitalizeFirst!,
            style: SharedStyle.subtitle2(
              bold: true,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          UiHelper.horizontalSpaceSmall,
          buildExpanded,
        ],
      ),
    );
  }

  Expanded get buildExpanded {
    return Expanded(
      flex: 2,
      child: Divider(
        color: Get.theme.dividerColor,
        thickness: 2,
        height: 0,
      ),
    );
  }
}

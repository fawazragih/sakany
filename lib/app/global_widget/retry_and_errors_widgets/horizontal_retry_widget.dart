import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/api_errors_strings.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../action_buttons/action_button.dart';
import '../app_ui_helper/shared_style.dart';
import '../app_ui_helper/ui_helpers.dart';

class HorizontalRetryWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const HorizontalRetryWidget({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 24.sp,
              ),
              UiHelper.horizontalSpaceTiny,
              Text(
                ApiErrorsStrings.unexpectedErrorOccurred.tr.capitalizeFirst!,
                style: SharedStyle.subtitle2(
                  fontSizeWithSp: 16.sp,
                  // bold: true,
                ),
              ),
            ],
          ),
          UiHelper.verticalSpaceMedium,
          ActionButton(
            isOutLined: true,
            height: 45.h,
            padding: 4.0,
            width: 0.8.sw,
            text: AppStrings.retry.tr.capitalizeFirst,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

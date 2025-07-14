import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../app_ui_helper/shared_style.dart';

class UserNameAndGreetingWidget extends StatelessWidget {
  const UserNameAndGreetingWidget({
    super.key,
    required this.fontSize,
    required this.textColor,
    this.titleWidget,
  });

  final double? fontSize;
  final Color? textColor;
  final Widget? titleWidget;

  String get greeting {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return AppStrings.goodMorning.tr.capitalizeFirst!;
    }
    if (hour < 17) {
      return AppStrings.goodAfternoon.tr.capitalizeFirst!;
    }
    return AppStrings.goodEvening.tr.capitalizeFirst!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            greeting,
            style: fontSize != null || textColor != null
                ? SharedStyle.subtitle2(
                    fontSizeWithSp: fontSize,
                    color: textColor,
                    height: 1.0,
                    bold: false,
                  )
                : null,
          ),
        ),
        if (titleWidget != null) ...[
          titleWidget!,
        ],
      ],
    );
  }
}

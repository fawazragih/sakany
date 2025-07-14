import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import 'app_ui_helper/shared_style.dart';

class ScreenTitleWidget extends StatelessWidget {
  final String title;
  final bool headline4;
  final TextAlign? textAlign;
  final AlignmentGeometry? alignment;
  final bool capitalizeFirst;
  final double fontSize;
  final bool bold;
  final Color? textColor;

  const ScreenTitleWidget({
    super.key,
    required this.title,
    this.headline4 = true,
    this.textAlign,
    this.alignment,
    this.fontSize = 25,
    this.bold = false,
    this.capitalizeFirst = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          capitalizeFirst ? title.capitalize ?? '' : title.toUpperCase(),
          style: SharedStyle.mainTitleText(
            headline4: false,
            bold: true,
            fontSize: fontSize,
            color: textColor,
          ),
          textAlign: textAlign ?? TextAlign.start,
        ),
      ),
    );
  }
}

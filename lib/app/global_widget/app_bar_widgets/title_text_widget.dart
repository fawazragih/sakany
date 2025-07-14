import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../data/models/app_user_model.dart';

class AppBarTitleTextWidget extends StatelessWidget {
  const AppBarTitleTextWidget({
    super.key,
    required this.title,
    this.fontSize = 16,
    this.textColor,
    this.user,
    this.translateTitle = false,
    this.centerTitle,
    this.height = 0,
  });

  final bool translateTitle;
  final String? title;
  final AppUser? user;
  final double fontSize;
  final double? height;
  final Color? textColor;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    if (translateTitle) {
      return Text(
        title ?? user?.name ?? AppStrings.appName.tr.capitalizeFirst!,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor,
              height: height,
              fontSize: fontSize,
              // bold: true,
            ),
      );
    }
    return Text(
      title ?? user?.name ?? AppStrings.appName.tr.capitalizeFirst!,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: fontSize,
            color: textColor,
            height: height,
            // bold: true,
          ),
    );
  }

  TextAlign? get textAlign {
    return centerTitle != null && centerTitle!
        ? TextAlign.center
        : Platform.isIOS
            ? TextAlign.center
            : null;
  }
}

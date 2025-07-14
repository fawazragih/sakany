import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../app_ui_helper/shared_style.dart';

class ActionButton extends StatelessWidget {
  final String? text;
  final Widget? childWidget;
  final double? height;
  final double? padding;
  final double? fontHeight;
  final double radius;
  final double? fontSize;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final RoundedLoadingButtonController? btnController;
  final bool isOutLined;

  const ActionButton({
    super.key,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.onPressed,
    this.btnController,
    this.height,
    this.childWidget,
    this.fontSize,
    this.radius = 12.0,
    this.fontHeight,
    this.padding,
    this.isOutLined = false,
    this.borderColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: btnController != null
          ? RoundedLoadingButton(
              controller: btnController!,
              animateOnTap: false,
              width: MediaQuery.of(context).size.width,
              height: height ?? (50.h),
              color: backgroundColor ?? Theme.of(context).colorScheme.primary,
              borderRadius: radius,
              successColor: Colors.green,
              elevation: 0,
              onPressed: onPressed,
              child: childWidget ??
                 Text(
                    text ?? AppStrings.submit.tr.capitalizeFirst!,
                    style: SharedStyle.subtitle2(
                      light: !isOutLined,
                      bold: true,
                      color: textColor,
                      fontSizeWithSp: fontSize ?? 14.sp,
                      height: fontHeight,
                    ),
                  ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              clipBehavior: Clip.antiAlias,
              style: ButtonStyle(
                fixedSize: height != null
                    ? WidgetStateProperty.all<Size>(
                        Size(double.infinity, height!),
                      )
                    : null,
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(padding ?? 18.0),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  backgroundColor ??
                      (isOutLined
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.primary),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                ),
                side: isOutLined
                    ? WidgetStateProperty.all<BorderSide>(
                        BorderSide(
                          color: borderColor ?? Theme.of(context).colorScheme.primary,
                          // width: 2.0,
                        ),
                      )
                    : null,
                elevation: WidgetStateProperty.all<double>(0),
              ),
              child: childWidget ??
                  Text(
                    text ?? AppStrings.submit.tr.capitalizeFirst!,
                    style: SharedStyle.subtitle2(
                      light: !isOutLined,
                      bold: true,
                      color: textColor,
                      fontSizeWithSp: fontSize ?? 14.sp,
                      height: fontHeight,
                    ),
                  ),
            ),
    );
  }
}

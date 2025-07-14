import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';

class AppFancyDialog<T> extends StatelessWidget {
  final String? title;
  final String? bodyText;
  final String? positiveButtonText;
  final Color? positiveTextColor;
  final String? negativeButtonText;
  final Color? negativeTextColor;
  final IconData? headerIconData;
  final Widget? headerWidget;
  final Widget? customBodyWidget;
  final AsyncValueGetter<T?>? onPositive;
  final AsyncValueGetter<T?>? onNegative;

  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;

  final Color? avatarIconHintColor;
  final Color? positiveButtonBGColor;
  final Color? positiveButtonBorderColor;

  // final Color? positiveButtonColor;
  // final Color? negativeButtonColor;
  final Color? negativeButtonBGColor;
  final Color? negativeButtonBorderColor;

  final bool hideNegativeButton;
  // final bool isConfirmationToDeleteDialog;

  const AppFancyDialog({
    super.key,
    this.title,
    this.bodyText,
    this.customBodyWidget,
    this.headerIconData,
    this.positiveButtonText,
    this.positiveTextColor,
    this.negativeButtonText,
    this.onPositive,
    this.onNegative,
    this.headerWidget,
    this.margin,
    this.alignment,
    this.avatarIconHintColor,
    this.positiveButtonBGColor,
    // this.positiveButtonColor,
    this.positiveButtonBorderColor,
    this.negativeButtonBGColor,
    this.negativeTextColor,
    this.negativeButtonBorderColor,
    this.hideNegativeButton = false,
    // this.isConfirmationToDeleteDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    bool colorsAreSame = Theme.of(context).colorScheme.primary ==
        Theme.of(context).colorScheme.secondary;

    Color negativeBGColor =
        negativeButtonBGColor ?? Theme.of(context).colorScheme.primary;

    Color negativeTxtColor =
        negativeTextColor ?? Theme.of(context).colorScheme.onPrimary;

    Color positiveBGColor = positiveButtonBGColor ?? Colors.green.shade500;

    Color positiveTxtColor =
        positiveTextColor ?? Theme.of(context).colorScheme.onPrimary;

    return Align(
      alignment: alignment ?? Alignment.center,
      child: Stack(
        // alignment: Alignment.center,
        children: [
          ///... logo back Circle
          PositionedDirectional(
            start: 1,
            end: 1,
            top: 5,
            child: CircleAvatar(
              backgroundColor: avatarIconHintColor ??
                  (colorsAreSame
                      ? Theme.of(context).dividerColor
                      : Theme.of(context).colorScheme.secondary),
              radius: 48,
            ),
          ),

          ///.. body widget
          Card(
            margin: margin ??
                const EdgeInsets.only(
                  top: 50,
                  bottom: 24,
                  left: 24,
                  right: 24,
                ),
            shape: SharedStyle.roundedRectangleBorder(
              radius: 24.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiHelper.verticalSpace(60),
                if (title != null)

                  //...title
                  Text(
                    title!.capitalizeFirst ?? '',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.color
                          ?.withOpacity(0.5),
                    ),
                  ),
                UiHelper.verticalSpaceMedium,
                if (bodyText != null)
                  //...explain
                  Text(
                    bodyText!.capitalizeFirst!,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.color
                          ?.withOpacity(0.7),
                    ),
                  ),
                if (customBodyWidget != null) customBodyWidget!,
                UiHelper.verticalSpaceLarge,
                Row(
                  children: [
                    //region negativeButton disagree button
                    if (!hideNegativeButton)
                      Expanded(
                        child: Card(
                          margin: EdgeInsetsDirectional.only(end: 12.0),
                          color: negativeBGColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                32,
                              ),
                              side: negativeButtonBorderColor == null
                                  ? BorderSide.none
                                  : BorderSide(
                                      color: negativeButtonBorderColor!,
                                    )),
                          elevation: 0.0,
                          child: InkWell(
                            onTap: onNegative?.call,
                            child: Text(
                              negativeButtonText?.capitalizeFirst ??
                                  AppStrings.cancel.tr.capitalizeFirst!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: negativeTxtColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ).paddingSymmetric(
                              horizontal: 12,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                      ),
                    //endregion

                    //region positiveButton agree button
                    Expanded(
                      flex: 1,
                      child: Card(
                        // margin: EdgeInsets.zero,
                        color: positiveBGColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              32,
                            ),
                            side: positiveButtonBorderColor == null
                                ? BorderSide.none
                                : BorderSide(
                                    color: positiveButtonBorderColor!)),
                        elevation: 0.0,
                        child: InkWell(
                          onTap: onPositive?.call,
                          child: Text(
                            positiveButtonText?.capitalizeFirst ??
                                AppStrings.ok.tr.capitalizeFirst!,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: positiveTxtColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ).paddingSymmetric(
                            horizontal: 12,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    ),
                    //endregion
                  ],
                ),
                UiHelper.verticalSpaceMedium,
              ],
            ).paddingSymmetric(
              horizontal: SharedStyle.horizontalScreenPadding,
            ),
          ),

          ///.. logo avatar widget
          PositionedDirectional(
            start: 1,
            end: 1,
            top: 5,
            child: CircleAvatar(
              radius: 40,
              child: headerWidget ??
                  Icon(
                    headerIconData ?? Icons.info_outline,
                    size: 32.0,
                  ),
            ).paddingAll(8.0),
          ),
        ],
      ),
    );
  }
}

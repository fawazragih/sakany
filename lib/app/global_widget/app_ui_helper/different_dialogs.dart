import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sakani/app/global_widget/app_ui_helper/app_fancy_dialog.dart';
import 'package:sakani/app/global_widget/loading_progress_bar.dart';
import '../../core/language_and_localization/app_strings.dart';
import 'shared_style.dart';

class DifferentDialogs {
  static EdgeInsets margin = EdgeInsets.only(
    bottom: 16,
    left: Get.context!.isPhone ? 24.w : 0.3.sw,
    right: Get.context!.isPhone ? 24.w : 0.3.sw,
  );

  static GetSnackBar successSnackBar({String? title, String? message}) {
    return GetSnackBar(
      titleText: Text(
        title ?? AppStrings.success.tr.capitalizeFirst!,
        style: Get.textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message ?? AppStrings.successfullyDone.tr.capitalizeFirst!,
        style: Get.textTheme.titleSmall!.copyWith(
          color: Colors.white,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: margin,
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.white,
        size: 32,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 4),
    );
  }

  static GetSnackBar errorSnackBar({String? title, String? message}) {
    return GetSnackBar(
      titleText: Text(
        title ?? AppStrings.error.tr.capitalizeFirst!,
        style: Get.textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message ?? AppStrings.failed.tr.capitalizeFirst!,
        style: Get.textTheme.titleSmall!.copyWith(
          color: Colors.white,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: margin,
      backgroundColor: Colors.red,
      icon: const Icon(
        Icons.remove_circle_outline,
        color: Colors.white,
        size: 32,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 5),
      // duration: const Duration(seconds: 4),
    );
  }

  static GetSnackBar messageSnackBar({String? title, String? message}) {
    return GetSnackBar(
      titleText: Text(
        title ?? AppStrings.attention.tr.capitalizeFirst!,
        style: Get.textTheme.titleLarge,
      ),
      messageText: Text(
        message ?? 'no message',
        style: Get.textTheme.titleSmall,
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: margin,
      backgroundColor: Colors.yellow.shade500,
      icon: const Icon(
        Icons.info,
        color: Colors.white,
        size: 32,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 5),
      // duration: const Duration(seconds: 4),
    );
  }

  static Color parseColor(String hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode.replaceAll("#", "0xFF")))
          .withOpacity(opacity ?? 1);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static void toastMessage({
    required String message,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor ?? Colors.black,
        textColor: textColor ?? Colors.white,
        fontSize: 16.0);
  }

  /// progress dialog
  static bool _isShowing = false;
  static RxString progressMessage =
      RxString(AppStrings.pleaseWait.tr.capitalizeFirst!);

  static showProgressDialog({
    String? msg,
    bool willPop = kDebugMode,
    bool barrierDismissible = kDebugMode,
    Widget? progressIcon,
  }) async {
    _isShowing = true;
    progressMessage.value = msg ?? AppStrings.pleaseWait.tr.capitalizeFirst!;

    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return willPop;
        },
        child: AlertDialog(
          content: AppProgressDialogWidget(
            progressMessage: progressMessage,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: SharedStyle.dialogBorderRadius,
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );

    // showDialog<void>(
    //   context: Get.context!,
    //   barrierDismissible: barrierDismissible,
    //   // false = user must tap button, true = tap outside dialog
    //   builder: (BuildContext dialogContext) {
    //     // ScreenUtil.setContext(Get.context!);
    //     return WillPopScope(
    //       onWillPop: () async {
    //         return willPop;
    //       },
    //       child: AlertDialog(
    //         content: AppProgressDialogWidget(
    //           progressMessage: progressMessage,
    //         ),
    //         shape: const RoundedRectangleBorder(
    //           borderRadius: SharedStyle.dialogBorderRadius,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  static hideProgressDialog() async {
    // logger.d('hide');
    // if (Get.isSnackbarOpen == true) {
    //   logger.f('close all snackBar');
    //   Get.closeAllSnackbars();
    // }

    if (_isShowing) {
      // logger.f('close dialog');
      Get.close(1);
    }
    progressMessage.value = AppStrings.pleaseWait.tr.capitalizeFirst!;
    _isShowing = false;
  }

  static Future<bool?> openConfirmationDialog({
    String? confirmText,
    String? cancelText,
    String? descMessage,
    AsyncValueGetter<bool?>? onTapConfirm,
    AsyncValueGetter<bool?>? onTapCancel,
    Widget? customHeader,
    IconData? headerIconData,
    Color? okBgColor,
    Color? okTextColor,
    Color? cancelBgColor,
    Color? cancelTextColor,
  }) {
    Completer<bool> completer = Completer();
    Get.dialog(
        AppFancyDialog<bool>(
          // title:confirmText ,
          bodyText: descMessage,
          headerIconData: headerIconData,
          headerWidget: customHeader,
          positiveButtonBGColor: okBgColor,
          positiveTextColor: okTextColor,
          negativeButtonBGColor: cancelBgColor,

          negativeTextColor: cancelTextColor,
          negativeButtonText:
              cancelText ?? AppStrings.cancel.tr.capitalizeFirst,
          positiveButtonText: confirmText ?? AppStrings.yes.tr.capitalizeFirst,
          onPositive: () async {
            if (Get.isDialogOpen == true) {
              Get.close(1);
            }
            completer.complete(true);
            return true;
          },
          onNegative: () async {
            if (Get.isDialogOpen == true) {
              Get.close(1);
            }
            completer.complete(false);
            return false;
          },
        ),
        transitionCurve: Curves.easeInOut);

    return completer.future;
    // return await AwesomeDialog(
    //   context: Get.context!,
    //   dialogType: DialogType.warning,
    //   width: Get.context!.isPhone ? 0.9.sw : 0.5.sw,
    //   headerAnimationLoop: false,
    //   customHeader: customHeader,
    //   animType: AnimType.topSlide,
    //   btnCancelText: cancelText ?? AppStrings.cancel.tr.capitalizeFirst,
    //   btnOkText: confirmText ?? AppStrings.yes.tr.capitalizeFirst,
    //   desc: descMessage ??
    //       AppStrings.confirmationDefaultMessage.tr.capitalizeFirst,
    //   isDense: true,
    //   descTextStyle: Get.textTheme.titleLarge,
    //   padding: EdgeInsets.zero,
    //   btnCancel: ActionButton(
    //     text: cancelText ?? AppStrings.cancel.tr.capitalizeFirst!,
    //     textColor:
    //         cancelTextColor ?? (Get.isDarkMode ? Colors.white : Colors.black),
    //     backgroundColor: cancelBgColor ??
    //         (Get.isDarkMode ? null : Colors.grey.withOpacity(0.1)),
    //     onPressed: () {
    //       Get.back();
    //     },
    //   ),
    //   btnOk: ActionButton(
    //     text: confirmText ?? AppStrings.yes.tr.capitalizeFirst!,
    //     textColor: okTextColor ?? Get.theme.colorScheme.primary,
    //     backgroundColor:
    //         okBgColor ?? Get.theme.colorScheme.primary.withOpacity(0.1),
    //     onPressed: () {
    //       onTapConfirm?.call();
    //       Get.back(result: true);
    //     },
    //   ),
    // ).show();
  }
}

// class AppAvatarIconDialog extends StatelessWidget {
//   final String title;
//   final String? explain;
//   final Widget? explainWidget;
//   final String? positiveButtonText;
//   final String? negativeButtonText;
//   final IconData? iconData;
//
//   // final VoidCallback onGoSetPermission;
//
//   const AppAvatarIconDialog({
//     super.key,
//     required this.title,
//     this.explain,
//     this.explainWidget,
//     this.iconData,
//     this.positiveButtonText,
//     this.negativeButtonText,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         // alignment: Alignment.center,
//         children: [
//           PositionedDirectional(
//             start: 1,
//             end: 1,
//             top: 5,
//             child: CircleAvatar(
//               backgroundColor: Get.theme.colorScheme.secondary,
//               radius: 48,
//             ),
//             // Container(
//             //   padding: const EdgeInsets.all(2.0),
//             //   width: 65,
//             //   height: 65,
//             //   clipBehavior: Clip.antiAlias,
//             //   decoration: BoxDecoration(
//             //     border: Border.all(
//             //       color: Get.theme.dividerColor,
//             //     ),
//             //     color: Get.theme.cardColor,
//             //     shape: BoxShape.circle,
//             //   ),
//             //   child: Icon(
//             //     iconData ?? Icons.info_outline,
//             //     size: 32.0,
//             //   ).paddingAll(8),
//             // ),
//           ),
//           Card(
//             margin: const EdgeInsets.only(
//               top: 50,
//               bottom: 24,
//               left: 24,
//               right: 24,
//             ),
//             shape: SharedStyle.roundedRectangleBorder(
//               radius: 24.0,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 UiHelper.verticalSpace(60),
//
//                 ///...title
//                 Text(
//                   title.capitalizeFirst!,
//                   textAlign: TextAlign.center,
//                   style: Get.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context)
//                         .textTheme
//                         .titleMedium
//                         ?.color
//                         ?.withOpacity(0.5),
//                   ),
//                 ),
//                 UiHelper.verticalSpaceMedium,
//
//                 ///...explain
//                 explainWidget ??
//                     Text(
//                       explain?.capitalizeFirst ?? '',
//                       textAlign: TextAlign.center,
//                       style: Get.textTheme.titleSmall?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         height: 1.5,
//                         color: Theme.of(context)
//                             .textTheme
//                             .titleMedium
//                             ?.color
//                             ?.withOpacity(0.7),
//                       ),
//                     ),
//
//                 UiHelper.verticalSpaceLarge,
//                 Row(
//                   children: [
//                     /// negativeButton disagree button
//                     Expanded(
//                       child: Card(
//                         // margin: EdgeInsets.zero,
//                         color: Get.theme.disabledColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                             32,
//                           ),
//                         ),
//                         elevation: 0.0,
//                         child: InkWell(
//                           onTap: () => Get.back(result: false),
//                           child: Text(
//                             negativeButtonText?.capitalizeFirst ??
//                                 AppStrings.cancel.tr.capitalizeFirst!,
//                             textAlign: TextAlign.center,
//                             style: Get.textTheme.bodySmall?.copyWith(
//                               color: Get.theme.colorScheme.onPrimary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ).paddingSymmetric(
//                             horizontal: 12,
//                             vertical: 8.0,
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     UiHelper.horizontalSpaceSmall,
//
//                     /// positiveButton agree button
//                     Expanded(
//                       flex: 1,
//                       child: Card(
//                         // margin: EdgeInsets.zero,
//                         color: Colors.green.shade500,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(
//                             32,
//                           ),
//                         ),
//                         elevation: 0.0,
//                         child: InkWell(
//                           onTap: () => Get.back(result: true),
//                           child: Text(
//                             positiveButtonText?.capitalizeFirst ??
//                                 AppStrings.continu.tr.capitalizeFirst!,
//                             textAlign: TextAlign.center,
//                             style: Get.textTheme.bodySmall?.copyWith(
//                               color: Get.theme.colorScheme.onPrimary,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ).paddingSymmetric(
//                             horizontal: 12,
//                             vertical: 8.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 UiHelper.verticalSpaceMedium,
//               ],
//             ).paddingSymmetric(
//               horizontal: SharedStyle.screensHorizontalPadding,
//             ),
//           ),
//
//           ///.. logo avatar widget
//           PositionedDirectional(
//             start: 1,
//             end: 1,
//             top: 5,
//             child: CircleAvatar(
//               radius: 40,
//               child: Icon(
//                 iconData ?? Icons.info_outline,
//                 size: 32.0,
//               ),
//             ).paddingAll(8.0),
//
//             // Container(
//             //   padding: const EdgeInsets.all(2.0),
//             //   width: 65,
//             //   height: 65,
//             //   clipBehavior: Clip.antiAlias,
//             //   decoration: BoxDecoration(
//             //     border: Border.all(
//             //       color: Get.theme.dividerColor,
//             //     ),
//             //     color: Get.theme.cardColor,
//             //     shape: BoxShape.circle,
//             //   ),
//             //   child: Icon(
//             //     iconData ?? Icons.info_outline,
//             //     size: 32.0,
//             //   ).paddingAll(8),
//             // ),
//           ),
//         ],
//       ),
//     );
//   }
// }

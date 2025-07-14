import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/assets_helpers/app_images.dart';
import '../../core/language_and_localization/api_errors_strings.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../services/connectivity_service/connectivity_controller.dart';
import '../action_buttons/action_button.dart';
import '../app_ui_helper/shared_style.dart';
import '../app_ui_helper/ui_helpers.dart';

class RetryWidget extends StatelessWidget {
  final bool inScaffold;
  final bool showHorizontal;
  final VoidCallback onRetry;
  final double? height;
  final double? iconSize;
  final IconData? iconData;
  final String? svgPath;
  final String? errorMessage;

  const RetryWidget({
    super.key,
    this.inScaffold = false,
    required this.onRetry,
    this.height,
    this.iconData,
    this.iconSize = 120,
    this.svgPath,
    this.errorMessage,
    this.showHorizontal = false,
  });

  bool get noConnection =>
      !Get.find<ConnectivityController>().currentConnectivityStatus!;

  // Get.find<ConnectivityController>().currentConnectivityStatus ?? false;

  @override
  Widget build(BuildContext context) {
    return showHorizontal
        ? SizedBox(
            width: 1.sw,
            child: Center(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w)),
                    onPressed: onRetry,
                    icon: const Icon(
                      Icons.refresh,
                      // size: 24 ?? iconSize?.sp,
                      // color: Theme.of(context).dividerColor,
                    ),
                    label: Text(
                      AppStrings.retry.tr.capitalizeFirst!,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: Padding(
              padding: SharedStyle.contentContainerPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  noConnection
                      ? SvgPicture.asset(
                          AppImages.lostConnectionSvg,
                          height: height ?? 1.0.sw,
                          width: 1.0.sw,
                          fit: BoxFit.contain,
                        )
                      : svgPath != null
                          ? SvgPicture.asset(
                              svgPath!,
                              height: height,
                              fit: BoxFit.contain,
                            )
                          : Icon(
                              iconData ?? Icons.report_gmailerrorred_rounded,
                              size: iconSize?.sp,
                              color: Theme.of(context).dividerColor,
                            ),
                  UiHelper.verticalSpaceMedium,
                 Text(
                    errorMessage ??
                        (noConnection
                            ? ApiErrorsStrings.checkInternet.tr.capitalizeFirst!
                            : ApiErrorsStrings
                                .unexpectedErrorOccurred.tr.capitalizeFirst!),
                    textAlign: TextAlign.center,
                    style: SharedStyle.subtitle2(
                      fontSizeWithSp: 16.sp,
                      // bold: true,
                    ),
                  ),
                  UiHelper.verticalSpaceTiny,
                  ActionButton(
                    isOutLined: true,
                    text: AppStrings.retry.tr.capitalizeFirst,
                    onPressed: onRetry,
                  ).paddingSymmetric(
                    horizontal: 32,
                    vertical: 16.0,
                  ),
                ],
              ),
            ),
          );
  }
}

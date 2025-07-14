import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/api_errors_strings.dart';

class NoConnectionSnackBar {
  NoConnectionSnackBar._();

  static final NoConnectionSnackBar _instance = NoConnectionSnackBar._();

  static NoConnectionSnackBar get instance => _instance;

  GetSnackBar? _getBar;

  GetSnackBar? get getBar {
    _getBar ??= GetSnackBar(
      messageText: Text(
        ApiErrorsStrings.checkInternet.tr.capitalizeFirst!,
        style: Get.textTheme.titleSmall!.copyWith(
          // color: Get.textTheme.subtitle1!.color,
          color: Colors.white,
        ),
      ),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
    return _getBar;
  }

  showNoConnectionSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getBar?.show();
    });
  }

  hideNoConnectionSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../core/language_and_localization/app_strings.dart';
import '../global_widget/app_ui_helper/different_dialogs.dart';
import 'package:app_extensions/app_extensions.dart';

class UrlLauncherManager {
  UrlLauncherManager._();

  static Future<void> makePhoneCall({required String? phoneNumber}) async {
    if (phoneNumber == null || phoneNumber.isEmpty) return;
    String url = 'tel:${phoneNumber.trim()}';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      Get.showSnackbar(DifferentDialogs.errorSnackBar(
          message: AppStrings.makeCallError.tr.capitalizeFirst));
    }
  }

  static Future<void> openEmail({required String? email}) async {
    if (email == null || email.isEmpty) return;
    final url = Uri.encodeFull('mailto:${email.trim()}');
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      Get.showSnackbar(DifferentDialogs.errorSnackBar(
          message: AppStrings.openEmailError.tr.capitalizeFirst));
    }
  }

  static Future<void> openUrlLink({required String? urlLink}) async {
    if (urlLink == null || urlLink.isEmpty) {
      DifferentDialogs.toastMessage(message: AppStrings.noUrlAvailable.tr);
      return;
    }
    final uri = Uri.parse(urlLink);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.showSnackbar(DifferentDialogs.errorSnackBar(
          message: AppStrings.openFileError.tr.capitalizeFirst));
    }
  }

  static Future<void> openWhatsapp(
      {required String? phoneNumber, String? text}) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return;
    }

    var whatsappPhoneNum = phoneNumber.trim();

    String whatsappUrl = '';

    if (kIsWeb) {
      whatsappUrl = 'https://api.whatsapp.com/send/?phone=$whatsappPhoneNum';
    } else {
      if (GetPlatform.isIOS) {
        whatsappUrl = 'https://wa.me/$whatsappPhoneNum?text=${Uri.parse('')}';
      } else {
        whatsappUrl = "whatsapp://send?phone=$whatsappPhoneNum";
      }
    }

    if (text.isNotNullOrEmpty) {
      whatsappUrl = '$whatsappUrl&text=$text';
    }

    if (await canLaunchUrlString(whatsappUrl)) {
      await launchUrlString(whatsappUrl);
    } else {
      Get.showSnackbar(
        DifferentDialogs.errorSnackBar(
            message: AppStrings.whatsappNotInstalled.tr.capitalizeFirst),
      );
    }
  }
}

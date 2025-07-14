import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/app_fancy_dialog.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/language_and_localization/app_strings.dart';

abstract class AppPermissionsHandler {
  /// Checks permission for storage

  /*static Future<bool> locationPermission() async {
    var status = await Permission.location.status;

    if (!status.isGranted || status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return await Get.dialog(
        RequestForDeniedPermissionDialog(
          title: AppStrings.locationPermission.translate.capitalizeFirst!,
          explain: AppStrings
              .locationPermissionExplain.translate.capitalizeFirst!,
        ),
      );
    }
    return false;
  }*/

  /*static Future<bool> isGPSServiceEnabled() async {
    var status = await Permission.locationWhenInUse.status;

    if (!status.isGranted || status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    }

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return await Get.dialog(
        RequestForDeniedPermissionDialog(
          title: AppStrings.locationPermission.translate.capitalizeFirst!,
          explain: AppStrings
              .locationPermissionExplain.translate.capitalizeFirst!,
        ),
      );
    }
    return false;
  }*/

  /* static Future<bool> cameraPermission() async {
    var status = await Permission.camera.status;

    if (!status.isGranted || status.isDenied) {
      /// show dialog that show why you need this Permission
      var goGrant = await Get.dialog(
        AppAvatarIconDialog(
          iconData: Icons.camera_alt_rounded,
          title: AppStrings.cameraPermission.translate,
          explain: AppStrings.cameraPermissionExplain.translate,
          positiveButtonText: AppStrings.goGrantPermission.translate,
          negativeButtonText: AppStrings.later.translate,
        ),
      );

      logger.d(goGrant);

      if (goGrant != null && goGrant is bool && goGrant) {
        status = await Permission.camera.request();
      } else {
        return false;
      }
    }

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return await Get.dialog(
        RequestForDeniedPermissionDialog(
          title: AppStrings.cameraPermission.translate.capitalizeFirst!,
          explain:
              AppStrings.cameraPermissionExplain.translate.capitalizeFirst!,
        ),
      );
    }
    return false;
  }*/

  static Future<bool> storagePermission() async {
    var status = await Permission.manageExternalStorage.status;

    if (status.isGranted) {
      return true;
    }

    if (!status.isGranted || status.isDenied) {
      // logger.d('locationPermission - !status.isGranted || status.isDenied');
      status = await Permission.manageExternalStorage.request();
    }

    if (status.isPermanentlyDenied) {
      /// show dialog that show why you need this Permission
      Get.dialog(
        AppFancyDialog(
          headerIconData: Icons.camera_alt_rounded,
          title: AppStrings.manageStorage.translate,
          bodyText: AppStrings.manageExternalStorageExplain.translate,
          positiveButtonText: AppStrings.grant.translate,
          negativeButtonText: AppStrings.later.translate,
          onPositive: () async => openAppSettings(),
          // onNegative: () async=>false,
        ),
      );
      return false;
    }

    if (status.isGranted) {
      // logger.d('locationPermission - isGranted');
      return true;
    }

    // logger.d('locationPermission - isNOTGranted');
    return false;
  }
}

// class RequestForDeniedPermissionDialog extends StatelessWidget {
//   final String title;
//   final String explain;
//
//   const RequestForDeniedPermissionDialog({
//     super.key,
//     required this.title,
//     required this.explain,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       // alignment: Alignment.center,
//       title: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//         textAlign: TextAlign.center,
//       ),
//       contentPadding: EdgeInsets.zero,
//       // insetPadding: EdgeInsets.all(32),
//       titlePadding: const EdgeInsets.all(16.0),
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             explain,
//             style: Get.textTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         UiHelper.verticalSpaceMedium,
//         Row(
//           children: [
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Get.theme.primaryColor,
//                   padding: const EdgeInsets.all(16.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.back(result: false);
//                 },
//                 child: Text(
//                   AppStrings.deny.translate.capitalizeFirst!,
//                   style: Get.textTheme.titleSmall?.copyWith(
//                     color: Get.theme.primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                   foregroundColor: Get.theme.primaryColor,
//                   padding: const EdgeInsets.all(16.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 onPressed: () async {
//                   var result = await openAppSettings();
//                   if (Get.isDialogOpen ?? false) {
//                     Get.back(result: result);
//                   }
//                 },
//                 child: Text(
//                   AppStrings.settings.translate.capitalizeFirst!,
//                   style: Get.textTheme.titleSmall?.copyWith(
//                     // color: Colors.grey.shade400,
//                     color: Get.theme.disabledColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

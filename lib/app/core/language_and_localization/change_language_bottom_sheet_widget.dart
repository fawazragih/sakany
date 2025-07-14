// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../global_widget/app_ui_helper/shared_style.dart';
// import 'app_language_controller.dart';
// import 'app_strings.dart';
// import 'languages_list.dart';
//
// class ChangeLanguageBottomSheetWidget extends StatelessWidget {
//   const ChangeLanguageBottomSheetWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0).copyWith(
//               top: 12.0,
//             ),
//             child: AutoSizeText(
//               AppStrings.changeLang.tr.capitalizeFirst!,
//               style: SharedStyle.subtitle2(
//                 bold: true,
//               ),
//               textScaleFactor: 1.8,
//             ),
//           ),
//           const Divider(),
//           ListView.separated(
//             shrinkWrap: true,
//             itemCount: AppLanguage.appLanguageList.length,
//             separatorBuilder: (context, index) => const Divider(),
//             itemBuilder: (BuildContext context, int index) {
//               AppLanguage appLanguage = AppLanguage.appLanguageList[index];
//               bool isSelected =
//                   Get.locale?.languageCode == appLanguage.locale.languageCode;
//               return ListTile(
//                 title: Text(AppLanguage.appLanguageList[index].name),
//                 trailing: isSelected
//                     ? const Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                       )
//                     : null,
//                 onTap: () async {
//                   Get.find<AppLanguageController>().changeLanguage(
//                     appLanguage.locale.languageCode,
//                   );
//
//                   if (Get.isBottomSheetOpen ?? false) {
//                     Get.close(1);
//                   }
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

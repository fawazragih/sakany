// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'app_language_controller.dart';
// import 'languages_list.dart';
//
// class ChangeLanguageDropDownWidget extends StatelessWidget {
//   final bool inIconTemplate;
//   final Color? iconColor;
//
//   const ChangeLanguageDropDownWidget({
//     super.key,
//     this.inIconTemplate = true,
//     this.iconColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<AppLanguage>(
//       isExpanded: false,
//       underline: const SizedBox(
//         height: 0,
//         width: 0,
//       ),
//       icon: inIconTemplate
//           ? buildCard(
//               Icons.language,
//               iconColor,
//             )
//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(
//                 Icons.language,
//                 color: iconColor ?? Colors.white,
//               ),
//             ),
//       items: AppLanguage.appLanguageList
//           .map<DropdownMenuItem<AppLanguage>>(
//             (e) => DropdownMenuItem<AppLanguage>(
//               value: e,
//               child: Row(
//                 //mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   // Text(
//                   //   e.flag,
//                   //   style: TextStyle(fontSize: 30),
//                   // ),
//                   AutoSizeText(
//                     e.name,
//                     style: Get.textTheme.titleSmall,
//                   )
//                 ],
//               ),
//             ),
//           )
//           .toList(),
//       onChanged: (AppLanguage? language) {
//         if (language != null) {
//           Get.find<AppLanguageController>()
//               .changeLanguage(language.locale.languageCode);
//         }
//       },
//     );
//   }
//
//   Widget buildCard(IconData icon, Color? iconColor) {
//     return InkWell(
//       radius: 8.0,
//       child: Card(
//         margin: EdgeInsets.zero,
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//             side: const BorderSide(color: Colors.yellow, width: 0.5)),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             icon,
//             size: 24,
//             color: iconColor ?? Get.iconColor,
//           ),
//         ),
//       ),
//     );
//   }
// }

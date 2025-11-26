import 'package:flutter/material.dart';
import 'package:tamoily/main.dart';

class AppLanguage {
  //final String flag; //  emoji flag are string "🇺🇸" "🇸🇦"
  final int id;
  final String name;
  final Locale locale;

  AppLanguage(this.id, this.name, this.locale);

  // static List<AppLanguage> get appLanguageList {
  //
  //   return <AppLanguage>[
  //     AppLanguage(2, 'العربية', const Locale('ar', 'YE')),
  //     AppLanguage(1, 'English', const Locale('en', 'US')),
  //   ];
  // }
  static List<AppLanguage> get appLanguageList {return appLanding?.languageNavSelector?.availableLanguages
            ?.map((e) => e.toAppLanguage())
            .toList() ??
        <AppLanguage>[];
  }

  @override
  String toString() {
    return name;
  }

// static List<DropdownMenuItem<LanguageListModel>> myDropDownMenuItem() {
//   return languageList
//       .map<DropdownMenuItem<LanguageListModel>>(
//         (e) => DropdownMenuItem<LanguageListModel>(
//           value: e,
//           child: Row(
//             //mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//              // Text(
//              //   e.flag,
//              //   style: TextStyle(fontSize: 30),
//              // ),
//               AutoSizeText(
//                 e.name,
//                 style: Get.textTheme.subtitle2,
//               )
//             ],
//           ),
//         ),
//       )
//       .toList();
// }
}

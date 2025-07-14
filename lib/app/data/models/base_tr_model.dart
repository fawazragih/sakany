import 'package:get/get.dart';

class BaseTrModel {
  String? arName;
  String? enName;

  bool get isAr => Get.locale?.languageCode == 'ar';

  String? get name {
    if (isAr) {
      return arName ?? enName;
    }
    return enName ?? arName;
  }

  // String? get value {
  //   // return attrValue;
  //   if (isAr) {
  //     return arName ?? enName;
  //   }
  //   return enName ?? arName;
  // }

  BaseTrModel({
    this.arName,
    this.enName,
  });

// String? get description {
//   if (isAr) {
//     return descriptionAr ?? descriptionEn;
//   }
//   return descriptionEn ?? descriptionAr;
// }
//
// String? get categoryName {
//   if (isAr) {
//     return categoryAr ?? categoryEn;
//   }
//   return categoryEn ?? categoryAr;
// }
}

// extension AppDoubleExtension on double {
//   double get roundIntoNDecimal {
//     return double.parse((this).toStringAsFixed(2));
//   }
// }

import 'package:app_extensions/app_extensions.dart';

extension TypesConversionExtension on String {
  bool get isNumeric {
    // if (this == null) {
    //   return false;
    // }
    return double.tryParse(trim()) != null;
  }

  int? get valueTypeToInt {
    return int.tryParse(trim());
  }

  double? get valueTypeToDouble {
    return double.tryParse(trim());
    // double? result;
    //
    // if (this is double) {
    //   return this;
    // }
    //
    // if (this is String && this.isNotEmpty && isNumeric) {
    //   result = double.parse(this.trim());
    // }
    //
    // if (this is int) {
    //   result = this.toDouble();
    // }
    //
    // return result;
  }

  bool? get valueTypeToBool {
    var value = toString();
    bool? newValue;

    if (value.isNotEmpty && isNumeric) {
      newValue = (value == '0' ? false : true);
    }

    if (value.isNotEmpty) {
      if (value.trim().toLowerCase() == 'false') {
        return false;
      }

      if (value.trim().toLowerCase() == 'ok' ||
          value.trim().toLowerCase() == 'true') {
        return true;
      }
    }

    return newValue;
  }

  DateTime? get valueTypeToDateTime {
    if (isNullOrEmpty) {
      return null;
    }
    return DateTime.parse(trim());
  }
}

// class TypesConversion {
//   TypesConversion._();
//
//   static String? valueTypeToString(dynamic value) {
//     if (value is int || value is double) {
//       return value.toString();
//     }
//     return value;
//   }
//
//   static DateTime? valueTypeToDateTime(dynamic value) {
//     if (value != null && value is String) return DateTime.parse(value);
//     return null;
//   }
//
//   static int? valueTypeToInt(dynamic value, {int? defaultValueWhenNull}) {
//     if (value is String && value.trim().isNotEmpty && isNumeric(value)) {
//       return int.parse(value);
//     }
//
//     if (value is int) {
//       return value.toInt();
//     }
//
//     return defaultValueWhenNull;
//   }
//
//   static double? valueTypeToDouble(dynamic value,
//       {double? whenNullDefaultValue}) {
//     double? result;
//
//     if (value is double) {
//       return value;
//     }
//
//     if (value is String && value.isNotEmpty && isNumeric(value)) {
//       result = double.parse(value);
//     }
//
//     if (value is int) {
//       result = value.toDouble();
//     }
//
//     return result ?? whenNullDefaultValue;
//   }
//
//   static bool isNumeric(String? str) {
//     if (str == null) {
//       return false;
//     }
//     return double.tryParse(str) != null;
//   }
//
//   static bool valueTypeToBool(dynamic value, {bool defaultValue = false}) {
//     bool? newValue;
//
//     if (value is String && value.isNotEmpty && isNumeric(value)) {
//       newValue = value == '0' ? false : true;
//     }
//
//     if (value is String &&
//         value.isNotEmpty &&
//         value.trim().toLowerCase() == 'ok') {
//       return true;
//     }
//
//     if (value is int) {
//       newValue = value == 0 ? false : true;
//     }
//
//     if (value is bool) {
//       newValue = value;
//     }
//
//     return newValue ?? defaultValue;
//   }
//
//   static double roundIntoNDecimal(dynamic value) {
//     return double.parse((value).toStringAsFixed(2));
//   }
//
//   static Color getColorFromHex(dynamic hexColor) {
//     if (hexColor is String) {
//       hexColor = hexColor.replaceAll("#", "");
//       if (hexColor.length == 6) {
//         hexColor = "FF$hexColor";
//       }
//     }
//     return Color(int.parse("0x$hexColor"));
//   }
//
//   static String getHexFromColor(Color color, {bool leadingHashSign = true}) {
//     return '${leadingHashSign ? '#' : ''}'
//         '${color.red.toRadixString(16).padLeft(2, '0')}'
//         '${color.green.toRadixString(16).padLeft(2, '0')}'
//         '${color.blue.toRadixString(16).padLeft(2, '0')}';
//   }
// }

// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import '../../core/language_and_localization/app_strings.dart';
// import '../../core/theme/input_decoration_style.dart';

// class CountryPickerWidget extends StatelessWidget {
//   final Function? onTap;
//   final bool isRequired;
//   final String keyName;
//   final ValueChanged<Country?>? onChange;
//   final Country? initialValue;
//   final bool enableChangeCountry;
//   final InputBorder? inputBorder;
//   final Color? fillColor;
//
//   // final String labelText;
//
//   const CountryPickerWidget({
//     super.key,
//     this.onTap,
//     this.isRequired = false,
//     required this.keyName,
//     this.initialValue,
//     this.onChange,
//     this.enableChangeCountry = true,
//     this.inputBorder,
//     this.fillColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderField<Country>(
//       name: keyName,
//       initialValue: initialValue,
//       onChanged: onChange,
//       validator: FormBuilderValidators.compose([
//         if (isRequired) FormBuilderValidators.required(),
//       ]),
//       builder: (FormFieldState<Country> field) {
//         return InputDecorator(
//           // key: Key(field.value!.countryCode),
//           decoration: InputDecoration(
//             // border: InputBorder.none,
//             // errorText: field.errorText,
//             // isDense: true,
//             // contentPadding: EdgeInsets.zero,
//             filled: AppInputDecorationStyle.isFill,
//             // border: AppInputDecorationStyle.enabledBorder,
//             fillColor: fillColor,
//             border: inputBorder,
//             labelStyle: AppInputDecorationStyle.labelStyle,
//             hintStyle: AppInputDecorationStyle.hintStyle,
//             contentPadding: AppInputDecorationStyle.inputFromWidgetPadding,
//             errorText: field.errorText,
//           ),
//           child: InkWell(
//             onTap: enableChangeCountry
//                 ? () {
//                     showCountryPicker(
//                       context: context,
//                       showPhoneCode: false,
//                       countryListTheme: CountryListThemeData(
//                         textStyle: Get.textTheme.titleSmall,
//                         inputDecoration: InputDecoration(
//                           hintText: AppStrings.selectCountry.tr.capitalizeFirst,
//                           helperStyle: Get.textTheme.titleSmall,
//                           labelStyle: Get.textTheme.titleSmall,
//                           fillColor: Get.theme.inputDecorationTheme.fillColor,
//                           // hintStyle: Get.textTheme.subtitle2,
//                         ),
//                       ),
//                       onSelect: (Country country) {
//                         field.didChange(country);
//                       },
//                     );
//                   }
//                 : null,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 field.value?.countryCode != null
//                     ? Text(
//                         generateFlagEmojiUnicode(field.value!.countryCode),
//                         style: Get.textTheme.titleSmall!.copyWith(
//                           color: !enableChangeCountry
//                               ? Get.theme.disabledColor.withOpacity(0.5)
//                               : null,
//                         ),
//                         textScaleFactor: 1.8,
//                       )
//                     : Icon(
//                         Icons.language,
//                         size: 24.sp,
//                       ),
//                 Expanded(
//                   child: Text(
//                     field.value?.name ??
//                         AppStrings.selectCountry.tr.capitalizeFirst!,
//                     style: Get.textTheme.titleSmall!.copyWith(
//                       color: !enableChangeCountry
//                           ? Get.theme.disabledColor.withOpacity(0.5)
//                           : null,
//                     ),
//                   ),
//                 ),
//                 if (enableChangeCountry)
//                   const Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     color: Colors.grey,
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   String generateFlagEmojiUnicode(String countryCode) {
//     const base = 127397;
//     return countryCode.codeUnits
//         .map((e) => String.fromCharCode(base + e))
//         .toList()
//         .reduce((value, element) => value + element)
//         .toString();
//   }
// }

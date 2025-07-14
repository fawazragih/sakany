import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../app_ui_helper/shared_style.dart';
import 'package:intl/intl.dart' as intl;
import '../../core/theme/input_decoration_style.dart';

class DateTimePickerFormWidget extends StatelessWidget {
  final String keyName;
  final String? labelText;
  final String? hintText;
  final bool isFill;
  final Color? fillColor;
  final bool isRequired;
  final bool readOnly;
  final InputType inputType;
  final intl.DateFormat? dateFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final InputBorder? inputBorder;
  final ValueChanged<DateTime?>? onChange;
  final ValueChanged<DateTime?>? onSaved;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const DateTimePickerFormWidget({
    super.key,
    required this.keyName,
    this.labelText,
    this.fillColor,
    this.isRequired = true,
    this.inputType = InputType.date,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.initialValue,
    this.inputBorder,
    this.onChange,
    this.isFill = AppInputDecorationStyle.isFill,
    this.contentPadding = AppInputDecorationStyle.inputFromWidgetPadding,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.readOnly = true,
    this.onSaved, this.textInputAction,
  });

  // DateTime? get firstDateAfterCheck {
  //   if (inputType == InputType.time && firstDate != null) {
  //     return DateTime(0, 0, 0, firstDate!.hour, firstDate!.minute);
  //   }
  //   return firstDate;
  // }
  //
  // DateTime? get lastDateAfterCheck {
  //   if (inputType == InputType.time && lastDate != null) {
  //     return DateTime(0, 0, 0, lastDate!.hour, lastDate!.minute);
  //   }
  //   return lastDate;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AutoSizeText(
        //   labelText,
        //   style: Get.textTheme.subtitle1.copyWith(
        //     color: Get.theme.primaryColor,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // UiHelper.verticalSpaceTiny,
        // Theme(
        //   data: Get.theme.copyWith(
        //     colorScheme: ColorScheme.light(primary: Get.theme.primaryColor),
        //   ),
        //   child:

        FormBuilderDateTimePicker(
          name: keyName,
          inputType: inputType,
          keyboardType: keyboardType,
          // timePickerInitialEntryMode: TimePickerEntryMode.,
          initialValue: initialValue,
          // style: Theme.of(context).textTheme.subtitle2?.copyWith(
          //       // height: 1.5,
          //       // fontFamily: SharedStyle.inputFontFamily,
          //       color: Get.theme.primaryColorLight,
          //     ),
          style: AppInputDecorationStyle.textStyle,
          firstDate: firstDate,
          initialDate: lastDate,
          lastDate: lastDate,
          // firstDate: firstDateAfterCheck,
          // initialDate: lastDateAfterCheck,
          // lastDate: lastDateAfterCheck,

          // initialDatePickerMode: DatePickerMode.day,
          // initialEntryMode: DatePickerEntryMode.calendar,
          onChanged: onChange,
          cursorColor: Theme.of(context).primaryColor,
          format: dateFormat ??
              (inputType == InputType.both
                  ? intl.DateFormat('dd-MM-yyyy hh:mm')
                  : inputType == InputType.date
                      ? intl.DateFormat('dd-MM-yyyy')
                      : intl.DateFormat('hh:mm')),
          validator: FormBuilderValidators.compose([
            if (isRequired) FormBuilderValidators.required(),
          ]),
          onSaved: onSaved,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              filled: isFill,
              fillColor: fillColor,
              hintText: hintText,
              labelStyle: AppInputDecorationStyle.labelStyle,
              hintStyle: AppInputDecorationStyle.hintStyle,
              contentPadding: contentPadding,
              // labelText: labelText,
              prefixIcon: prefixIcon ??
                  Icon(
                    inputType == InputType.time
                        ? Icons.watch_later_outlined
                        : Icons.calendar_today_outlined,
                  ),
              border: inputBorder,
              enabledBorder: inputBorder),
        ),
        // ),
      ],
    );
  }
}

class DateRangePickerFormWidget extends StatelessWidget {
  final String keyName;
  final String? labelText;
  final String? hintText;
  final bool isFill;
  final Color? fillColor;
  final bool isRequired;
  final InputType inputType;
  final intl.DateFormat? dateFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTimeRange? initialValue;
  final InputBorder? inputBorder;
  final ValueChanged<DateTimeRange?>? onChange;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final double? minIconConstraint;

  const DateRangePickerFormWidget({
    super.key,
    required this.keyName,
    this.labelText,
    this.fillColor,
    this.isRequired = true,
    this.inputType = InputType.date,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.initialValue,
    this.inputBorder,
    this.onChange,
    this.isFill = AppInputDecorationStyle.isFill,
    this.contentPadding = AppInputDecorationStyle.inputFromWidgetPadding,
    this.prefixIcon,
    this.hintText,
    this.minIconConstraint,
  });

  // DateTime? get firstDateAfterCheck {
  //   if (inputType == InputType.time && firstDate != null) {
  //     return DateTime(0, 0, 0, firstDate!.hour, firstDate!.minute);
  //   }
  //   return firstDate;
  // }
  //
  // DateTime? get lastDateAfterCheck {
  //   if (inputType == InputType.time && lastDate != null) {
  //     return DateTime(0, 0, 0, lastDate!.hour, lastDate!.minute);
  //   }
  //   return lastDate;
  // }

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateRangePicker(
      name: keyName,
      initialValue: initialValue,
      style: AppInputDecorationStyle.textStyle,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 10),
      pickerBuilder: (context, widget) {
        var textTheme = Get.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        );
        return Theme(
          data: Get.theme.copyWith(
            colorScheme: Get.theme.colorScheme.copyWith(
              primary: Get.theme.primaryColorDark,
            ),
            textTheme: TextTheme(
              bodySmall: textTheme,
              bodyMedium: textTheme,
              bodyLarge: textTheme,
              labelSmall: textTheme,
              labelMedium: textTheme,
              labelLarge: textTheme,
            ),
            dialogTheme: DialogThemeData(
              titleTextStyle: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              contentTextStyle: Get.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: Get.theme.primaryColor,
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0.3.sw,
              vertical: 0.14.sh,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: SharedStyle.dialogBorderRadius,
            ),
            // width: 0.5.w,
            child: widget,
          ),
        );
      },
      onChanged: onChange,
      expands: false,
      cursorColor: Get.theme.primaryColor,
      format: dateFormat ??
          (inputType == InputType.both
              ? intl.DateFormat('dd-MM-yyyy hh:mm')
              : inputType == InputType.date
                  ? intl.DateFormat('dd-MM-yyyy')
                  : intl.DateFormat('hh:mm')),
      validator: FormBuilderValidators.compose([
        if (isRequired) FormBuilderValidators.required(),
      ]),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      decoration: InputDecoration(
        filled: isFill,
        fillColor: fillColor,
        hintText: hintText,
        labelStyle: AppInputDecorationStyle.labelStyle,
        hintStyle: AppInputDecorationStyle.hintStyle,
        contentPadding: contentPadding,
        isDense: true,
        prefixIcon: prefixIcon ??
            Icon(
              inputType == InputType.time
                  ? Icons.watch_later_outlined
                  : Icons.calendar_today_outlined,
            ),
        border: inputBorder ?? AppInputDecorationStyle.focusedBorder,
        prefixIconConstraints: minIconConstraint != null
            ? BoxConstraints(
                minHeight: minIconConstraint!,
                minWidth: minIconConstraint!,
              )
            : null,
        suffixIconConstraints: minIconConstraint != null
            ? BoxConstraints(
                minHeight: minIconConstraint!,
                minWidth: minIconConstraint!,
              )
            : null,
      ),
    );
  }
}

class DateRangePickerFormAsCircularButton extends StatelessWidget {
  final String keyName;
  final String? labelText;
  final String? hintText;
  final bool isFill;
  final Color? fillColor;
  final bool isRequired;
  final InputType inputType;
  final intl.DateFormat? dateFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTimeRange? initialValue;
  final InputBorder? inputBorder;
  final ValueChanged<DateTimeRange?>? onChange;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final double? minIconConstraint;

  const DateRangePickerFormAsCircularButton({
    super.key,
    required this.keyName,
    this.labelText,
    this.fillColor,
    this.isRequired = true,
    this.inputType = InputType.date,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.initialValue,
    this.inputBorder,
    this.onChange,
    this.isFill = AppInputDecorationStyle.isFill,
    this.contentPadding = AppInputDecorationStyle.inputFromWidgetPadding,
    this.prefixIcon,
    this.hintText,
    this.minIconConstraint,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTimeRange>(
      name: keyName,
      validator: FormBuilderValidators.compose([
        if (isRequired) FormBuilderValidators.required(),
      ]),
      initialValue: initialValue,
      onChanged: onChange,
      builder: (FormFieldState<DateTimeRange> field) {
        return Card(
          shape: const CircleBorder(),
          elevation: 0.5,
          color: Get.theme.primaryColorDark,
          child: InkWell(
            onTap: () async {
              var result = await showDateRangePicker(
                context: context,
                firstDate: firstDate ?? DateTime.now(),
                lastDate: lastDate ?? DateTime(DateTime.now().year + 10),
                builder: (context, widget) {
                  var textTheme = Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  );
                  return Theme(
                    data: Get.theme.copyWith(
                      colorScheme: Get.theme.colorScheme.copyWith(
                        primary: Get.theme.primaryColorDark,
                      ),
                      textTheme: TextTheme(
                        bodySmall: textTheme,
                        bodyMedium: textTheme,
                        bodyLarge: textTheme,
                        labelSmall: textTheme,
                        labelMedium: textTheme,
                        labelLarge: textTheme,
                      ),
                      dialogTheme: DialogThemeData(
                        titleTextStyle: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        contentTextStyle: Get.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        selectionColor: Get.theme.primaryColor,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: SharedStyle.horizontalScreenPadding,
                        vertical: 0.14.sh,
                      ),
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.zero,
                      decoration: const BoxDecoration(
                        borderRadius: SharedStyle.dialogBorderRadius,
                      ),
                      child: widget,
                    ),
                  );
                },
              );
              if (result != null) {
                field.didChange(result);
              }
            },
            child: Icon(
              IconsaxPlusLinear.calendar,
              color: Get.theme.primaryColor,
              size: 30.sp,
            ).paddingAll(10.0),
          ),
        );
      },
    );
  }
}

// class CupertinoDateTimePickerFormWidget extends StatelessWidget {
//   final String keyName;
//   final String? labelText;
//   final String hintText;
//   final bool isFill;
//   final Color? fillColor;
//   final bool isRequired;
//   // final InputType inputType;
//   final intl.DateFormat? dateFormat;
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final DateTime? initialValue;
//   final InputBorder? inputBorder;
//   final ValueChanged<DateTime?>? onChange;
//   final CupertinoDatePickerMode? mode;
//   final double inputBorderRadius;
//   final EdgeInsetsGeometry? contentPadding;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//
//   const CupertinoDateTimePickerFormWidget({
//     Key? key,
//     required this.keyName,
//     this.labelText,
//     this.hintText = 'dd/MM/yyyy',
//     this.isFill = false,
//     this.fillColor,
//     this.isRequired = true,
//     // this.inputType = InputType.date,
//     this.firstDate,
//     this.lastDate,
//     this.dateFormat,
//     this.initialValue,
//     this.inputBorder,
//     this.onChange,
//     this.mode,
//     this.contentPadding = SharedStyle.inputFromWidgetPadding,
//     this.inputBorderRadius = SharedStyle.inputFromWidgetRadius,
//     this.prefixIcon,
//     this.suffixIcon,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderField<DateTime>(
//       name: keyName,
//       initialValue: initialValue,
//       onChanged: onChange,
//       validator: FormBuilderValidators.compose([
//         if (isRequired) FormBuilderValidators.required(),
//       ]),
//       builder: (FormFieldState<DateTime> field) {
//         return InkWell(
//           borderRadius: BorderRadius.circular(
//             inputBorderRadius,
//           ),
//           onTap: () {
//             Get.bottomSheet(
//               DateBottomSheet(
//                 mode: mode ?? CupertinoDatePickerMode.date,
//                 onSelectDate: field.didChange,
//                 firstDate: firstDate,
//                 initialDate: field.value ?? DateTime.now(),
//                 lastDate: lastDate,
//               ),
//               shape: SharedStyle.bottomSheetShape,
//             );
//           },
//           child: InputDecorator(
//             decoration: InputDecoration(
//               // labelText: labelText,
//               labelStyle: Get.textTheme.subtitle2,
//               labelText: field.value == null ? null : labelText,
//               contentPadding: contentPadding,
//               hintText: hintText,
//               hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
//                     height: 0.5,
//                   ),
//               alignLabelWithHint: true,
//               fillColor: fillColor,
//               filled: isFill,
//               suffixIcon: suffixIcon,
//               // prefixIcon: prefixIcon ?? Icon(Icons.calendar_today_outlined),
//               // isDense: true,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(
//                   inputBorderRadius,
//                 ),
//                 gapPadding: 0.0,
//                 borderSide: const BorderSide(),
//               ),
//               errorText: field.errorText,
//             ),
//             child: AutoSizeText(
//               field.value != null
//                   ? DateTimeHelpersMethods.showFormattedDate(
//                       field.value!,
//                       onlyTimeWithAMPM: mode == CupertinoDatePickerMode.time,
//                       onlyYearAndMonth: mode == CupertinoDatePickerMode.date,
//                       localeCod: Get.locale?.languageCode,
//                     )
//                   : hintText,
//               style: Get.theme.textTheme.subtitle2?.copyWith(
//                 color: field.value != null
//                     ? Get.textTheme.subtitle2?.color
//                     : Get.textTheme.caption?.color,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class DateBottomSheet extends StatelessWidget {
//   final ValueChanged<DateTime?> onSelectDate;
//   final DateTime? initialDate;
//   final DateTime? lastDate;
//   final DateTime? firstDate;
//   final CupertinoDatePickerMode mode;
//
//   const DateBottomSheet({
//     Key? key,
//     this.initialDate,
//     required this.mode,
//     this.lastDate,
//     this.firstDate,
//     required this.onSelectDate,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var selectedDate = initialDate;
//     return Card(
//       shape: SharedStyle.bottomSheetShape,
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Expanded(
//             child: CupertinoDatePicker(
//               mode: mode,
//               maximumDate: lastDate,
//               minimumDate: firstDate,
//               initialDateTime: initialDate ?? DateTime.now(),
//               onDateTimeChanged: (value) {
//                 selectedDate = value;
//                 // field.didChange(value);
//               },
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: ActionButton(
//               text: AppStrings.select.tr.capitalizeFirst!,
//               onPressed: () {
//                 onSelectDate(selectedDate);
//                 if (Get.isBottomSheetOpen ?? false) {
//                   Get.close(1);
//                 }
//               },
//             ),
//           ),
//           // UiHelper.verticalSpaceMedium,
//         ],
//       ),
//     );
//   }
// }

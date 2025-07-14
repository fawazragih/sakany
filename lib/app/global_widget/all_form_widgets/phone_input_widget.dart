import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme/input_decoration_style.dart';

class PhoneInputWidget extends StatelessWidget {
  final String keyName;
  final String? labelText;
  final bool isRequired;
  final bool isEnabled;

  final Color? fillColor;
  final ValueChanged<PhoneNumber>? onChange;

  final String? hintText;
  final PhoneNumber? initialValue;

  PhoneInputWidget({
    super.key,
    required this.keyName,
    this.labelText,
    this.isRequired = true,
    this.isEnabled = true,
    this.fillColor,
    this.hintText,
    this.initialValue,
    this.onChange,
  });

  // final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'AE');
  final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'YE');
  final TextEditingController textEditingController = TextEditingController();

  // String replaceArabicNumber(String input) {
  //   const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  //   const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  //
  //   for (int i = 0; i < english.length; i++) {
  //     input = input.replaceAll(arabic[i], english[i]);
  //   }
  //   print("/////$input");
  //   return input;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Visibility(
        //   visible: labelText != null,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       AutoSizeText(
        //         labelText ?? '',
        //         style: Get.textTheme.titleSmall,
        //       ),
        //       UiHelper.verticalSpaceSmall,
        //     ],
        //   ),
        // ),
        FormBuilderField<PhoneNumber>(
          name: keyName,
          validator: FormBuilderValidators.compose([
            if (isRequired) FormBuilderValidators.required(),
          ]),
          initialValue: initialValue,
          // focusNode: ,
          builder: (FormFieldState<PhoneNumber> field) {
            return InternationalPhoneNumberInput(
              keyboardType: TextInputType.phone,
              onInputChanged: (PhoneNumber number) {
                if (field.value == number) {
                  // logger.i('return');
                  return;
                }
                field.didChange(number);
                onChange?.call(number);
              },
              initialValue: field.value ?? initialValue ?? phoneNumber,
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                useEmoji: true,
                trailingSpace: false,
              ),
              ignoreBlank: true,
              autoFocus: false,
              autoFocusSearch: false,
              locale: 'en',
              isEnabled: isEnabled,
              textStyle: AppInputDecorationStyle.textStyle,
              selectorTextStyle: Get.textTheme.titleSmall,
              spaceBetweenSelectorAndTextField: 0.0,
              selectorButtonOnErrorPadding: 16,
              autoValidateMode: AutovalidateMode.disabled,
              formatInput: true,
              onFieldSubmitted: (v) {
                logger.i(v);
              },
              // inputFormaterList: [
              //   ArNumToEnFormatter(),
              // ],
              // keyboardType: const TextInputType.numberWithOptions(
              //   signed: false,
              //   decimal: false,
              // ),
              searchBoxDecoration: InputDecoration(
                isDense: true,
                filled: true,
                hintText: AppStrings.search.tr.capitalizeFirst!,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              ),
              inputDecoration: InputDecoration(
                // labelText: labelText,
                filled: AppInputDecorationStyle.isFill,
                hintStyle: AppInputDecorationStyle.hintStyle,
                contentPadding: AppInputDecorationStyle.inputFromWidgetPadding,
                hintText: hintText ?? labelText,
                errorText: field.errorText,
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                // border: b
              ),
            );
          },
        ),
      ],
    );
  }
}
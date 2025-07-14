import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:sakani/app/base_controllers_and_listeners/helpers_methods.dart';

import '../../core/theme/input_decoration_style.dart';

class AppDropDownMenuFormFieldWidget<T> extends StatelessWidget {
  final String keyName;
  final String? hintText;
  final String? labelText;
  final bool isRequired;
  final List<T> itemsList;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final AlignmentGeometry? alignment;
  final ValueSetterAndGetter<T, String> getItemName;

  // final ValueSetterAndGetter<T,String>? getItemValue;
  final ValueChanged<T?>? onSaved;
  final InputBorder? inputBorder;
  final BorderSide? borderSide;
  final FormFieldValidator? validator;
  final Color? fillColor;
  final bool isFill;
  final EdgeInsets? contentPadding;

  const AppDropDownMenuFormFieldWidget({
    super.key,
    required this.keyName,
    required this.itemsList,
    this.initialValue,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.fillColor,
    this.isFill = AppInputDecorationStyle.isFill,
    this.contentPadding = AppInputDecorationStyle.inputFromWidgetPadding,
    this.borderSide,
    this.validator,
    this.isRequired = true,
    this.inputBorder,
    this.onSaved,
    required this.getItemName,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: keyName,
      onChanged: onChanged,
      onSaved: onSaved,
      initialValue: initialValue,
      style:Theme.of(context).textTheme.titleSmall?.copyWith(
        height: 1.5,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: contentPadding,
        // hintText: hintText,
        // hintStyle:
        //     Theme.of(context).textTheme.subtitle2?.copyWith(height: 1.9),
        alignLabelWithHint: true,
        fillColor: fillColor,
        filled: isFill,

        labelStyle: AppInputDecorationStyle.labelStyle,
        // hintStyle: AppInputDecorationStyle.hintStyle,
        isDense: true,
        // focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        // border: inputBorder,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // floatingLabelAlignment: FloatingLabelAlignment.center
      ),
      alignment: alignment ?? AlignmentDirectional.centerStart,

      icon: Icon(Icons.keyboard_arrow_down_rounded),
      // isDense: true,
      // alignment: Alignment.topCenter,
      // allowClear: true,
      hint: Text(
        initialValue != null
            ? getItemName.call(initialValue as T)
            : (hintText ?? labelText ?? ''),
        style: initialValue != null
            ? Theme.of(context).textTheme.bodyMedium.withBoldFont
            : null,
      ),

      validator:
          FormBuilderValidators.compose([FormBuilderValidators.required()]),
      items: itemsList.map(
        (item) {
          String name = getItemName.call(item);
          return DropdownMenuItem(
            value: item,
            alignment: alignment ?? AlignmentDirectional.centerStart,
            child: Text(
              name,
              textDirection: name.getTextDirection,
              // textAlign: TextAlign.center,
            ),
          );
        },
      ).toList(),
    );
  }
}

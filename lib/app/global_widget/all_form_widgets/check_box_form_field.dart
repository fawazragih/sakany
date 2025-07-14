import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CheckBoxFormFieldWidget extends StatelessWidget {
  final String? hintText;
  final bool? initialValue;
  final String? label;
  final String keyName;
  final bool required;
  final ValueChanged<bool?>? onChanged;
  final ValueChanged<bool?>? onSaved;
  final EdgeInsetsGeometry? contentPadding;

  const CheckBoxFormFieldWidget({
    super.key,
    this.hintText,
    this.initialValue,
    required this.label,
    this.onChanged,
    this.onSaved,
    required this.keyName,
    this.required = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<bool>(
      name: keyName,
      initialValue: initialValue,
      validator: FormBuilderValidators.compose([
        if (required) FormBuilderValidators.required(),
      ]),
      onChanged: onChanged,
      builder: (FormFieldState<bool> state) {
        return InputDecorator(
            decoration: InputDecoration(
              errorText: state.errorText,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
              // labelText: label,
              // hintText: hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              isDense: true,
              // counter: counterWidgetBuilder?.call(state.value),
            ),
            isEmpty: state.value == null,
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: state.value ?? initialValue ?? false,
              title: Text(label ?? hintText ?? ''),
              onChanged: (value) {
                // logger.f(value);
                state.didChange(value);
                onChanged?.call(value);
              },
            ));
      },
    );
  }
}

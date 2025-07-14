import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../app_ui_helper/ui_helpers.dart';

class SliderFormField extends StatelessWidget {
  final String name;
  final String? lable;
  final double initialValue;
  final double? min;
  final double? max;
  final bool required;
  final ValueChanged<double?>? onChanged;

  const SliderFormField({
    super.key,
    required this.name,
    this.required = true,
    required this.initialValue,
    this.min,
    this.max,
    this.onChanged,
    this.lable,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveNumberFormat = NumberFormat.compact();

    return FormBuilderField(
      name: name,
      initialValue: initialValue,
      validator: FormBuilderValidators.compose([
        if (required) FormBuilderValidators.required(),
      ]),
      onChanged: onChanged,
      builder: (FormFieldState<double> field) {
        var value = field.value ?? initialValue;
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorText: field.errorText,
            filled: false,
            isDense: true,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            label: lable == null
                ? null
                : Text(lable!).paddingDirection(start: 24.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Slider(
                  value: value,
                  min: min ?? 0.1,
                  max: max ?? 1.0,
                  // divisions: 1,
                  label: initialValue.toString(),
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Theme.of(context).dividerColor,
                  onChanged: (value) {
                    field.didChange(value);
                  },
                ),
              ),
              Text(
                effectiveNumberFormat.format(value.floor()),
              ),
              UiHelper.horizontalSpaceMedium,
            ],
          ),
        );
      },
    );
  }
}

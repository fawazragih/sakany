import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../core/theme/input_decoration_style.dart';

class RatingFormFieldWidget extends StatelessWidget {
  final ValueChanged<double?>? onChange;
  final String keyName;
  final String? labelText;
  final double? initialValue;
  final double? horizontalStarsPadding;
  final bool allowHalfRating;
  final bool isRequired;

  const RatingFormFieldWidget({
    super.key,
    this.onChange,
    required this.keyName,
    this.initialValue = 1,
    this.allowHalfRating = true,
    this.horizontalStarsPadding,
    this.isRequired = true,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<double>(
        name: keyName,
        initialValue: initialValue,
        onChanged: onChange,
        validator: FormBuilderValidators.compose([
          if (isRequired) FormBuilderValidators.required(),
        ]),
        builder: (FormFieldState<double> field) {
          return InputDecorator(
            decoration: InputDecoration(
              border: InputBorder.none,
              errorText: field.errorText,
              labelStyle: AppInputDecorationStyle.labelStyle,
              hintStyle: AppInputDecorationStyle.hintStyle,
              labelText: labelText,
              contentPadding:
                  Theme.of(context).inputDecorationTheme.contentPadding,
              isDense: true,
              focusedBorder: AppInputDecorationStyle.focusedBorder,
              enabledBorder: AppInputDecorationStyle.normalBorder,
              // border: AppInputDecorationStyle.normalBorder,
            ),
            child: Center(
              child: RatingBar.builder(
                initialRating: initialValue ?? 0,
                minRating: 1,
                direction: Axis.horizontal,
                // wrapAlignment: WrapAlignment.center,
                allowHalfRating: allowHalfRating,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(
                    horizontal: horizontalStarsPadding ?? 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double rating) {
                  field.didChange(rating);
                },
              ),
            ),
          );
        });
  }
}

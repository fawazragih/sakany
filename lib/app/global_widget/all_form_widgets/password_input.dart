import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme/input_decoration_style.dart';
import '../app_ui_helper/ui_helpers.dart';
import 'input_text_field_widget.dart';

class PasswordInput extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? confirmLabelText;
  final String? confirmHintText;
  final String? confirmInitialValue;
  final String? initialValue;
  final String keyName;
  final String? confirmKeyName;
  final bool isSignUp;
  final int requiredMinLength;
  final bool isFill;
  final bool inRow;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String?>? onConfirmChanged;
  final ValueChanged<String?>? onConfirmSaved;

  // final Color fillColor;

  const PasswordInput({
    super.key,
    required this.hintText,
    this.labelText,
    required this.keyName,
    this.isSignUp = false,
    this.confirmKeyName,
    this.requiredMinLength = 6,
    this.isFill = AppInputDecorationStyle.isFill,
    this.confirmLabelText,
    this.confirmHintText,
    this.confirmInitialValue,
    this.contentPadding = AppInputDecorationStyle.inputFromWidgetPadding,
    this.inRow = false,
    this.initialValue,
    this.textInputAction,
    this.onChanged,
    this.onConfirmChanged, this.onSaved, this.onConfirmSaved,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isHidden = true;
  String? firstPass;

  @override
  Widget build(BuildContext context) {
    if (widget.isSignUp) {
      return widget.inRow
          ? Row(
              children: <Widget>[
                Expanded(child: buildTextFormField),
                UiHelper.horizontalSpaceMedium,
                Expanded(child: buildConfirmPassword),
              ],
            )
          : Column(
              children: <Widget>[
                buildTextFormField,
                UiHelper.verticalSpaceMedium,
                buildConfirmPassword,
              ],
            );
    } else {
      return buildTextFormField;
    }
  }

  Widget get buildTextFormField {
    return InputTextFieldWidget(
      keyName: widget.keyName,
      hintText: widget.hintText,
      labelText: widget.labelText,
      textInputAction: widget.textInputAction,
      obscureText: isHidden,
      contentPadding: widget.contentPadding,
      maxLines: 1,
      isRequired: true,
      isFill: widget.isFill,
      minLength: widget.requiredMinLength,
      keyboardType: TextInputType.text,
      initialValue: widget.initialValue,
      borderSide: const BorderSide(),
      prefixIcon: const Icon(
        Icons.lock_outlined,
      ),
      suffixIcon: IconButton(
        onPressed: _toggleVisibility,
        icon: isHidden
            ? const Icon(
                Icons.visibility_off_outlined,
              )
            : const Icon(
                Icons.visibility_outlined,
              ),
      ),
      onSaved: widget.onSaved,
      onChanged: (pass1) {
        setState(() {
          firstPass = pass1;
        });
        widget.onChanged?.call(pass1);
      },
    );
  }

  Widget get buildConfirmPassword {
    return InputTextFieldWidget(
      keyName: widget.confirmKeyName ?? '',
      // labelText: widget.confirmLabelText,
      hintText: widget.confirmHintText,
      keyboardType: TextInputType.text,
      obscureText: isHidden,
      textInputAction: widget.textInputAction,
      contentPadding: widget.contentPadding,
      maxLines: 1,
      borderSide: const BorderSide(),
      minLength: widget.requiredMinLength,
      isRequired: true,
      initialValue: widget.confirmInitialValue,
      prefixIcon: const Icon(
        Icons.lock_outlined,
      ),
      onSaved: widget.onConfirmSaved,
      onChanged: (value) {
        widget.onConfirmChanged?.call(value);
      },
      suffixIcon: IconButton(
        onPressed: _toggleVisibility,
        icon: isHidden
            ? const Icon(
                Icons.visibility_off_outlined,
              )
            : const Icon(
                Icons.visibility_outlined,
              ),
      ),
      validator: firstPass != null && firstPass!.isNotEmpty
          ? FormBuilderValidators.equal(
              firstPass!,
              errorText: AppStrings.passwordsDoNotMatch.tr.capitalizeFirst,
            )
          : null,
    );
  }

  void _toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

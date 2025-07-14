import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../core/theme/input_decoration_style.dart';

class InputTextFieldWidget extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String keyName;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isNumeric;
  final bool isUrl;
  final bool enabled;
  final bool isEmail;
  final bool isRequired;

  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final int? maxLength;
  final int? minLength;
  final int? minLine;
  final int? maxLines;
  final bool? autoFocus;
  final bool? readOnly;
  final bool? obscureText;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isFill;
  final Color? fillColor;
  final TextAlign? textAlign;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;
  final BorderSide? borderSide;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final double? minIconConstraint;
  final String? requiredValidatorText;
  final VoidCallback? onTap;

  const InputTextFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.enabled = true,
    required this.keyName,
    this.keyboardType,
    this.initialValue,
    this.isEmail = false,
    this.isNumeric = false,
    this.isRequired = true,
    this.isUrl = false,
    this.minLine,
    this.autoFocus = false,
    this.readOnly = false,
    this.prefixIcon,
    this.style,
    this.onChanged,
    this.inputBorder,
    this.suffixIcon,
    this.maxLength,
    this.textAlign,
    this.inputFormatters,
    this.maxLines,
    this.fillColor,
    this.isFill = AppInputDecorationStyle.isFill,
    this.contentPadding = AppInputDecorationStyle.inputFromWidgetPadding,
    this.borderSide,
    this.obscureText = false,
    this.minLength,
    this.validator,
    this.controller,
    this.minIconConstraint,
    this.requiredValidatorText,
    this.onTap,
    this.onSaved, this.textInputAction,
  });

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  late String text;
  bool isRTL = false;

  @override
  void initState() {
    super.initState();
    text = widget.hintText ?? widget.labelText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Visibility(
        //   visible: widget.labelText != null,
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       AutoSizeText(
        //         widget.labelText ?? 'none',
        //         style: Get.textTheme.subtitle2!.copyWith(
        //           color: Get.theme.primaryColor,
        //         ),
        //       ),
        //       UiHelper.verticalSpaceSmall,
        //     ],
        //   ),
        // ),
        AutoDirection(
          text: text,
          onDirectionChange: (bool change) {},
          child: FormBuilderTextField(
            name: widget.keyName,
            controller: widget.controller,
            initialValue:
                widget.controller == null ? widget.initialValue : null,
            style: widget.style ?? AppInputDecorationStyle.textStyle,
            minLines: widget.minLine,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            enabled: widget.enabled,
            obscureText: widget.obscureText!,
            autofocus: widget.autoFocus!,
            readOnly: widget.readOnly ?? false,
            textInputAction: widget.textInputAction,
            textAlignVertical: TextAlignVertical.top,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onTap: widget.onTap,
            decoration: InputDecoration(
              // constraints: const BoxConstraints(minHeight: 30),
              labelText: widget.labelText,
              // errorText: widget.errorText,
              contentPadding: widget.contentPadding ??
                  Theme.of(context).inputDecorationTheme.contentPadding,
              hintText: widget.hintText,
              hintMaxLines: 1,
              labelStyle: AppInputDecorationStyle.labelStyle,
              hintStyle: AppInputDecorationStyle.hintStyle,
              alignLabelWithHint: true,
              fillColor: widget.fillColor,
              filled: widget.isFill,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              isDense: true,
              focusedBorder: AppInputDecorationStyle.focusedBorder,
              enabledBorder: AppInputDecorationStyle.normalBorder,
              border: AppInputDecorationStyle.normalBorder,
              prefixIconConstraints: widget.minIconConstraint != null
                  ? BoxConstraints(
                      minHeight: widget.minIconConstraint!,
                      minWidth: widget.minIconConstraint!)
                  : null,
              suffixIconConstraints: widget.minIconConstraint != null
                  ? BoxConstraints(
                      minHeight: widget.minIconConstraint!,
                      minWidth: widget.minIconConstraint!)
                  : null,
            ),
            textAlign: widget.textAlign ?? TextAlign.start,
            inputFormatters: widget.inputFormatters ?? getEmailInputFormatter(),
            onReset: () {
              setState(() {
                text = widget.labelText ?? widget.hintText ?? '';
              });
            },
            validator: FormBuilderValidators.compose([
              if (widget.isRequired) FormBuilderValidators.required(
                errorText: widget.requiredValidatorText
              ),
              if (widget.isEmail) FormBuilderValidators.email(),
              if (widget.isNumeric) FormBuilderValidators.numeric(),
              if (widget.isUrl) FormBuilderValidators.url(),
              if (widget.minLength != null)
                FormBuilderValidators.minLength(
                  widget.minLength!,
                ),
              if (widget.validator != null) widget.validator!,
            ]),
            keyboardType: getKeyboardType(),
            onSaved: widget.onSaved,
            onChanged: (str) {
              if (!mounted) return;
              setState(() {
                text = str ?? widget.hintText ?? widget.labelText ?? '';
              });
              if (widget.onChanged != null) {
                widget.onChanged!.call(str!);
              }
            },
          ),
        ),
      ],
    );
  }

  TextInputType? getKeyboardType() {
    if (widget.keyboardType != null) {
      return widget.keyboardType;
    } else if (widget.isNumeric) {
      return TextInputType.number;
    } else {
      return (widget.minLine != null && widget.minLine! >= 7)
          ? TextInputType.multiline
          : TextInputType.text;
    }
  }

  List<TextInputFormatter>? getEmailInputFormatter() {
    return widget.isEmail
        ? [
            FilteringTextInputFormatter.deny(
              RegExp('[ ]'),
            )
          ]
        : null;
  }
}

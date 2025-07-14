import 'package:flutter/material.dart';

import '../app_ui_helper/shared_style.dart';

class SmallActionButton extends StatelessWidget {
  final bool isOutlined;
  final Color? borderColor;
  final Color? bgColor;
  final VoidCallback onTap;
  final String title;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  const SmallActionButton({
    super.key,
    this.isOutlined = false,
    required this.onTap,
    required,
    this.borderColor,
    required this.title,
    this.bgColor,
    this.textColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined
            ? Colors.transparent
            : bgColor ?? Theme.of(context).colorScheme.secondary,
        elevation: isOutlined ? 0 : null,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: isOutlined
              ? BorderSide(
                  color: borderColor ?? Theme.of(context).colorScheme.primary,
                )
              : BorderSide.none,
        ),
      ),
      child: Text(
        title,
        style: SharedStyle.subtitle2(
          color: textColor,
          light: !isOutlined,
          bold: true,
        ),
      ),
    );
  }
}

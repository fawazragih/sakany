import 'package:flutter/material.dart';

import '../my_card_design.dart';
import 'settings_icon_container.dart';

class SettingsIconItem extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final String? leadingIconPath;
  final IconData? leadingIcon;
  final Widget? trailingIcon;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final ShapeBorder? shapeBorder;
  final double? elevation;
  final double? iconSize;
  final VoidCallback? onTap;
  final bool showIconBorder;
  final Color? iconBorderColor;
  final Color? iconColor;
  final bool boldText;

  const SettingsIconItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIconPath,
    this.shapeBorder,
    this.elevation,
    this.margin,
    this.trailingIcon,
    this.leadingIcon,
    this.padding,
    this.onTap,
    this.showIconBorder = true,
    this.boldText = true,
    this.iconSize,
    this.iconBorderColor,
    this.iconColor,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: margin,
      padding: EdgeInsets.zero,
      radius: 12,
      onTap: onTap,
      child: ListTile(
        contentPadding: padding,
        dense: false,
        // titleAlignment: ListTileTitleAlignment.threeLine,
        title: Text(
          title,
          style: titleStyle ??
              Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: boldText ? FontWeight.w600 : FontWeight.normal,
                  ),
        ),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
        leading: leadingIconPath == null && leadingIcon == null
            ? null
            : SettingsIconContainer(
                iconPath: leadingIconPath,
                iconData: leadingIcon,
                showBorder: showIconBorder,
                borderColor: iconBorderColor,
                iconColor: iconColor,
                iconSize: iconSize,
                size: Size(
                  iconSize ?? 40.0,
                  iconSize ?? 40.0,
                ),
              ),
        trailing: trailingIcon,
      ),
    );
  }
}

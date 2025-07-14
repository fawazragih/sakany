import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../app_ui_helper/shared_style.dart';

class SettingsIconContainer extends StatelessWidget {
  final String? iconPath;
  final IconData? iconData;
  final Size size;
  final double? iconSize;
  final bool showBorder;
  final Color? borderColor;
  final Color? iconColor;

  const SettingsIconContainer({
    super.key,
    required this.iconPath,
    this.iconData,
    this.showBorder = true,
    this.iconSize,
    this.borderColor,
    required this.size, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: SharedStyle.settingsIconPadding,
        border: showBorder
            ? Border.all(
                color: borderColor ?? Get.theme.colorScheme.primary,
              )
            : null,
      ),
      child: iconPath != null
          ? SvgPicture.asset(iconPath!)
          : Icon(
              iconData!,
              color: iconColor??Theme.of(context).textTheme.titleSmall?.color,
              size: iconSize ?? 30,
            ),
    );
  }
}

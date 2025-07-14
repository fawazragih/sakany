import 'package:flutter/material.dart';

class VerticalContainerDivider extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  const VerticalContainerDivider({
    super.key,
    this.height,
    this.width,
    this.margin, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 12,
      width: width ?? 1,
      margin: margin,
      color:color?? Theme.of(context).dividerColor,
    );
  }
}

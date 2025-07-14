import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopBottomSheetDecorator extends StatelessWidget {
  final Color? color;
  final EdgeInsetsGeometry? margin;

  const TopBottomSheetDecorator({
    super.key,
    this.color,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: margin ??
            const EdgeInsets.only(
              bottom: 16.0,
              top: 4.0,
            ),
        width: Get.width / 3,
        height: 10,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}

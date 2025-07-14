import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app_ui_helper/shared_style.dart';

class TabButton extends StatelessWidget {
  final bool selected;
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;

  const TabButton({
    super.key,
    this.selected = false,
    required this.title,
    this.onTap,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 0.0,
      alignment: Alignment.center,
      height: Get.locale?.languageCode == 'fil' ? 50.h : null,
      decoration: BoxDecoration(
        color: selected
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: selected
              ? Colors.transparent
              : Theme.of(context).colorScheme.surfaceTint,
        ),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(8.0),
        //   side: BorderSide(
        //     color: selected
        //         ? Colors.transparent
        //         : Theme.of(context).colorScheme.surfaceTint,
        //   ),
        // ),
      ),
      child: InkWell(
        onTap: onTap,
        // borderRadius: BorderRadius.circular(32.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: SharedStyle.subtitle2(
              // fontSize: 14.0.sp,
              bold: selected,
              color: selected
                  ? Theme.of(context).cardColor
                  : Theme.of(context).colorScheme.surfaceTint,
            ),
          ),
        ),
      ),
    );
  }
}

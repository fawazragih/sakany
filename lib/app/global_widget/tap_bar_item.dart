import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app_ui_helper/shared_style.dart';
import 'app_ui_helper/ui_helpers.dart';

class TapBarItem extends StatelessWidget {
  final String? title;
  final int activeIndex;
  final ValueChanged<int>? onTap;
  final int index;

  const TapBarItem(
      {super.key,
      required this.title,
      // required this.isActive,
      required this.onTap,
      required this.index,
      required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!(index);
      },
      // radius: 8.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 4.0),
            child: Text(
              title ?? '',
              style: SharedStyle.subtitle2(
                bold: true,
                color: activeIndex == index
                    ? Get.theme.primaryColor
                    : Get.theme.primaryColor.withOpacity(0.4),
              ),
            ),
          ),
          UiHelper.verticalSpaceSmall,
          Visibility(
            visible: activeIndex == index,
            child: Container(
              height: 5.0.h,
              width:
                  // title != null
                  //     ? title!.length <= 4
                  //         ? 50.h
                  //         : title!.length * 6.0.w
                  //     :
                  70.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

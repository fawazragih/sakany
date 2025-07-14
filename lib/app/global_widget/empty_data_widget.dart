import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/assets_helpers/app_images.dart';
import '../core/language_and_localization/app_strings.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final String? imagePath;
  final double? iconSize;
  final double? imageHeight;
  final IconData? iconData;
  final EdgeInsetsGeometry? imgIconPadding;

  // final bool hideImage;

  const EmptyDataWidget({
    super.key,
    this.text,
    this.imagePath = AppImages.noDataSvg,
    this.iconData,
    this.iconSize,
    this.textStyle,
    this.imgIconPadding,
    this.imageHeight,
  });

  bool get isSvg => imagePath?.endsWith('.svg') ?? false;

  bool get hideImage => iconData != null;

  @override
  Widget build(BuildContext context) {

    late Widget childImg;
    if (!hideImage && imagePath != null) {
      childImg = isSvg
          ? SvgPicture.asset(
              imagePath!,
              height: imageHeight ?? 0.3.sh,
              // width: 0.5.sw,
              fit: BoxFit.contain,
              // colorFilter: ColorFilter.mode(
              //   Theme.of(context).dividerColor,
              //   BlendMode.dstOver,
              // ),
            )
          : Image.asset(
              imagePath!,
              // height: ScreenUtil().setHeight(200),
            );
    } else {
      childImg = Icon(
        iconData ?? Icons.info_outline_rounded,
        size: iconSize ?? 100.sp,
        color: Theme.of(context).dividerColor,
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: imgIconPadding ??
                  EdgeInsets.symmetric(
                    vertical: 24.0.h,
                  ),
              child: childImg,
            ),
          ),
          Text(
            text ?? AppStrings.noDataFound.tr.capitalizeFirst!,
            style: textStyle ??
                Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
    );
  }
}

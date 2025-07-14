import 'package:figma_squircle_updated/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final DecorationImage? image;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? borderWidth;
  final double? height;
  final double? width;
  final Color? borderColor;
  final bool withShadow;
  final bool hasBorder;
  final double? radius;
  final SmoothBorderRadius? borderRadius;
  final AlignmentGeometry? alignment;

  final bool withAlignment;

  const AppCard({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.color,
    this.borderWidth = 1.0,
    this.withShadow = true,
    this.hasBorder = true,
    this.borderColor,
    this.borderRadius,
    this.radius,
    this.onTap,
    this.onLongPress,
    this.alignment,
    this.height,
    this.width,
    this.withAlignment = true,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        onDoubleTap: onLongPress,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular((radius ?? 8.0) * 3),
        radius: (radius ?? 8.0) * 3,
        child: Container(
          // margin: margin,
          width: width,
          height: height,
          alignment: withAlignment ? (alignment ?? Alignment.center) : null,
          padding: padding,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            image: image,
            shape: SmoothRectangleBorder(
              borderRadius: borderRadius ??
                  SmoothBorderRadius(
                    cornerRadius: radius ?? 20.r,
                    cornerSmoothing: 1,
                  ),
              side: hasBorder
                  ? BorderSide(
                      width: borderWidth ?? 2.r,
                      color: borderColor ?? Theme.of(context).primaryColor,
                    )
                  : BorderSide.none,
            ),
            // color: gradient != null ? null : color ?? Get.theme.cardColor,
            color: color ?? Theme.of(context).cardColor,
            shadows: !withShadow
                ? null
                : [
                    BoxShadow(
                      blurRadius: 4.0,
                      // blurStyle: BlurStyle.inner,
                      offset: Offset(-1, 1),
                      // spreadRadius: 0.0,
                      // color: Theme.of(context).disabledColor.withOpacity(0.4),
                      color: Theme.of(context).dividerColor,
                    ),
                    /*BoxShadow(
                      blurRadius: 4.0,
                      // blurStyle: BlurStyle.inner,
                      offset: Offset(-1, 1),
                      color: Theme.of(context).dividerColor,
                    ),
                    BoxShadow(
                      blurRadius: 1,
                      // blurStyle: BlurStyle.outer,
                      offset: Offset(0, 0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),*/
                  ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class SmoothBorderRadiusExt {
  static SmoothBorderRadius directional({
    required BuildContext context,
    double? bottomStart,
    double? bottomEnd,
    double? topStart,
    double? topEnd,
  }) {
    var isRtl = Directionality.of(context) == TextDirection.rtl;
    //if isRtl then start is right
    // print(isRtl);
    // print(isRtl);
    // print(isRtl);

    return SmoothBorderRadius.only(
      bottomRight: isRtl
          ? SmoothRadius(
              cornerRadius: bottomStart ?? 0,
              cornerSmoothing: 1,
            )
          : SmoothRadius(
              cornerRadius: 0.0,
              cornerSmoothing: 1,
            ),
      topRight: isRtl
          ? SmoothRadius(
              cornerRadius: topStart ?? 0,
              cornerSmoothing: 1,
            )
          : SmoothRadius(
              cornerRadius: 0.0,
              cornerSmoothing: 1,
            ),
      bottomLeft: isRtl
          ? SmoothRadius(
              cornerRadius: bottomEnd ?? 0.0,
              cornerSmoothing: 1,
            )
          : SmoothRadius(
              cornerRadius: 0.0,
              cornerSmoothing: 1,
            ),
      topLeft: isRtl
          ? SmoothRadius(
              cornerRadius: topEnd ?? 0.0,
              cornerSmoothing: 1,
            )
          : SmoothRadius(
              cornerRadius: 0.0,
              cornerSmoothing: 1,
            ),
    );
  }
}

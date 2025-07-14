import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/assets_helpers/app_images.dart';

class LogoWidget extends StatelessWidget {
  final String? text;
  final String? path;
  final String? bgImagePath;
  final TextStyle? style;
  final TextAlign? textAlign;
  final BoxFit? fit;
  final double? radius;
  final double? height;
  final double? width;

  const LogoWidget({
    super.key,
    this.text,
    this.bgImagePath,
    this.style,
    this.textAlign,
    this.height,
    this.width,
    this.path,
    this.fit,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          path ?? AppImages.logoPng,
          fit: fit ?? BoxFit.contain,
          width: width ?? 0.5.sw,
          height: height ?? 0.3.sw,
        ),
        if (text != null) ...[
          // UiHelper.verticalSpaceTiny,
          Text(
            text!,
            style: style ??
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
            textAlign: textAlign ?? TextAlign.center,
          ),
        ],
        // UiHelper.verticalSpaceMedium,
      ],
    );
  }
}

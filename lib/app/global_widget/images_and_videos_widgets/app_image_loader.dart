import 'dart:math';
import 'dart:ui';
import 'package:app_extensions/app_extensions.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class AppImageLoader extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? errorImgWidth;
  final double? errorImgHeight;
  final BoxFit? fit;
  final Color? bgColor;
  final double? errorIconScale;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape? shape;
  final EdgeInsetsGeometry? padding;

  final bool isUserPlaceHolder;
  final Color? borderColor;

  const AppImageLoader({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.bgColor,
    this.errorIconScale,
    this.errorImgWidth,
    this.errorImgHeight,
    this.padding,
    this.shape,
    this.borderRadius,
    this.borderColor,
    this.isUserPlaceHolder = false,
  });

  String? get encodedUrl =>
      imageUrl.isNotNullOrEmpty ? Uri.encodeFull(imageUrl!) : null;

  bool get isNetworkImage =>
      encodedUrl.isNotNullOrEmpty &&
      encodedUrl?.toLowerCase().startsWith('http') == true;

  bool get isSvgImage =>
      encodedUrl.isNotNullOrEmpty &&
      encodedUrl?.toLowerCase().endsWith('.svg') == true;

  @override
  Widget build(BuildContext context) {
    final buildLoadingImageChild = Center(
      child: Container(
        // alignment: Alignment.center,
        color: Colors.grey.shade50,
        height: height,
        width: width,
        child: Center(
          child: Icon(
            isUserPlaceHolder
                ? IconsaxPlusLinear.user
                : Icons.image_search_rounded,
            size: 100,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: bgColor,
        shape: shape ?? BoxShape.rectangle,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1.0,
          style: BorderStyle.solid,
          strokeAlign: 1.0,
        ),
        borderRadius: shape == BoxShape.circle
            ? null
            : borderRadius ?? BorderRadius.circular(8.0),
      ),
      child: Builder(
        builder: (context) {
          if (isNetworkImage) {
            if (isSvgImage) {
              return SvgPicture.network(
                encodedUrl ?? '',
                width: width,
                height: height,
                fit: fit ?? BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return ErrorImageIconWidget(
                    scale:
                        errorIconScale ?? (shape == BoxShape.circle ? 1 : null),
                    height: errorImgHeight ?? height,
                    width: errorImgWidth ?? width,
                  );
                },
                placeholderBuilder: (context) {
                  return LoadingShimmerWidget(
                    // beginColor: Colors.transparent,
                    // endColor: Colors.grey.shade300,
                    child: buildLoadingImageChild,
                  );
                },
              );
            }

            return FastCachedImage(
              url: encodedUrl ?? 'https://',
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
              isAntiAlias: true,
              // color: bgColor,
              showErrorLog: false,
              alignment: Alignment.center,
              // repeat: ImageRepeat.repeat,
              loadingBuilder: (context, data) {
                return LoadingShimmerWidget(
                  // beginColor: Colors.transparent,
                  // endColor: Colors.grey.shade300,
                  child: buildLoadingImageChild,
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return ErrorImageIconWidget(
                  scale:
                      errorIconScale ?? (shape == BoxShape.circle ? 1 : null),
                  height: errorImgHeight ?? height,
                  width: errorImgWidth ?? width,
                );
              },
            );
          }

          //region asset image builders
          if (isSvgImage) {
            return SvgPicture.asset(
              encodedUrl ?? '',
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return ErrorImageIconWidget(
                  scale:
                      errorIconScale ?? (shape == BoxShape.circle ? 1 : null),
                  height: errorImgHeight ?? height,
                  width: errorImgWidth ?? width,
                );
              },
              placeholderBuilder: (context) {
                return LoadingShimmerWidget(
                  // beginColor: Colors.transparent,
                  // endColor: Colors.grey.shade300,
                  child: buildLoadingImageChild,
                );
              },
            );
          }

          return Image.asset(
            encodedUrl ?? '',
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return ErrorImageIconWidget(
                scale: errorIconScale ?? (shape == BoxShape.circle ? 1 : null),
                height: errorImgHeight ?? height,
                width: errorImgWidth ?? width,
              );
            },
            isAntiAlias: true,
          );

          //endregion
        },
      ),
    );
  }
}

class LoadingShimmerWidget extends StatefulWidget {
  final Widget child;

  const LoadingShimmerWidget({
    super.key,
    required this.child,
  });

  @override
  State<LoadingShimmerWidget> createState() => _LoadingShimmerWidgetState();
}

class _LoadingShimmerWidgetState extends State<LoadingShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final random = Random();
  final List<double> angles = List.generate(10, (index) => 0);
  int currentAngleIndex = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < angles.length; i++) {
      angles[i] = random.nextDouble() * 2 * pi;
    }

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          currentAngleIndex = (currentAngleIndex + 1) % angles.length;
          _controller.reset();
          _controller.forward();
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      // child: widget.child,
      builder: (context, child) {
        final currentAngle = angles[currentAngleIndex];
        final nextAngle = angles[(currentAngleIndex + 1) % angles.length];

        return ShaderMask(
          blendMode: BlendMode.multiply,
          shaderCallback: (rect) {
            return SweepGradient(
              center: const Alignment(-1, 1), // Set center to bottom-left
              startAngle:
                  lerpDouble(currentAngle, nextAngle, _controller.value)!,
              endAngle:
                  lerpDouble(currentAngle, nextAngle, _controller.value)! + pi,
              colors: [
                Colors.grey.shade100,
                Colors.grey.shade200,
                Colors.grey.shade300,
                Colors.grey.shade200,
                Colors.grey.shade100,
              ],
            ).createShader(
              rect,
              textDirection: TextDirection.ltr,
            );
          },
          child: widget.child,
        );
      },
    );
  }
}

class ErrorImageIconWidget extends StatelessWidget {
  final double? height, width, scale;
  final IconData? errorIcon;

  // final double? errorIconSize;

  const ErrorImageIconWidget({
    super.key,
    this.height,
    this.width,
    this.scale,
    this.errorIcon,
    // this.errorIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Transform.scale(
            scale: scale ?? 2.0.r,
            child: Icon(
              errorIcon ?? IconsaxPlusLinear.image,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani/app/base_controllers_and_listeners/helpers_methods.dart';
import '../../core/assets_helpers/app_images.dart';
import 'app_image_loader.dart';

class ImageSliderWidget<T> extends StatefulWidget {
  final double height;
  final double? aspectRatio;
  final int? autoPlayInterval;
  final double? indicatorsSize;
  final Color? bgColor;
  final bool showIndicators;
  final List<T?>? imageUrl;
  final String? placeHolderPath;
  final double radius;
  final ValueChanged<T>? onImageTap;
  final ValueSetterAndGetter<T, String> getImageUrl;
  final double? viewportFraction;
  final double? imagePadding;
  final BoxFit? fit;
  final BorderRadiusGeometry? borderRadius;

  const ImageSliderWidget({
    super.key,
    this.height = 154,
    this.aspectRatio,
    this.autoPlayInterval,
    required this.imageUrl,
    required this.getImageUrl,
    this.radius = 16.0,
    this.onImageTap,
    this.viewportFraction,
    this.imagePadding,
    this.fit,
    this.showIndicators = false,
    this.borderRadius,
    this.placeHolderPath,
    this.bgColor,
    this.indicatorsSize,
  });

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState<T>();
  }
}

class _CarouselWithIndicatorState<T> extends State<ImageSliderWidget<T>> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              // height: widget.height.h,
              autoPlay: true,
              // autoPlayAnimationDuration: const Duration(seconds: 5),
              autoPlayInterval: Duration(seconds: widget.autoPlayInterval ?? 3),
              // pageSnapping: true,
              enlargeCenterPage: true,
              aspectRatio: widget.aspectRatio ?? 16 / 9,
              height: widget.height,
              viewportFraction: widget.viewportFraction ??
                  (listIsNotEmptyAndHasMoreThanOneItem ? 0.8 : 1.0),
              // disableCenter: true,
              enableInfiniteScroll: listIsNotEmptyAndHasMoreThanOneItem,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: (widget.imageUrl.isNotNullOrEmpty)
                ? widget.imageUrl!
                    .map(
                      (T? e) => InkWell(
                        onTap: () => widget.onImageTap?.call(e!),
                        child: AppImageLoader(
                          imageUrl: widget.getImageUrl.call(e as T),
                          height: widget.height,
                          width: double.infinity,
                          fit: widget.fit ?? BoxFit.contain,
                          borderRadius: BorderRadius.circular(16.0),
                          padding: EdgeInsets.all(
                            widget.imagePadding ?? 0.0,
                          ),
                        ),
                      ),
                    )
                    .toList()
                : [
                    Image.asset(
                      AppImages.logoPng,
                      width: double.infinity,
                      height: 150,
                      fit: widget.fit ?? BoxFit.cover,
                    )
                  ],
          ),
        ),
        if (listIsNotEmptyAndHasMoreThanOneItem && widget.showIndicators)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageUrl!.asMap().entries.map((entry) {
              bool isCurrent = _current == entry.key;
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: /*isCurrent ? 20 :*/ (widget.indicatorsSize ?? 12.0.r),
                  height: widget.indicatorsSize ?? 12.0.r,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: /*isCurrent ? BoxShape.rectangle : */
                        BoxShape.circle,
                    // borderRadius:
                    //     isCurrent ? BorderRadius.circular(12.0) : null,
                    color: isCurrent
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).disabledColor.withOpacity(0.2),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  bool get listIsNotEmptyAndHasMoreThanOneItem {
    return widget.imageUrl != null &&
        widget.imageUrl!.isNotEmpty &&
        widget.imageUrl!.length > 1;
  }
}

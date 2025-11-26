import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../base_controllers_and_listeners/helpers_methods.dart';
import 'images_and_videos_widgets/app_image_loader.dart';
class GenericImageAndNameInRowTemplate<T> extends StatelessWidget {
  const GenericImageAndNameInRowTemplate({
    super.key,
    required this.item,
    this.image,
    required this.name,
    this.onTap,
    this.textColor,
    this.bgColor,
    this.borderColor,
    this.circleRadius,
  });

  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final double? circleRadius;
  final VoidCallback? onTap;
  final T item;
  final ValueSetterAndGetter<T, String?> name;
  final ValueSetterAndGetter<T, String?>? image;

  double get radius => circleRadius ?? 12.r;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      // margin: const EdgeInsetsDirectional.only(end: 8.0),
      // alignment: AlignmentDirectional.centerStart,
      // color: color ?? Theme.of(context).dividerColor.withOpacity(0.4),
      color: bgColor ?? Theme.of(context).cardColor,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(40),
      // ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImageLoader(
              imageUrl: image?.call(item) ?? '',
              // shape: AppImageLoaderShape.circle,
              shape: BoxShape.circle,
              // circularRadius: radius,
              padding: EdgeInsets.zero,
              bgColor: bgColor,
              borderColor: borderColor,
              // borderWidth: 0,
            ),
            // UiHelper.horizontalSpaceTiny,
            Text(
              name.call(item) ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor == Theme.of(context).colorScheme.primary
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenericImageAndNameInColumnTemplate<T> extends StatelessWidget {
  final ValueChanged<T>? onTap;
  final T item;
  final ValueSetterAndGetter<T, String?> name;
  final ValueSetterAndGetter<T, String?> image;
  final BoxFit? imageFit;
  final double? imgHeight;
  final double? imgWidth;
  final bool? imgWithShadow;
  final double? imgBorderRadius;
  final Color? bgColor;
  final Color? textColor;

  final BoxShape imageShape;

  const GenericImageAndNameInColumnTemplate({
    super.key,
    required this.item,
    this.onTap,
    required this.name,
    required this.image,
    this.imageFit,
    this.imageShape = BoxShape.circle,
    this.imgHeight,
    this.imgWidth,
    this.imgWithShadow,
    this.bgColor,
    this.textColor,
    this.imgBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(item),
      borderRadius: BorderRadius.circular(12),
      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(height: 20,),
          Expanded(
            child: AppImageLoader(
              imageUrl: image.call(item) ?? '',
              fit: BoxFit.cover,
              shape: imageShape,
              height: imgHeight,
              width: imgWidth,
              borderColor: Theme.of(context).dividerColor,
              bgColor: bgColor,
              borderRadius: imgBorderRadius == null
                  ? null
                  : BorderRadius.circular(imgBorderRadius!),
              padding: EdgeInsets.zero,
            
            ),
          ),
          Text(
            name.call(item) ?? '',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(height: 1.1),
            maxLines: 2,
            // softWrap: true,
            // wrapWords: true,
            textAlign: TextAlign.center,
          ),
        ].withSpaceBetween(
          height: 8.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppRatingWidget extends StatelessWidget {
  const AppRatingWidget({
    super.key,
    required this.rate,
    this.iconSize,
    this.starsIconColor,
  });

  final double? rate;
  final double? iconSize;
  final Color? starsIconColor;

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: RatingBar.builder(
        initialRating: rate ?? 0.0,
        direction: Axis.horizontal,
        updateOnDrag: false,
        ignoreGestures: true,
        allowHalfRating: false,
        itemSize: iconSize ?? 16.0,
        itemPadding: EdgeInsets.zero,
        wrapAlignment: WrapAlignment.start,
        itemCount: 5,
        itemBuilder: (context, _) => Icon(
          Icons.star_rounded,
          color: starsIconColor ?? Theme.of(context).colorScheme.primary,
        ),
        onRatingUpdate: (rating) {},
      ),
    );
  }
}

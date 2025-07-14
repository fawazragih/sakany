import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

import 'app_ui_helper/ui_helpers.dart';

class ShimmerListWidget extends StatelessWidget {
  final int itemCount;
  final bool inGrid;
  final bool horizontal;

  final Widget shimmerChild;
  final ShimmerDirection? shimmerDirection;

  final SliverGridDelegate? gridDelegate;

  const ShimmerListWidget({
    super.key,
    this.inGrid = true,
    this.itemCount = 3,
    this.horizontal = false,
    this.gridDelegate,
    required this.shimmerChild,
    this.shimmerDirection,
  });

  @override
  Widget build(BuildContext context) {
    if (inGrid) {
      return GridView.builder(
        gridDelegate: gridDelegate ??
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.75.h,
            ),
        shrinkWrap: true,
        scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
        itemCount: itemCount,
        primary: false,
        itemBuilder: (context, index) => BuildShimmer(
          shimmerDirection: shimmerDirection,
          child: shimmerChild,
        ),
      );
    }

    return horizontal
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(itemCount, (e) => Offstage())
                    .map(
                      (e) => BuildShimmer(
                        shimmerDirection: shimmerDirection,
                        child: shimmerChild,
                      ),
                    )
                    .toList()),
          )
        : ListView.separated(
            shrinkWrap: true,
            itemCount: itemCount,
            primary: false,
            padding: EdgeInsets.symmetric(
              horizontal: horizontal ? 0 : 4.0,
              vertical: horizontal ? 4.0 : 4.0,
            ),
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => BuildShimmer(
              shimmerDirection: shimmerDirection,
              child: shimmerChild,
            ),
          );
  }
}

class BuildShimmer extends StatelessWidget {
  final Widget child;
  final ShimmerDirection? shimmerDirection;

  const BuildShimmer({
    super.key,
    required this.child,
    this.shimmerDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? Colors.grey,
      highlightColor: Colors.grey[100] ?? Colors.grey,
      direction: shimmerDirection ?? ShimmerDirection.ttb,
      child: child,
    );
  }
}

class AppReadyShimmerList extends StatelessWidget {
  final SliverGridDelegate? gridDelegate;
  final bool inGrid;
  final int itemCount;
  final bool horizontal;
  final bool onlyOneContainer;

  // final bool showVerticalMediumSpacer;
  final double imageHeight;

  // final double? imageWidth;
  final double containerWidth;
  final double? verticalImageMargin;
  final double? containerHeight;
  final ShimmerDirection? shimmerDirection;

  const AppReadyShimmerList({
    super.key,
    this.gridDelegate,
    required this.inGrid,
    // this.sliverBuilder = false,
    required this.horizontal,
    required this.imageHeight,
    // this.imageWidth,
    required this.containerWidth,
    this.containerHeight,
    required this.itemCount,
    this.shimmerDirection,
    // this.showVerticalMediumSpacer = false,
    this.verticalImageMargin,
    this.onlyOneContainer = false,
  });

  SliverGridDelegate get getGridDelegate =>
      gridDelegate ??
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        childAspectRatio: 0.9,
      );

  @override
  Widget build(BuildContext context) {
    return ShimmerListWidget(
      itemCount: itemCount,
      inGrid: inGrid,
      shimmerDirection: shimmerDirection,
      gridDelegate: inGrid ? getGridDelegate : null,
      horizontal: horizontal,
      shimmerChild: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: horizontal ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Colors.transparent,
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: imageHeight,
                  color: Colors.white30,
                ),
              ),
            ),
            UiHelper.verticalSpaceSmall,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: containerWidth,
                  height: containerHeight ?? 16.0.h,
                  margin: const EdgeInsetsDirectional.only(
                    end: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                if (!onlyOneContainer) ...[
                  UiHelper.verticalSpaceSmall,
                  Container(
                    width: containerWidth - 20,
                    height:
                        containerHeight != null ? containerHeight! - 2.0 : 15.0,
                    margin: const EdgeInsetsDirectional.only(
                      end: 24.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ],
                UiHelper.verticalSpaceSmall,
              ],
            ).marginSymmetric(
              horizontal: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}

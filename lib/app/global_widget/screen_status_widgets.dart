import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../base_controllers_and_listeners/base_controller.dart';
import 'empty_data_widget.dart';
import 'loading_progress_bar.dart';
import 'pagination_list_builder.dart';
import 'retry_and_errors_widgets/retry_widget.dart';

class ScreenStatusWidgets extends StatelessWidget {
  final BaseController controller;
  final Widget dataWidget;
  final bool isEmpty;
  final EdgeInsetsGeometry? padding;

  final VoidCallback? onRetry;

  const ScreenStatusWidgets({
    super.key,
    required this.controller,
    required this.isEmpty,
    this.onRetry,
    this.padding,
    required this.dataWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: controller.busy
          ? const Center(
              child: LoadingProgressBar(),
            )
          : controller.showRetryButton
              ? RetryWidget(
                  onRetry: onRetry ?? () {},
                )
              : isEmpty
                  ? const EmptyDataWidget()
                  : dataWidget,
    );
  }
}

class SkeletonOfListView<T> extends StatelessWidget {
  final T fakeObject;
  final int fakeItemCount;
  final bool isLoading;
  final bool showEmptyData;
  final List<T>? realData;
  final Widget? separatorWidget;
  final PaginationItemBuilder<T> itemBuilder;
  final EdgeInsetsGeometry? padding;

  final bool shrinkWrap;

  final bool inGrid;

  final SliverGridDelegate? gridDelegate;

  const SkeletonOfListView({
    super.key,
    required this.fakeObject,
    this.fakeItemCount = 8,
    required this.isLoading,
    required this.showEmptyData,
    required this.realData,
    required this.itemBuilder,
    this.separatorWidget,
    this.shrinkWrap = false,
    this.padding,
    this.inGrid = false,
    this.gridDelegate,
  });

  @override
  Widget build(BuildContext context) {
    List<T> fakeData = List.filled(fakeItemCount, fakeObject);

    return Skeletonizer(
      enabled: isLoading,
      child: !isLoading && showEmptyData
          ? EmptyDataWidget()
          : inGrid
              ? GridView.builder(
                  shrinkWrap: shrinkWrap,
                  padding: padding,
                  itemBuilder: (context, index) {
                    T item = isLoading ? fakeData[index] : realData![index];
                    return itemBuilder.call(item, index);
                  },
                  itemCount:
                      isLoading ? fakeData.length : realData?.length ?? 0,
                  gridDelegate: gridDelegate ??
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1.0.sh > 1.0.sw
                            ? (1.0.sh / 1.0.sw).round()
                            : (1.0.sw / 1.0.sh).round(),
                        childAspectRatio: 0.73,
                        // mainAxisExtent: AppConstants.productBoxHeight,
                      ),
                )
              : ListView.separated(
                  padding: padding,
                  shrinkWrap: shrinkWrap,
                  itemCount:
                      isLoading ? fakeData.length : realData?.length ?? 0,
                  separatorBuilder: (context, index0) =>
                      separatorWidget ??
                      Divider(
                        indent: 16.0.w,
                        endIndent: 16.0.w,
                      ),
                  itemBuilder: (context, index) {
                    T item = isLoading ? fakeData[index] : realData![index];
                    return itemBuilder.call(item, index);
                  },
                ),
    );
  }
}

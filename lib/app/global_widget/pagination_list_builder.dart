import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tamoily/app/core/language_and_localization/app_strings.dart';
import 'package:tamoily/app/global_widget/retry_and_errors_widgets/retry_widget.dart';

import '../global_widget/loading_progress_bar.dart';
import 'empty_data_widget.dart';

typedef PaginationItemBuilder<T> = Widget Function(T item, int index);

class PaginationListBuilder<T> extends StatelessWidget {
  const PaginationListBuilder({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.newPageProgressIndicatorBuilder,
    this.padding,
    this.witSeparator = true,
    this.shrinkWrap = true,
    this.showNoMoreItem = true,
    this.noMoreItemsWidget,
    this.emptyDataWidget,
    this.inHorizontal = false,
    this.stopScroll = false,
    this.emptyDataWidgetWidth,
    this.emptyDataWidgetHeight,
    this.emptyDataMessage,
    this.errorWidget,
    // this.withRefresh = true,
  });

  final bool shrinkWrap;
  final bool witSeparator;
  final bool showNoMoreItem;
  final EdgeInsetsGeometry? padding;
  final PagingController<int, T> pagingController;

  // final Widget Function(T,int) itemBuilder;
  final PaginationItemBuilder<T> itemBuilder;
  final Widget? newPageProgressIndicatorBuilder;
  final Widget? noMoreItemsWidget;
  final Widget? emptyDataWidget;
  final String? emptyDataMessage;
  final Widget? errorWidget;
  final bool inHorizontal;
  final bool stopScroll;

  // final bool withRefresh;
  final double? emptyDataWidgetWidth;
  final double? emptyDataWidgetHeight;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>.separated(
      pagingController: pagingController,
      scrollDirection: inHorizontal ? Axis.horizontal : Axis.vertical,
      shrinkWrap: shrinkWrap,
      padding: padding,
      primary: false,
      // addRepaintBoundaries: false,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: stopScroll
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<T>(
        animateTransitions: false,
        // transitionDuration: Duration.zero,
        firstPageProgressIndicatorBuilder: (context) {
          return Center(
            child:
                newPageProgressIndicatorBuilder ?? const LoadingProgressBar(),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return newPageProgressIndicatorBuilder ??
              LoadingProgressBar(
                inHorizontal: inHorizontal,
              );
        },
        firstPageErrorIndicatorBuilder: (context) =>
            errorWidget ??
            RetryWidget(
              onRetry: pagingController.refresh,
              showHorizontal: inHorizontal,
              iconData: Icons.info_outline,
              errorMessage: pagingController.error.toString(),
            ),
        // noMoreItemsIndicatorBuilder: (context) => const Text('NO MORE'),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: SizedBox(
            width: emptyDataWidgetWidth,
            child: emptyDataWidget ??
                EmptyDataWidget(
                  text: emptyDataMessage,
                  imageHeight: emptyDataWidgetHeight ??
                      (inHorizontal
                          ? MediaQuery.of(context).size.height / 2
                          : null),
                ),
          ),
        ),
        noMoreItemsIndicatorBuilder: showNoMoreItem == false
            ? null
            : (context) => NoMoreItems(
                  noMoreWidget: noMoreItemsWidget,
                  inHorizontal: inHorizontal,
                ),
        itemBuilder: (context, item, index) => DelayedDisplay(
          delay: const Duration(milliseconds: 300),
          fadingDuration: const Duration(milliseconds: 150),
          slidingCurve: Curves.easeInOut,
          slidingBeginOffset:
              !inHorizontal ? const Offset(0.0, 0.35) : const Offset(0.35, 0.0),
          // fadingDuration: Duration(milliseconds: 900),
          child: itemBuilder.call(item, index),
        ),
      ),
      separatorBuilder: (context, index) => witSeparator
          ? Divider(
              indent: 16.w,
              endIndent: 16.w,
            )
          : Offstage(),
    );
  }
}

class GridPaginationListBuilder<T> extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final bool stopScroll;

  // final bool withRefresh;
  final SliverGridDelegate gridDelegate;
  final PagingController<int, T> pagingController;

  // final Widget Function(T,int) itemBuilder;
  final PaginationItemBuilder<T> itemBuilder;
  final Widget? pageProgressIndicatorBuilder;
  final Axis? scrollDirection;
  final Widget? noMoreItemsWidget;
  final Widget? emptyDataWidget;
  final bool showNoMoreWidget;
  final bool shrinkWrap;
  final bool primary;

  const GridPaginationListBuilder({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.gridDelegate,
    this.scrollDirection,
    this.pageProgressIndicatorBuilder,
    this.padding,
    this.noMoreItemsWidget,
    this.emptyDataWidget,
    this.stopScroll = false,
    this.shrinkWrap = true,
    this.primary = true,
    // this.withRefresh = true,
    this.showNoMoreWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, T>(
      gridDelegate: gridDelegate,
      pagingController: pagingController,
      scrollDirection: scrollDirection ?? Axis.vertical,
      shrinkWrap: shrinkWrap,
      padding: padding,
      primary: primary,
      // addRepaintBoundaries: true,
      showNewPageProgressIndicatorAsGridChild: false,
      showNewPageErrorIndicatorAsGridChild: false,
      // showNoMoreItemsIndicatorAsGridChild: false,
      physics: stopScroll
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<T>(
        animateTransitions: false,
        // transitionDuration: Duration.zero,
        firstPageProgressIndicatorBuilder: (context) {
          return Center(
            child: pageProgressIndicatorBuilder ?? const LoadingProgressBar(),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return pageProgressIndicatorBuilder ?? const LoadingProgressBar();
        },
        firstPageErrorIndicatorBuilder: (context) => RetryWidget(
          onRetry: pagingController.refresh,
          iconData: Icons.info_outline,
        ),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: SizedBox(
            height: scrollDirection == Axis.horizontal ? null : 0.5,
            child: emptyDataWidget ?? const EmptyDataWidget(),
          ),
        ),
        // noMoreItemsIndicatorBuilder: !showNoMoreWidget
        //     ? null
        //     : (context) => NoMoreItems(
        //           noMoreWidget: noMoreItemsWidget,
        //         ),
        itemBuilder: (context, item, index) {
          var wd = itemBuilder.call(item, index);
          return DelayedDisplay(
            delay: const Duration(milliseconds: 300),
            fadingDuration: const Duration(milliseconds: 150),
            slidingCurve: Curves.easeInOut,
            // fadingDuration: Duration(milliseconds: 900),
            child: wd,
          );
        },
      ),
    );
  }
}

class SliverPaginationListBuilder<T> extends StatelessWidget {
  const SliverPaginationListBuilder({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.pageProgressIndicatorBuilder,
    this.padding,
    this.witSeparator = true,
    this.showNoMoreItem = true,
    this.noMoreItemsWidget,
    this.emptyDataWidget,
    this.inHorizontal = false,
    this.stopScroll = false,
    this.emptyDataWidgetWidth,
    this.emptyDataWidgetHeight,
    this.emptyDataMessage,
    this.errorWidget,
    // this.withRefresh = true,
  });

  final bool witSeparator;
  final bool showNoMoreItem;
  final EdgeInsetsGeometry? padding;
  final PagingController<int, T> pagingController;

  // final Widget Function(T,int) itemBuilder;
  final PaginationItemBuilder<T> itemBuilder;
  final Widget? pageProgressIndicatorBuilder;
  final Widget? noMoreItemsWidget;
  final Widget? emptyDataWidget;
  final String? emptyDataMessage;
  final Widget? errorWidget;
  final bool inHorizontal;
  final bool stopScroll;

  // final bool withRefresh;
  final double? emptyDataWidgetWidth;
  final double? emptyDataWidgetHeight;

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, T>.separated(
      pagingController: pagingController,
      // scrollDirection: inHorizontal ? Axis.horizontal : Axis.vertical,
      // shrinkWrap: true,
      // padding: padding,
      // primary: false,
      // addRepaintBoundaries: false,
      // physics: stopScroll
      //     ? const NeverScrollableScrollPhysics()
      //     : const BouncingScrollPhysics(),
      // shrinkWrapFirstPageIndicators: true,

      builderDelegate: PagedChildBuilderDelegate<T>(
        animateTransitions: false,
        // transitionDuration: Duration.zero,
        firstPageProgressIndicatorBuilder: (context) {
          return Center(
            child: pageProgressIndicatorBuilder ?? const LoadingProgressBar(),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return pageProgressIndicatorBuilder ??
              LoadingProgressBar(
                inHorizontal: inHorizontal,
              );
        },
        firstPageErrorIndicatorBuilder: (context) =>
            errorWidget ??
            RetryWidget(
              onRetry: pagingController.refresh,
              iconData: Icons.info_outline,
            ),
        // noMoreItemsIndicatorBuilder: (context) => const Text('NO MORE'),
        noItemsFoundIndicatorBuilder: (context) => Center(
          child: SizedBox(
            width: emptyDataWidgetWidth,
            child: emptyDataWidget ??
                EmptyDataWidget(
                  text: emptyDataMessage,
                  imageHeight: emptyDataWidgetHeight ??
                      (inHorizontal
                          ? MediaQuery.of(context).size.height / 2
                          : null),
                ),
          ),
        ),
        noMoreItemsIndicatorBuilder: showNoMoreItem == false
            ? null
            : (context) => NoMoreItems(
                  noMoreWidget: noMoreItemsWidget,
                  inHorizontal: inHorizontal,
                ),
        itemBuilder: (context, item, index) => DelayedDisplay(
          delay: const Duration(milliseconds: 300),
          fadingDuration: const Duration(milliseconds: 150),
          slidingCurve: Curves.easeInOut,
          slidingBeginOffset:
              !inHorizontal ? const Offset(0.0, 0.35) : const Offset(0.35, 0.0),
          // fadingDuration: Duration(milliseconds: 900),
          child: itemBuilder.call(item, index),
        ),
      ),
      separatorBuilder: (context, index) =>
          witSeparator ? const Divider() : Container(),
    );
  }
}

class SliverGridPaginationListBuilder<T> extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final bool stopScroll;
  final bool shrinkWrap;

  // final bool withRefresh;
  final SliverGridDelegate gridDelegate;
  final PagingController<int, T> pagingController;

  // final Widget Function(T,int) itemBuilder;
  final PaginationItemBuilder<T> itemBuilder;
  final Widget? pageProgressIndicatorBuilder;
  final Axis? scrollDirection;
  final Widget? noMoreItemsWidget;
  final Widget? emptyDataWidget;
  final bool showNoMoreWidget;

  const SliverGridPaginationListBuilder({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.gridDelegate,
    this.scrollDirection,
    this.pageProgressIndicatorBuilder,
    this.padding,
    this.noMoreItemsWidget,
    this.emptyDataWidget,
    this.stopScroll = false,
    this.shrinkWrap = true,
    // this.withRefresh = true,
    this.showNoMoreWidget = true,
  });

  @override
  Widget build(BuildContext context) {
    return PagedSliverGrid<int, T>(
      gridDelegate: gridDelegate,
      pagingController: pagingController,
      shrinkWrapFirstPageIndicators: shrinkWrap,
      addRepaintBoundaries: true,
      showNewPageProgressIndicatorAsGridChild: false,
      showNewPageErrorIndicatorAsGridChild: false,
      showNoMoreItemsIndicatorAsGridChild: false,
      builderDelegate: PagedChildBuilderDelegate<T>(
        firstPageProgressIndicatorBuilder: (context) {
          return Center(
            child: pageProgressIndicatorBuilder ?? const LoadingProgressBar(),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return pageProgressIndicatorBuilder ?? const LoadingProgressBar();
        },
        firstPageErrorIndicatorBuilder: (context) => RetryWidget(
          onRetry: pagingController.refresh,
          errorMessage: pagingController.error?.toString(),
          iconData: Icons.info_outline,
        ),
        noItemsFoundIndicatorBuilder: (context) =>
            emptyDataWidget ?? const EmptyDataWidget(),
        noMoreItemsIndicatorBuilder: !showNoMoreWidget
            ? null
            : (context) => DelayedDisplay(
                  delay: const Duration(milliseconds: 300),
                  fadingDuration: const Duration(milliseconds: 150),
                  slidingCurve: Curves.easeInOut,
                  child: NoMoreItems(
                    inHorizontal: scrollDirection == Axis.horizontal,
                    noMoreWidget: noMoreItemsWidget,
                  ),
                ),
        itemBuilder: (context, item, index) {
          var wd = itemBuilder.call(item, index);
          return DelayedDisplay(
            delay: const Duration(milliseconds: 300),
            fadingDuration: const Duration(milliseconds: 150),
            slidingCurve: Curves.easeInOut,
            // fadingDuration: Duration(milliseconds: 900),
            child: wd,
          );
        },
      ),
    );
  }
}

class NoMoreItems extends StatelessWidget {
  final Widget? noMoreWidget;
  final bool inHorizontal;

  const NoMoreItems({super.key, this.noMoreWidget, required this.inHorizontal});

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: const Duration(milliseconds: 400),
      fadingDuration: const Duration(milliseconds: 150),
      slidingCurve: Curves.easeInOut,
      slidingBeginOffset:
          !inHorizontal ? const Offset(0.0, 0.35) : const Offset(0.35, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Flexible(
            child: Divider(
              indent: 30,
              endIndent: 30,
            ),
          ),
          noMoreWidget ??
              Text(
                AppStrings.noMoreItem.tr.capitalizeFirst!,
              ),
          const Flexible(
            child: Divider(
              indent: 30,
              endIndent: 30,
            ),
          ),
        ],
      ).marginSymmetric(
        vertical: 8.0,
      ),
    );
  }
}

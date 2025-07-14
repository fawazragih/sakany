import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/product_summary.dart';
import 'package:sakani/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani/app/global_widget/empty_data_widget.dart';
import 'package:sakani/app/global_widget/pagination_list_builder.dart';
import 'package:sakani/app/global_widget/shimmer_list.dart';
import 'package:sakani/app/modules/product_list_page/widgets/filter_and_sort_widget.dart';
import 'package:sakani/app/modules/search_page/widgets/adv_search_bottom_sheet.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../home_page/widgets/product_box/horizontal_product_template.dart';
import 'search_controller.dart';

class SearchPage extends GetView<SearchPageController> {
  static const String routeName = 'app/search';

  const SearchPage({super.key});

  @override
  SearchPageController get controller {
    if (!Get.isRegistered<SearchPageController>()) {
      Get.put(SearchPageController());
    }
    return super.controller;
  }

  @override
  Widget build(BuildContext context) {
    // controller.onInit();
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.SEARCH_BUTTON.tr.translate,
      ),
      body: RefreshIndicator(
          onRefresh: () async => controller.pagingController.refresh(),
          child: CustomScrollView(
            slivers: [
              /*SliverToBoxAdapter(
                  child: Row(
                    children: [
                      //region
                      // Expanded(
                      //   child: TypeAheadField<SearchSuggestionData>(
                      //     hideOnEmpty: true,
                      //     debounceDuration: const Duration(milliseconds: 350),
                      //     suggestionsCallback: (pattern) async {
                      //       if (pattern.length < 3) return [];
                      //       return await controller.fetchSuggestions(pattern);
                      //     },
                      //     itemBuilder: (context, suggestion) {
                      //       return Padding(
                      //         padding: EdgeInsets.all(8.0.r),
                      //         child: Text(suggestion.label ?? ''),
                      //       );
                      //     },
                      //     hideOnLoading: false,
                      //     onSelected: (SearchSuggestionData suggestion) {
                      //       Get.toNamed(
                      //         ProductsDetailsPage.routeName,
                      //         arguments: ProductDetailsScreenArguments(
                      //           id: suggestion.productId,
                      //           name: suggestion.label,
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      //endregion
                      IconButton(
                        onPressed: () => showAdvSearchOptions(),
                        icon: GetBuilder<SearchPageController>(
                          id: controller.avdSearchButtonId,
                          builder: (controller) {
                            return Icon(
                              Icons.filter_list,
                              color: controller.searchResponse
                                  ?.advSearchSelected ==
                                  true
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).dividerColor,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )*/
              //region search bar
              SliverToBoxAdapter(
                child: SearchBar(
                  onChanged: controller.onSearchChange,
                  constraints: const BoxConstraints(minHeight: 50),
                  autoFocus: false,
                  hintText: AppStrings.typeWhatAreLookingFor.tr.capitalize,
                  hintStyle: WidgetStatePropertyAll(
                    Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  trailing: [
                    IconButton(
                      onPressed: () => showAdvSearchOptions(),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon: GetBuilder<SearchPageController>(
                        id: controller.avdSearchButtonId,
                        builder: (controller) {
                          return Icon(
                            CupertinoIcons.line_horizontal_3_decrease,
                            color:
                                controller.searchResponse?.advSearchSelected ==
                                        true
                                    ? Theme.of(context).primaryColorDark
                                    : Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.7),
                          );
                        },
                      ),
                    ),
                  ],
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).disabledColor.withOpacity(0.7),
                  ).paddingDirection(
                    start: 8.0,
                  ),
                  elevation: const WidgetStatePropertyAll(0.0),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).dividerColor,
                  ),
                ).marginSymmetric(
                  vertical: 12.0,
                ),
              ),
              //endregion

              //region filter and sort
              SliverToBoxAdapter(
                child: GetBuilder<SearchPageController>(
                  id: controller.filterOptionId,
                  builder: (controller) {
                    if (controller.hasFilterOption ||
                        controller.hasSortOption) {
                      return FilterAndSearchWidget(
                        hasFilterOption: controller.hasFilterOption,
                        openFilterOptions: controller.openFilterOptions,
                        hasSortOption: controller.hasSortOption,
                        openSortOptions: controller.openSortOptions,
                      );
                    }
                    return Offstage();
                  },
                ),
              ),
              //endregion

              //region PaginationListBuilder
              GetBuilder<SearchPageController>(
                id: controller.paginationListBuilderId,
                builder: (controller) {
                  return SliverGridPaginationListBuilder<ProductSummary>(
                    pagingController: controller.pagingController,
                    pageProgressIndicatorBuilder: AppReadyShimmerList(
                      inGrid: true,
                      horizontal: false,
                      imageHeight: 180.0.h,
                      containerWidth: double.infinity,
                      itemCount: 12,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1.0.sh > 1.0.sw
                            ? (1.0.sh / 1.0.sw).round()
                            : (1.0.sw / 1.0.sh).round(),
                        childAspectRatio: 0.73,
                        // mainAxisExtent: AppConstants.productBoxHeight,
                      ),
                    ),
                    emptyDataWidget: EmptyDataWidget(
                      imageHeight: 0.4.sh,
                      iconSize: 0.3.sh,
                      iconData: controller.apiFilter.search.isNullOrEmpty
                          ? CupertinoIcons.doc_text_search
                          : null,
                      text: controller.apiFilter.search.isNullOrEmpty
                          ? AppStrings.typeWhatAreLookingFor.tr.capitalizeFirst
                          : null,
                      textStyle:
                          Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).disabledColor,
                              ),
                    ).marginOnly(
                      bottom: 0.11.sh,
                      top: 0.11.sh,
                    ),
                    itemBuilder: (ProductSummary item, int index) {
                      return HorizontalProductTemplate(item);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1.0.sh > 1.0.sw
                          ? (1.0.sh / 1.0.sw).round()
                          : (1.0.sw / 1.0.sh).round(),
                      childAspectRatio: 0.73,
                      // mainAxisExtent: AppConstants.productBoxHeight,
                    ),
                  );
                },
              ),
              //endregion
            ],
          ).paddingSymmetric(
            horizontal: SharedStyle.horizontalScreenPadding,
          )),
    );
  }

  void showAdvSearchOptions() {
    controller.hideSoftKeyBoard();
    var model = controller.searchResponse;
    var isAvdSearchEnabled = controller.searchResponse?.advSearchSelected;
    logger.d(isAvdSearchEnabled);
    if (model != null) {
      Get.bottomSheet(
        AdvSearchBottomSheet(model: model),
      ).whenComplete(() {
        // update advanced search button icon
        logger.w(controller.searchResponse?.advSearchSelected);
        if (controller.searchResponse?.advSearchSelected !=
            isAvdSearchEnabled) {
          controller.update([controller.avdSearchButtonId]);
        }
      });
    }
  }
}

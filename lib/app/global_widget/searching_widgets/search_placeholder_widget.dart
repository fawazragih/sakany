import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/assets_helpers/app_icons.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme/input_decoration_style.dart';
import '../app_ui_helper/shared_style.dart';
import '../app_ui_helper/ui_helpers.dart';
import 'input_searching_widget.dart';

class SearchBarPlaceHolder extends StatelessWidget {
  const SearchBarPlaceHolder({
    super.key,
    this.searchText,
    this.onTap,
    this.enableSearch = false,
    this.onSearchChange,
    this.onFilterTap,
    this.color,
    this.borderColor,
    this.showFilter = false,
    this.borderRadius = AppInputDecorationStyle.inputFromWidgetRadius,
    this.elevation = 0,
    this.onClearSearch,
    this.padding,
    // this.textInputWidth,
  });

  final EdgeInsetsGeometry? padding;
  final String? searchText;
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final AsyncValueSetter<String?>? onSearchChange;
  final VoidCallback? onClearSearch;
  final bool enableSearch;
  final bool showFilter;
  final double borderRadius;
  final double? elevation;
  // final double? textInputWidth;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    // assert(
    //   enableSearch && textInputWidth != null,
    //   'enableSearch && textInputWidth != null',
    // );
    return Container(
      padding: padding,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: enableSearch ? null : onTap,
              //     Get.toNamed(ChooseLocationBeforeSearchView.id),
              child: enableSearch
                  ? InputSearchingWidget(
                      elevation: elevation,
                      onSearchChange: onSearchChange,
                      onClearSearch: onClearSearch,
                      searchText: searchText,
                      color: color,
                      // borderColor: borderColor,
                    )
                  : UnEnabledSearchWidget(
                      borderRadius: borderRadius,
                    ),
            ),
          ),
          if (showFilter) ...[
            UiHelper.horizontalSpaceSmall,
            Card(
              elevation: elevation,
              shape: SharedStyle.roundedRectangleBorder(
                radius: 12.0,
              ),
              margin: EdgeInsets.zero,
              color: Theme.of(context).colorScheme.primary,
              shadowColor:
                  Get.theme.colorScheme.primaryContainer.withOpacity(0.9),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onFilterTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 18,
                  ),
                  child: SvgPicture.asset(
                    SvgAppIcons.filterIcon,
                    height: 16.sp,
                    width: 16.sp,
                  ),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}

class UnEnabledSearchWidget extends StatelessWidget {
  const UnEnabledSearchWidget({
    super.key,
    required this.borderRadius,
  });

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.theme.primaryColorDark,
      shape: SharedStyle.roundedRectangleBorder(
        radius: borderRadius,
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.search,
              color: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.color
                  ?.withOpacity(0.4),
              size: 25.r,
            ),
            UiHelper.horizontalSpaceSmall,
            Text(
              AppStrings.search.tr.capitalize!,
              style: SharedStyle.subtitle2(
                color:
                    Theme.of(context).textTheme.bodySmall?.color?.withOpacity(
                          0.4,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

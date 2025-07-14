import 'package:flutter/material.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';

import '../../../utils/constants/const_strings.dart';

class FilterAndSearchWidget extends StatelessWidget {
  final bool hasFilterOption;
  final bool hasSortOption;
  final VoidCallback openFilterOptions;
  final VoidCallback openSortOptions;

  const FilterAndSearchWidget({
    super.key,
    required this.hasFilterOption,
    required this.openFilterOptions,
    required this.hasSortOption,
    required this.openSortOptions,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (hasFilterOption)
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: openFilterOptions,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ConstStrings.FILTER.translate),
                    const Icon(Icons.filter_alt_rounded),
                  ],
                ),
              ),
            ),
          UiHelper.horizontalSpaceSmall,
          if (hasSortOption)
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: openSortOptions,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ConstStrings.CATALOG_ORDER_BY.translate),
                    const Icon(Icons.sort),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

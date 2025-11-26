import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/manufacturer_filter.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/bottome_sheet_widgets/bottom_sheet_top_container.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';

import '../../../utils/constants/const_strings.dart';

class SortOptionsBuilderWidget extends StatelessWidget {
  const SortOptionsBuilderWidget({
    super.key,
    required this.options,
    required this.onSortBy,
  });

  final List<AvailableSortOption> options;
  final ValueChanged<AvailableSortOption> onSortBy;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBottomSheetDecorator(
            margin: EdgeInsets.symmetric(
              vertical: 16.0.h,
            ),
          ),
          Text(
            ConstStrings.CATALOG_ORDER_BY.translate,
            style: Theme.of(context).textTheme.bodyLarge?.withBoldFont,
          ),
          UiHelper.verticalSpaceSmall,
          Divider(height: 0),
          UiHelper.verticalSpaceMedium,
          ListView.separated(
            itemCount: options.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 0,
            ),
            itemBuilder: (BuildContext context, int index) {
              AvailableSortOption e = options[index];
              return AppCard(
                withShadow: false,
                // padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                radius: 8,
                // color: Colors.green,
                onTap: () => onSortBy.call(e),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (e.selected == true)
                        Container(
                          width: 10,
                          color: Theme.of(Get.context!).colorScheme.primary,
                        ),
                      Text(
                        e.text ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: e.selected == true
                                ? Theme.of(Get.context!).colorScheme.primary
                                : Theme.of(Get.context!).primaryColorDark
                            // : Styles.textColor(context),
                            ),
                      ).paddingSymmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 16.0),
    );
  }
}

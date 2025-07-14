import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/category_tree/category_tree_response.dart';

import '../../../global_widget/my_card_design.dart';

class SideCatsBuilder extends StatelessWidget {
  final List<CategoryTreeResponseData> sideCats;
  final int? selectedSidCatId;
  final ValueChanged<CategoryTreeResponseData> onSelectedSideCatChange;

  const SideCatsBuilder({
    super.key,
    required this.sideCats,
    required this.selectedSidCatId,
    required this.onSelectedSideCatChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: sideCats.length,
      itemBuilder: (BuildContext context, int index) {
        var cat = sideCats[index];
        bool isSelected = selectedSidCatId == cat.categoryId;
        return AppCard(
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
          radius: 12.0,
          borderRadius: SmoothBorderRadiusExt.directional(
            context: context,
            bottomEnd: 12.r,
            topEnd: 12.r,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 6.0,
          ),
          hasBorder: false,
          onTap: () => onSelectedSideCatChange.call(cat),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 6,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadiusDirectional.horizontal(
                          end: Radius.circular(4.0))),
                ),
                Expanded(
                  child: Text(
                    cat.name ?? cat.seName ?? 'no name',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          height: 1.3,
                          color: !isSelected
                              ? null
                              : Theme.of(context).colorScheme.onPrimary,
                        ),
                  ).paddingSymmetric(vertical: 10.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

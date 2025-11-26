import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/data/models/category_tree/category_tree_response.dart';

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
    return Wrap(
      spacing: 9.4.w, // المسافة بين العناصر أفقياً
      runSpacing: 8.0.h, // المسافة بين الصفوف عمودياً
      children: sideCats.map((cat) {
        bool isSelected = selectedSidCatId == cat.categoryId;
        return GestureDetector(
          onTap: () => onSelectedSideCatChange.call(cat),
          child: Container(
            width: 108.w,
            padding:   EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[300],
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: Center(
              child: Text(
                cat.name ?? cat.seName ?? 'no name',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected ? Theme.of(context).colorScheme.onPrimary : Colors.black,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

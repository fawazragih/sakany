import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/data/models/category_tree/category_tree_response.dart';
import 'package:sakani_mobile_app/app/global_widget/empty_data_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/generic_image_and_name_template.dart';

class SubSideCatsBuilder extends StatelessWidget {
  final List<CategoryTreeResponseData> sideSubCatsList;
  final ValueChanged<CategoryTreeResponseData> onLeaveCatTap;
  final SliverGridDelegate gridDelegate;

  const SubSideCatsBuilder({
    super.key,
    required this.sideSubCatsList,
    required this.onLeaveCatTap,
    required this.gridDelegate,
  });

  @override
  Widget build(BuildContext context) {
    return sideSubCatsList.isNullOrEmpty
        ? EmptyDataWidget(
            text: AppStrings.noSubCat.tr.capitalizeFirst,
          )
        : GridView.builder(
            primary: false,
            // physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: gridDelegate,
            padding: EdgeInsets.zero,
            itemCount: sideSubCatsList.length,
            itemBuilder: (BuildContext context, int index) {
              CategoryTreeResponseData? cat = sideSubCatsList[index];
              return Align(
                alignment: Alignment.topCenter,
                child: GenericImageAndNameInColumnTemplate<
                    CategoryTreeResponseData>(
                  item: cat,
                  imageShape: BoxShape.circle,
                  onTap: onLeaveCatTap,
                  imgBorderRadius: 8.0,
                  imgHeight: 70.h,
                  imgWidth: 70.h,
                  imageFit: BoxFit.cover,
                  bgColor: Theme.of(context).colorScheme.secondary,
                  name: (cat) => cat.name ?? cat.seName ?? 'no name',
                  image: (cat) => cat.iconUrl ?? '',
                ),
              );
            },
          );
  }
}

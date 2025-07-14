import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/data/models/filter_model.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/bottome_sheet_widgets/bottom_sheet_top_container.dart';
import '../../../../data/models/catalog_products_model.dart';
import 'manufacturer_filter.dart';
import 'price_range_filter_widget.dart';
import 'specification_filter.dart';

class FiltersBuilderWidget extends StatelessWidget {
  final CatalogProductsModel catalogProductsModel;
  final ApiFilter filter;
  final VoidCallback onAppLyFilter;
  final VoidCallback onClearFilter;

  // final ProductListBloc bloc;

  const FiltersBuilderWidget({
    super.key,
    required this.catalogProductsModel,
    required this.filter,
    required this.onAppLyFilter,
    required this.onClearFilter,
  });

  bool get showSpecificationFilterList {
    return (catalogProductsModel.specificationFilter?.enabled ?? false) &&
        (catalogProductsModel.specificationFilter?.attributes?.length ?? 0) > 0;
  }

  bool get showManufacturerFilterList {
    return (catalogProductsModel.manufacturerFilter?.enabled ?? false) &&
        (catalogProductsModel.manufacturerFilter?.manufacturers?.length ?? 0) >
            0;
  }

  bool get showPriceRangeFilter =>
      catalogProductsModel.priceRangeFilter?.enabled ?? false;

  void _applyFilter(String min, String max) {
    // filter.price = '${txtMin.text}-${txtMax.text}';
    filter.price = '$min-$max';
    String specs = '';
    String ms = '';

    List<String> specsArr = [];
    List<String> msArr = [];

    catalogProductsModel.specificationFilter?.attributes?.forEach((attr) {
      attr.values?.forEach((val) {
        if (val.selected ?? false) {
          specsArr.add(val.id.toString());
        }
      });
    });

    for (var i = 0; i < specsArr.length; i++) {
      if (i != specsArr.length - 1) {
        specs += '${specsArr[i]},';
      } else {
        specs += specsArr[i];
      }
    }

    filter.specs = specs;

    catalogProductsModel.manufacturerFilter?.manufacturers
        ?.forEach((manufacturer) {
      if ((manufacturer.selected ?? false) && (manufacturer.value != null)) {
        msArr.add(manufacturer.value!);
      }
    });

    for (var i = 0; i < msArr.length; i++) {
      if (i != msArr.length - 1) {
        ms += '${msArr[i]},';
      } else {
        ms += msArr[i];
      }
    }

    filter.ms = ms;

    // widget.filter.fetchProductList();
    onAppLyFilter.call();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController txtMin = TextEditingController();
    final TextEditingController txtMax = TextEditingController();
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0))),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: 12.0
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBottomSheetDecorator(
              margin: EdgeInsets.symmetric(vertical: 12.0),
              color: Theme.of(context).colorScheme.primary,
            ),
            if (showPriceRangeFilter)
              // ... priceRangeFilter(
              //       widget.catalogProductsModel.priceRangeFilter?.availablePriceRange?.from ??
              //           0,
              //       widget.catalogProductsModel.priceRangeFilter?.availablePriceRange?.to ??
              //           0,
              //     )
              PriceRangeFilterWidget(
                txtMax: txtMax,
                txtMin: txtMin,
                priceRangeFilter: catalogProductsModel.priceRangeFilter!,
              ),
            // if (showSpecificationFilterList)
            ...[
              Divider(),
              // ...specificationFilter(
              //     widget.catalogProductsModel.specificationFilter?.attributes ??
              //         []),
              SpecificationFilterWidget(
                attributes:
                    catalogProductsModel.specificationFilter?.attributes ?? [],
              )
            ],
            if (showManufacturerFilterList) ...[
              Divider(),
              // ...manufacturerFilter(widget.catalogProductsModel.manufacturerFilter?.manufacturers ?? [],),
              ManufacturerFilterWidget(
                  manufactures:
                      catalogProductsModel.manufacturerFilter?.manufacturers ??
                          []),
            ],
            Divider(
              height: 0,
            ).marginSymmetric(
              vertical: 12.0.h,
            ),
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    text: AppStrings.applyFilter.tr.capitalizeFirst,
                    // shape: ButtonShape.RoundedTopLeft,
                    onPressed: () => _applyFilter(
                      txtMin.text,
                      txtMax.text,
                    ),
                    backgroundColor: Theme.of(context).primaryColorDark,
                    // backgroundColor: Styles.secondaryButtonColor,
                  ),
                ),
                UiHelper.horizontalSpaceMedium,
                Expanded(
                  child: ActionButton(
                    // text: 'Clear All',
                    text: AppStrings.resetFilter.tr.capitalizeFirst,
                    // shape: ButtonShape.RoundedTopRight,
                    onPressed: onClearFilter,
                    backgroundColor: Theme.of(context).primaryColorDark,
                  ),
                ),
              ],
            ),
            UiHelper.verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani_mobile_app/app/global_widget/all_form_widgets/check_box_form_field.dart';
import 'package:sakani_mobile_app/app/global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/bottome_sheet_widgets/bottom_sheet_top_container.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../../data/models/available_option.dart';
import '../../../data/models/search_response.dart';

class AdvSearchBottomSheet extends StatelessWidget {
  final SearchData model;

  const AdvSearchBottomSheet({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0))),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TopBottomSheetDecorator(
              margin: EdgeInsets.symmetric(
                vertical: 16.0.h,
              ),
            ),

            //region ADVANCED_SEARCH
            CheckBoxFormFieldWidget(
              keyName: '',
              label: ConstStrings.ADVANCED_SEARCH.translate,
              initialValue: model.advSearchSelected ?? false,
              onChanged: (value) => model.advSearchSelected = value,
            ),
            //endregion

            //region SEARCH_CATEGORY
            Row(
              children: [
                Text(
                  ConstStrings.SEARCH_CATEGORY.translate,
                ),
                UiHelper.horizontalSpaceSmall,
                Expanded(
                  child: AppDropDownMenuFormFieldWidget<AvailableOption?>(
                    keyName: 'keyName',
                    getItemName: (item) => item?.text ?? '',
                    initialValue: model.availableCategories?.firstWhereOrNull(
                          (category) =>
                              (int.tryParse(category.value ?? '') ?? 0) ==
                              (model.categoryId ?? 0),
                        ) ??
                        model.availableCategories?.firstOrNull,
                    itemsList: model.availableCategories ?? [],
                    onChanged: (value) => model.categoryId =
                        int.tryParse(value?.value ?? '') ?? 0,
                  ),
                ),
              ],
            ),
            //endregion

            //region AUTOMATICALLY_SEARCH_SUBCATEGORIES
            CheckBoxFormFieldWidget(
              keyName: ConstStrings.AUTOMATICALLY_SEARCH_SUBCATEGORIES,
              label: ConstStrings.AUTOMATICALLY_SEARCH_SUBCATEGORIES.translate,
              initialValue: model.searchInSubcategory ?? false,
              onChanged: (value) => model.searchInSubcategory = value,
            ),
            //endregion

            //region SEARCH_MANUFACTURER
            Row(
              children: [
                Text(
                  ConstStrings.SEARCH_MANUFACTURER.translate,
                ),
                UiHelper.horizontalSpaceSmall,
                Expanded(
                  child: AppDropDownMenuFormFieldWidget<AvailableOption?>(
                    keyName: '2',
                    initialValue: model.availableManufacturers
                            ?.firstWhereOrNull(
                          (manufacturer) =>
                              (int.tryParse(manufacturer.value ?? '') ?? 0) ==
                              (model.manufacturerId ?? 0),
                        ) ??
                        model.availableManufacturers?.firstOrNull,
                    getItemName: (item) => item?.text ?? '',
                    itemsList: model.availableManufacturers ?? List.empty(),
                    onChanged: (value) => model.manufacturerId =
                        int.tryParse(value?.value ?? '') ?? 0,
                  ),
                ),
              ],
            ),
            //endregion

            //region allowVendorSearch
            if ((model.allowVendorSearch ?? false) == true)
              Row(
                children: [
                  Text(
                    ConstStrings.SEARCH_VENDOR.translate,
                  ),
                  Expanded(
                    child: AppDropDownMenuFormFieldWidget<AvailableOption?>(
                      keyName: '3',
                      initialValue: model.availableVendors?.firstWhereOrNull(
                            (vendor) =>
                                (int.tryParse(vendor.value ?? '') ?? 0) ==
                                (model.vendorId ?? 0),
                          ) ??
                          model.availableVendors?.firstOrNull,
                      getItemName: (item) => item?.text ?? '',
                      itemsList: model.availableVendors ?? List.empty(),
                      onChanged: (value) {
                        model.vendorId = int.tryParse(value?.value ?? '') ?? 0;
                      },
                    ),
                  ),
                ],
              ),
            //endregion

            //region SEARCH_IN_PRODUCT_DISCRIPTIONS
            CheckBoxFormFieldWidget(
              keyName: ConstStrings.SEARCH_IN_PRODUCT_DISCRIPTIONS,
              label: ConstStrings.SEARCH_IN_PRODUCT_DISCRIPTIONS.translate,
              initialValue: model.searchInDescription ?? false,
              onChanged: (value) => model.searchInDescription = value,
            ),
            //endregion
          ],
        ),
      ),
    );
  }
}

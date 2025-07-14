import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani/app/core/language_and_localization/app_strings.dart';
import 'package:sakani/app/data/models/manufacturer_filter.dart';

import '../../../../global_widget/app_ui_helper/ui_helpers.dart';

class ManufacturerFilterWidget extends StatefulWidget {
  final List<AvailableSortOption> manufactures;

  const ManufacturerFilterWidget({super.key, required this.manufactures});

  @override
  State<ManufacturerFilterWidget> createState() =>
      _ManufacturerFilterWidgetState();
}

class _ManufacturerFilterWidgetState extends State<ManufacturerFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.filterByManufacturer.tr} :',
          style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
        ),
        UiHelper.verticalSpaceMedium,
        ...widget.manufactures.map<Widget>((e) => CheckboxListTile(
            title: Text(
              e.text ?? '',
              style: Theme.of(context).textTheme.bodySmall.withBoldFont,
            ),
            value: e.selected ?? false,
            onChanged: (_) {
              setState(() {
                e.selected = !(e.selected ?? false);
              });
            })),
      ],
    );
  }
}

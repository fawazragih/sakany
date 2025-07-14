import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani/app/data/models/product_list/product_list_response.dart';

import '../../../../global_widget/app_ui_helper/ui_helpers.dart';
import '../../../../utils/constants/const_strings.dart';

class SpecificationFilterWidget extends StatefulWidget {
  final List<Attribute> attributes;

  const SpecificationFilterWidget({super.key, required this.attributes});

  @override
  State<SpecificationFilterWidget> createState() =>
      _SpecificationFilterWidgetState();
}

class _SpecificationFilterWidgetState extends State<SpecificationFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: widget.attributes
            .map<Widget>((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (e.values?.isNotNullOrEmpty == true) ...[
                      Text(
                        '${ConstStrings.FILTER_SPECIFICATION.translate}: ${e.name} :'
                            .translate,
                        style:
                            Theme.of(context).textTheme.bodySmall?.withBoldFont,
                      ),
                      UiHelper.verticalSpaceMedium,
                      ...e.values
                              ?.map<Widget>((e) => e.colorSquaresRgb != null
                                  ? CheckboxListTile(
                                      secondary: Container(
                                        width: 30.w,
                                        height: 30.h,
                                        decoration: BoxDecoration(
                                            color: e.colorSquaresRgb?.toColor,
                                            shape: BoxShape.circle),
                                      ),
                                      title: Text(
                                        e.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .withBoldFont,
                                      ),
                                      value: e.selected ?? false,
                                      onChanged: (_) {
                                        setState(() {
                                          e.selected = !(e.selected ?? false);
                                        });
                                      })
                                  : CheckboxListTile(
                                      title: Text(
                                        e.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            .withBoldFont,
                                      ),
                                      value: e.selected ?? false,
                                      onChanged: (_) {
                                        setState(() {
                                          e.selected = !(e.selected ?? false);
                                        });
                                      }))
                              .toList() ??
                          [],
                    ]
                  ],
                ))
            .toList());
  }
}

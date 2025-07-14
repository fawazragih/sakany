import 'package:app_extensions/app_extensions.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

class FullDescriptionWidget extends StatelessWidget {
  // final String title;
  final String? fullDescription;

  const FullDescriptionWidget({super.key, required this.fullDescription});

  @override
  Widget build(BuildContext context) {
    var divider = Divider(
      height: 0.0,
    );

    if (fullDescription.isNullOrEmpty == true) {
      return Offstage();
    }

    return Column(
      children: [
        const Divider(height: 0),
        ExpandablePanel(
          controller: ExpandableController(initialExpanded: true),
          header: Text(
            ConstStrings.PRODUCT_DESCRIPTION.translate,
            style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
          ),
          collapsed: const Offstage(),
          expanded: Html(
            data: fullDescription ?? '',
            style: htmlNoPaddingStyle(),
          ).marginOnly(bottom: 12.0),
          theme: const ExpandableThemeData(
            hasIcon: true,
            alignment: Alignment.center,
            iconPadding: EdgeInsets.symmetric(vertical: 8.0),
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            useInkWell: true,
          ),
        ),
        const Divider(height: 0),
      ],
    ).marginOnly(bottom: 16.0.h);
  }
}

Map<String, Style> htmlNoPaddingStyle(
    {Map<String, Style>? style, double? fontSize}) {
  var styleMap = {
    "body": Style(
      fontSize: FontSize(fontSize?.sp ?? 16.0.sp),
      // textAlign: TextAlign.justify,
      margin: Margins.all(0),
    ),
  };

  if (style != null) styleMap.addAll(style);

  return styleMap;
}

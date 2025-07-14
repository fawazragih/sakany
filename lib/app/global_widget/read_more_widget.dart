import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rich_readmore/rich_readmore.dart';

import '../core/language_and_localization/app_strings.dart';

class AppReadMoreWidget extends StatelessWidget {
  final String text;
  final int? trimLines;

  const AppReadMoreWidget({
    super.key,
    required this.text,
    this.trimLines,
  });

  @override
  Widget build(BuildContext context) {
    return RichReadMoreText.fromString(
      text: text,
      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.3),
      settings: LineModeSettings(
        trimLines: trimLines ?? 3,
        textDirection: text.getTextDirection,
        trimCollapsedText:
            '...${AppStrings.showMore.tr.capitalizeFirst!}',
        trimExpandedText:
            '...${AppStrings.showLess.tr.capitalizeFirst!}',
        lessStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.3,
              color: Theme.of(context).colorScheme.primary,
            ),
        moreStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.3,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

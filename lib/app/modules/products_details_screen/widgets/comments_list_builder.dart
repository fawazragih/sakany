import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani/app/core/language_and_localization/app_strings.dart';

import '../../../global_widget/app_ui_helper/ui_helpers.dart';

class CommentsListBuilder extends StatelessWidget {
  const CommentsListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStrings.comments.tr.capitalizeFirst! ?? '',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        UiHelper.verticalSpaceSmall,
        Text(
          'comments go here',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

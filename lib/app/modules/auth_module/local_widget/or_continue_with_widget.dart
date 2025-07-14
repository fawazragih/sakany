import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrContinueWithWidget extends StatelessWidget {
  final String text;
  const OrContinueWithWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 0,
            // color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
        ),
        Text(
          text,
        ).marginSymmetric(
          horizontal: 12.0,
        ),
        const Expanded(
          child: Divider(
            height: 0,
            // color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    ).paddingSymmetric(
      horizontal: 16.w,
    );
  }
}

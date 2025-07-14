import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../my_card_design.dart';

class BottomSheetTitle extends StatelessWidget {
  final String title;
  final bool showCloseButton;
  final EdgeInsetsGeometry? padding;

  const BottomSheetTitle({
    super.key,
    required this.title,
    this.showCloseButton = true, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          AppCard(
            padding: const EdgeInsets.all(8.0),
            radius: 16,
            onTap: () => Get.back(),
            color: Theme.of(context).colorScheme.secondary,
            child: Icon(
              Icons.close,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}

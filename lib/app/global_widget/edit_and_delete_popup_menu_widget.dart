import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../core/language_and_localization/app_strings.dart';
import 'app_ui_helper/shared_style.dart';
import 'app_ui_helper/ui_helpers.dart';

class EditAndDeletePopupMenuWidget extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  final Offset? offset;

  const EditAndDeletePopupMenuWidget({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 1.5,
      padding: EdgeInsets.zero,
      // iconSize: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: SharedStyle.settingsIconPadding,
      ),
      onSelected: (value) {
        if (value == 0) {
          onEdit.call();
        }
        if (value == 1) {
          onDelete.call();
        }
      },
      offset: offset ?? Offset.zero,
      itemBuilder: (BuildContext bc) {
        return [
          PopupMenuItem(
            value: 0,
            height: 50.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UiHelper.horizontalSpaceVeryTiny,
                    Icon(
                      IconsaxPlusLinear.edit,
                      size: 20.r,
                    ),
                    UiHelper.horizontalSpaceVeryTiny,
                    UiHelper.horizontalSpaceMedium,
                    Text(
                      AppStrings.edit.tr.capitalizeFirst!,
                      style: Get.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 1,
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.delete,
                  size: 25.r,
                  color: Theme.of(context).colorScheme.error,
                ),
                UiHelper.horizontalSpaceMedium,
                Text(AppStrings.delete.tr.capitalizeFirst!,
                    style: Get.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ];
      },
      child: const Icon(
        Icons.more_vert_outlined,
      ),
    );
  }
}

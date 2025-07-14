import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme/theme_controller.dart';
import '../app_ui_helper/shared_style.dart';
import 'settings_icon_widget.dart';

class ThemeItem extends StatelessWidget {
  ThemeItem({
    super.key,
  });

  AppThemeController get appThemeController => Get.find<AppThemeController>();

  final ExpandableController expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    context.theme;
    RxBool expanded = RxBool(false);

    return Card(
      color:
          Get.isDarkMode ? Get.theme.primaryColorDark : Get.theme.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: SharedStyle.contentCardBorderRadius,
      ),
      // elevation: 5,
      clipBehavior: Clip.antiAlias,
      child: ExpandablePanel(
        collapsed: Container(),
        controller: expandableController,
        header: SettingsIconItem(
          margin: EdgeInsets.zero,
          title: AppStrings.theme.tr.capitalizeFirst!,
          subtitle: AppStrings.changeAppTheme.tr.capitalizeFirst!,
          leadingIcon: Icons.brush,
          elevation: 0,
          shapeBorder: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          trailingIcon: IconButton(
            onPressed: () {
              expandableController.toggle();
              expanded.value = expandableController.expanded;
            },
            padding: EdgeInsets.zero,
            icon: Obx(() {
              return Icon(
                expanded.value ? Icons.expand_less : Icons.expand_more,
                color: Get.textTheme.titleSmall!.color,
                size: 32.sp,
              );
            }),
          ),
        ),
        expanded: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Obx(() {
            return Column(
              children: [
                Divider(
                  indent: 16.w,
                  endIndent: 16.w,
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  shape: SharedStyle.roundedRectangleBorder(),
                  groupValue: appThemeController.currentThemeMode.value,
                  onChanged: (value) {
                    appThemeController.toggleTheme(value!);
                    // controller.toggle();
                  },
                  title: Text(
                    AppStrings.lightMode.tr.capitalizeFirst!,
                    style: Get.textTheme.bodyMedium,
                  ),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  shape: SharedStyle.roundedRectangleBorder(),
                  groupValue: appThemeController.currentThemeMode.value,
                  onChanged: (value) {
                    appThemeController.toggleTheme(value!);
                  },
                  title: Text(
                    AppStrings.darkMode.tr.capitalizeFirst!,
                    style: Get.textTheme.bodyMedium,
                  ),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  shape: SharedStyle.roundedRectangleBorder(),
                  groupValue: appThemeController.currentThemeMode.value,
                  onChanged: (value) {
                    appThemeController.toggleTheme(value!);
                    // controller.toggle();
                  },
                  title: Text(
                    AppStrings.systemMode.tr.capitalizeFirst!,
                    style: Get.textTheme.bodyMedium,
                  ),
                ),
              ],
            );
          }),
        ),
        theme: const ExpandableThemeData(
          tapBodyToCollapse: true,
          tapHeaderToExpand: true,
          useInkWell: true,
          hasIcon: false,
        ),
      ),
    );
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_language_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/language_and_localization/languages_list.dart';
import '../my_card_design.dart';
import 'settings_icon_widget.dart';

class LanguageItem extends StatelessWidget {
  final bool initialExpanded;

  const LanguageItem({
    super.key,
    this.initialExpanded = false,
  });

  AppLanguageController get appLanguageController =>
      Get.find<AppLanguageController>();

  @override
  Widget build(BuildContext context) {
    RxBool expanded = RxBool(initialExpanded);
    final ExpandableController expandableController =
        ExpandableController(initialExpanded: initialExpanded);

    return ExpandablePanel(
      collapsed: Container(),
      controller: expandableController,
      header: SettingsIconItem(
        margin: EdgeInsets.zero,
        title: AppStrings.language.tr.capitalizeFirst!,
        subtitle: AppStrings.changeLang.tr.capitalizeFirst!,
        leadingIcon: CupertinoIcons.globe,
        elevation: 0,
        shapeBorder: const RoundedRectangleBorder(
          side: BorderSide.none,
        ),
        trailingIcon: IconButton(
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            expandableController.toggle();
            expanded.value = expandableController.expanded;
          },
          padding: EdgeInsets.zero,
          icon: Obx(() {
            return Icon(
              expanded.value ? Icons.expand_less : Icons.expand_more,
              color: Theme.of(context).textTheme.titleSmall?.color,
              size: 24.sp,
            );
          }),
        ),
      ),
      expanded: Column(
        children: [
          Divider(
            indent: 16.w,
            endIndent: 16.w,
          ),
          Obx(() {
            appLanguageController.appLocale.value;
            return AppCard(
              withAlignment: false,
              withShadow: false,
              padding:
                  EdgeInsets.only(left: 5.0.w, right: 5.0.w, bottom: 5.0.h),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: AppLanguage.appLanguageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile<String>(
                    value:
                        AppLanguage.appLanguageList[index].locale.languageCode,
                    groupValue:
                        appLanguageController.appLocale.value.languageCode,
                    onChanged: (value) {
                      appLanguageController.changeLanguage(
                        value!,
                        AppLanguage.appLanguageList[index].id,
                      );
                    },
                    title: Text(
                      AppLanguage.appLanguageList[index].name.tr,
                      style: Get.textTheme.bodyMedium,
                    ),
                    dense: true,
                  );
                },
              ),
            );
          }),
        ],
      ),
      theme:  ExpandableThemeData(
        tapBodyToCollapse: true,
        tapHeaderToExpand: true,
        useInkWell: true,
        inkWellBorderRadius: BorderRadius.circular(24),
        hasIcon: false,
      ),
    );
  }
}

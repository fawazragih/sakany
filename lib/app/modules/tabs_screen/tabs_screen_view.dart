import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../core/language_and_localization/app_strings.dart';
import 'tabs_screen_controller.dart';
import 'taps_pages_and_bottom_nav_bar_icon_list.dart';

class TabsScreenView extends GetView<TabsScreenController> {
  static const String routeName = '/app';

  const TabsScreenView({super.key});

  double get fontSize => 10.sp;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        // statusBarBrightness:
        //     Platform.isAndroid ? Brightness.dark : Brightness.light,
        // systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.transparent,
        // systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return WillPopScope(
      onWillPop: _onPop,
      child: GetBuilder<TabsScreenController>(builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex,
            children: TapsPagesAndBottomNavBarIconList.widgetList,
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: context.theme.primaryColor,
            color: context.theme.primaryColorDark,
            buttonBackgroundColor: context.theme.colorScheme.primary,
            index: controller.currentIndex,
            onTap: controller.changePageIndex,
            items: [
              CurvedNavigationBarItem(
                child: Icon(
                  CupertinoIcons.home,
                  color: context.theme.colorScheme.onPrimary,
                ),
                labelStyle: context.theme.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.onPrimary,
                  fontSize: fontSize,
                ),
                label: AppStrings.home.tr.capitalizeFirst!,
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  CupertinoIcons.collections,
                  color: context.theme.colorScheme.onPrimary,
                ),
                labelStyle: context.theme.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.onPrimary,
                  fontSize: fontSize,
                ),
                label: AppStrings.categories.tr.capitalizeFirst!,
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  CupertinoIcons.search,
                  color: context.theme.colorScheme.onPrimary,
                ),
                labelStyle: context.theme.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.onPrimary,
                  fontSize: fontSize,
                ),
                label: AppStrings.search.tr.capitalizeFirst!,
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  CupertinoIcons.person,
                  color: context.theme.colorScheme.onPrimary,
                ),
                labelStyle: context.theme.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.onPrimary,
                  fontSize: fontSize,
                ),
                label: ConstStrings.HOME_NAV_ACCOUNT.translate.capitalizeFirst!,
              ),
              CurvedNavigationBarItem(
                child: Icon(
                  CupertinoIcons.profile_circled,
                  color: context.theme.colorScheme.onPrimary,
                ),
                labelStyle: context.theme.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.onPrimary,
                  fontSize: fontSize,
                ),
                label: AppStrings.profile.tr.capitalizeFirst!,
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<bool> _onPop() {
    final controller = Get.find<TabsScreenController>();
    // if (controller.getCurrentIndex != 0) {
    //   controller.changePageIndex(0);
    //   return Future.value(false);
    // } else {
    DateTime now = DateTime.now();
    if (controller.currentBackPressTime == null ||
        now.difference(controller.currentBackPressTime!) >
            const Duration(seconds: 2)) {
      controller.currentBackPressTime = now;
      controller.toastMessage(
        AppStrings.doubleClickToExitApp.tr.capitalizeFirst!,
      );
      return Future.value(false);
    }
    return Future.value(true);
    // }
  }
}

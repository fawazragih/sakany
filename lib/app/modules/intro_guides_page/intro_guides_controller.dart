import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sakani_mobile_app/app/modules/tabs_screen/tabs_screen_view.dart';

import '../../base_controllers_and_listeners/base_controller.dart';
import '../../core/assets_helpers/app_images.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../data/local_data/setting_app_service.dart';
import 'model/intro_model.dart';

class IntroGuidesController extends BaseController {
  int pageIndex = 0;

  final GlobalKey<IntroductionScreenState> introKey =
      GlobalKey<IntroductionScreenState>();

  late List<IntroModel> introList;

  @override
  void onInit() {
    super.onInit();

    introList = [
      IntroModel(
        title: AppStrings.shortLorem.tr.capitalizeFirst!,
        body: AppStrings.longLorem.tr.capitalizeFirst!,
        imagePath: AppImages.logoPng,
      ),
      IntroModel(
        title: AppStrings.shortLorem.tr.capitalizeFirst!,
        body: AppStrings.longLorem.tr.capitalizeFirst!,
        imagePath: AppImages.logoPng,
      ),
    ];
  }

  onPageChange(int value) {
    pageIndex = value;
    update();
  }

  onGetStarted() async {
    await Get.find<AppSettingService>().toggleShowIntroPage(false);
    return Get.offNamed(TabsScreenView.routeName);
  }

  @override
  void onClose() {
    showStatusBar();
    super.onClose();
  }
}

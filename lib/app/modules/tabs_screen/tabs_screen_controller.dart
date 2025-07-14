import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base_controllers_and_listeners/base_controller.dart';
import 'taps_pages_and_bottom_nav_bar_icon_list.dart';

class TabsScreenController extends BaseController
    with GetSingleTickerProviderStateMixin {
  DateTime? currentBackPressTime;
  late Animation<double> scaleAnimation;
  late CurvedAnimation curve;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    setAnimation();
    // getAppLanding();
  }

  // getAppLanding() async {
  //   SuccessOrError result = await _repository.getAppLanding();
  //   logger.d(result.toJson);
  //   if (result.success) {
  //   } else {
  //     buildErrorSnackBar(msg: result.error.toString());
  //   }
  // }

  void setAnimation() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);
    Future.delayed(
      const Duration(seconds: 0),
      () => animationController.forward(),
    );
  }

  @override
  void onReady() async {
    super.onReady();
    if (!noInternetConnection && userAuthController.currentUser != null) {
      // await userAuthController.refreshUserProfile(
      //   onError: (msg) => buildErrorSnackBar(msg: msg),
      //   // onSuccess: (msg) => buildSuccessSnackBar(),
      // );
    }
    // CartCheckAndInitHelper.instance.startInitCartDataAndItems();
  }

  //region currentPageIndex
  int _currentPageIndex = 0;

  int get currentIndex => _currentPageIndex;

  changePageIndex(int newValue) {
    // logger.d(BottomNavBarIconList.widgetList[newValue]);

    TapsPagesAndBottomNavBarIconList.changePageAtIndex(newValue);
    // logger.d(BottomNavBarIconList.widgetList[newValue]);
    _currentPageIndex = newValue;
    update();
  }

//endregion
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

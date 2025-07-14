import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../base_controllers_and_listeners/base_controller.dart';

class PlayVideoController extends BaseController {
  late String videoUrl;

  String? get title => null;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is String) {
      videoUrl = Get.arguments;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.back();
        buildErrorSnackBar(msg: 'no arguments passed');
      });
      return;
    }
  }
}

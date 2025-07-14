import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../base_controllers_and_listeners/base_controller.dart';

class AppPhotoViewerController extends BaseController {

  TransformationController transformationController = TransformationController();

  // late ImageDetailsModel imageDetailsModel;
  List<String?>? images = [];

  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is List) {
      images = Get.arguments;
    } else {
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   Get.back();
      //   buildErrorSnackBar(msg: 'no arguments passed');
      // });
      // return;
    }

  }


  restImage() {
    transformationController.value = Matrix4.identity();
  }

  int currentPage =0 ;
  onPageChanged(int value) {
    currentPage = value;
    update();
  }
}

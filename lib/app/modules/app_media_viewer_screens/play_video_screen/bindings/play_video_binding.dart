import 'package:get/get.dart';

import '../play_video_controller.dart';

class PlayVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayVideoController());
  }
}

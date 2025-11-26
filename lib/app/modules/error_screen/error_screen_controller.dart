
import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/modules/error_screen/error_screen.dart';

class ErrorPageController extends BaseController{


  ErrorScreenArguments? screenArgument;

  @override
  void onInit() {
    super.onInit();
    // if(Get.parameters!= null)
    screenArgument = ErrorScreenArguments.fromJson(Get.parameters);
  }

}
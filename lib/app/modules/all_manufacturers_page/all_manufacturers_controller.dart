import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';

import '../../data/api_providers/base_configs/handling_dio_response.dart';
import '../../data/models/home/manufacturers_response.dart';
import '../home_page/repository/home_repository.dart';
import 'arguments/all_manufacturers_screen_args.dart';

class AllManufacturersController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;
  List<ManufacturerData> manufacturerList = [];
  AllManufacturersScreenArgs? arguments;

  @override
  void onInit() {
    super.onInit();
    arguments = AllManufacturersScreenArgs.fromJson(Get.parameters);
    fetchManufacturers();
  }

  fetchManufacturers() async {
    setBusy(true);
    SuccessOrError result = await _repository.fetchAllManufacturers();
    if (result.success) {
      manufacturerList = result.response?.data;
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }
}

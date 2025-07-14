import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/models/home/manufacturers_response.dart';
import 'package:sakani/app/modules/home_page/repository/home_repository.dart';
import '../../../../data/api_providers/base_configs/handling_dio_response.dart';

class ManufacturerSliderController extends BaseController {
  final HomeRepository _repository = HomeRepository.instance;

  List<ManufacturerData>? manufacturerData;

  @override
  void onInit() {
    super.onInit();
    fetchManufacturers();
  }

  fetchManufacturers() async {
    setBusy(true);
    if (appLandingData?.showManufacturers == true) {
      //fetch Manufacturers
      SuccessOrError result = await _repository.fetchManufacturers();
      if (result.success) {
        manufacturerData = result.response?.data;
      } else {
        buildErrorSnackBar(msg: result.error?.message);
      }
      setBusy(false);
    } else {
      // clear Manufacturers data;
      manufacturerData = null;
    }
  }
}

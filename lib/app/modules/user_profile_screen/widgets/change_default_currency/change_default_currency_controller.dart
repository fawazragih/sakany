import 'package:get/get.dart';
import 'package:tamoily/app/base_controllers_and_listeners/base_controller.dart';
import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/models/app_landing_response.dart';
import 'package:tamoily/app/data/repositories/settings_repository.dart';
import 'package:tamoily/app/modules/splash_screen/splash_screen.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';

class ChangeDefaultCurrencyController extends BaseController {
  final SettingsRepository _repository = SettingsRepository.instance;

  List<AvailableCurrencies> get currencyList =>
      appLandingData?.currencyNavSelector?.availableCurrencies ?? List.empty();

  changeDefaultCurrency(int? value) {
    currentCurrencyId = value ?? -1;
    update();
  }

  int currentCurrencyId = -1;

  @override
  void onInit() {
    super.onInit();
    currentCurrencyId =
        appLandingData?.currencyNavSelector?.currentCurrencyId ?? -1;
  }

  void confirmDefaultCurrency() async {
    btnController.start();
    SuccessOrError result = await _repository.changeCurrency(currentCurrencyId);
    hideProgressDialog();
    if (result.success) {
      btnController.stop();
      var response = result.response?.data;
      logger.d('response: $response');
      // Get.offNamedUntil(SplashPage.routeName, (r) => false);
      Get.offAllNamed(SplashPage.routeName);
    } else {
      btnController.error();
      buildErrorSnackBar(msg: result.error.toString());
      btnController.stop();
    }
  }
}

import 'dart:async';
import 'package:get/get.dart';
import 'package:sakani/app/utils/api_env_config/app_logger_config.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'no_connection_snack_bar.dart';

class ConnectivityController extends GetxService {
  final SimpleConnectionChecker _simpleConnectionChecker =
      SimpleConnectionChecker();

  StreamController<bool> connectionStatusController = StreamController<bool>();

  bool? currentConnectivityStatus;

  @override
  void onInit() {
    super.onInit();
    initializeConnectivity();
    // checkWhenStreamIsNull();
  }

  initializeConnectivity() async {
    await checkWhenStreamIsNull();
    _simpleConnectionChecker.onConnectionChange.listen((bool connected) {
      connectionStatusController.sink.add(_getStatusFromResult(connected));
    });
  }

  bool _getStatusFromResult(bool result) {
    logger.d(result);

    result
        ? NoConnectionSnackBar.instance.hideNoConnectionSnackBar()
        : NoConnectionSnackBar.instance.showNoConnectionSnackBar();
    // print('====> connectivity is $result');
    currentConnectivityStatus = result;
    return currentConnectivityStatus!;
  }

  checkWhenStreamIsNull() async {
    currentConnectivityStatus = await SimpleConnectionChecker.isConnectedToInternet();
    logger.d('currentConnectivityStatus $currentConnectivityStatus');
  }

  @override
  onClose() {
    connectionStatusController.close();
    return super.onClose();
  }
}

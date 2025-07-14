import 'package:sakani/app/base_controllers_and_listeners/base_controller.dart';
import 'package:sakani/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:sakani/app/data/models/order_history_response.dart';
import 'package:sakani/app/modules/orders_pages/repository/order_repository.dart';

class OrderHistoryController extends BaseController {
  final OrderRepository _repository = OrderRepository();

  OrderHistoryData? orderHistoryData;

  List<Order> orders = [];

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  fetchOrderHistory() async {
    // orderHistorySink.add(ApiResponse.loading());
    //
    // try {
    //   OrderHistoryResponse response = await _repository.fetchOrderHistory();
    //   orderHistorySink.add(ApiResponse.completed(response));
    // } catch (e) {
    //   orderHistorySink.add(ApiResponse.error(e.toString()));
    //   print(e);
    // }
    setBusy(true);
    SuccessOrError result = await _repository.fetchOrderHistory();
    if (result.success) {
      orderHistoryData = result.response?.data;
      orders = orderHistoryData?.orders ?? [];
      setBusy(false);
    } else {
      setShowRetryButton(true);
      buildErrorSnackBar(msg: result.error.toString());
    }
  }
}

import 'package:tamoily/app/data/api_providers/base_configs/handling_dio_response.dart';
import 'package:tamoily/app/data/api_providers/orders_api.dart';

class OrderRepository {
  final OrdersApi _ordersApi = OrdersApi();

  Future<SuccessOrError> fetchOrderHistory() => _ordersApi.fetchOrderHistory();

  Future<SuccessOrError> fetchOrderDetails(int orderId) =>
      _ordersApi.fetchOrderDetails(orderId);

  Future<SuccessOrError> reorder(int orderId) => _ordersApi.reorder(orderId);

  Future<SuccessOrError> repostPayment(int orderId) =>
      _ordersApi.repostPayment(orderId);

  Future<SuccessOrError> downloadPdfInvoice(int orderId) =>
      _ordersApi.downloadPdfInvoice(orderId);

  Future<SuccessOrError> downloadNotesAttachment(int noteId) =>
      _ordersApi.downloadNotesAttachment(noteId);
}

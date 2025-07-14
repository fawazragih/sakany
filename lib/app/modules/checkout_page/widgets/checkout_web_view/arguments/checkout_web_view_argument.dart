import 'package:app_extensions/app_extensions.dart';

class CheckoutWebViewArgument {
  int? action;
  String? screenTitle;
  int? orderId;

  CheckoutWebViewArgument({
    this.action,
    required this.screenTitle,
    this.orderId,
  });

  Map<String, String> toJson() {
    return {
      'action': action?.toString() ?? '',
      'screenTitle': screenTitle ?? '',
      'orderId': orderId?.toString() ?? '',
    }..removeWhere((key, value) => value.isNullOrEmpty);
  }

  factory CheckoutWebViewArgument.fromJson(Map<String, dynamic> map) {
    return CheckoutWebViewArgument(
      action: int.tryParse(map['action'].toString()),
      screenTitle: map['screenTitle'],
      orderId: int.tryParse(map['orderId'].toString()),
    );
  }
}

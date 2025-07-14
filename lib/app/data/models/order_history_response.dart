
import 'custom_properties.dart';

class OrderHistoryResponse {
  OrderHistoryResponse({
    this.data,
    this.message,
    this.errorList,
  });

  OrderHistoryData? data;
  String? message;
  List<String>? errorList;

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) => OrderHistoryResponse(
    data: json["Data"] == null ? null : OrderHistoryData.fromJson(json["Data"]),
    message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<String>.from(json["ErrorList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class OrderHistoryData {
  OrderHistoryData({
    this.orders,
    this.recurringOrders,
    this.recurringPaymentErrors,
    this.customProperties,
  });

  List<Order>? orders;
  List<dynamic>? recurringOrders;
  List<dynamic>? recurringPaymentErrors;
  CustomProperties? customProperties;

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) => OrderHistoryData(
        orders: json["Orders"] == null
            ? null
            : List<Order>.from(json["Orders"]!.map((x) => Order.fromJson(x))),
        recurringOrders: json["RecurringOrders"] == null
            ? null
            : List<dynamic>.from(json["RecurringOrders"]!.map((x) => x)),
        recurringPaymentErrors: json["RecurringPaymentErrors"] == null
            ? null
            : List<dynamic>.from(json["RecurringPaymentErrors"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Orders": orders == null
            ? null
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
        "RecurringOrders": recurringOrders == null
            ? null
            : List<dynamic>.from(recurringOrders!.map((x) => x)),
        "RecurringPaymentErrors": recurringPaymentErrors == null
            ? null
            : List<dynamic>.from(recurringPaymentErrors!.map((x) => x)),
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class Order {
  Order({
    this.customOrderNumber,
    this.orderTotal,
    this.isReturnRequestAllowed,
    this.orderStatusEnum,
    this.orderStatus,
    this.paymentStatus,
    this.shippingStatus,
    this.createdOn,
    this.id,
    this.customProperties,
  });

  String? customOrderNumber;
  String? orderTotal;
  bool? isReturnRequestAllowed;
  int? orderStatusEnum;
  String? orderStatus;
  String? paymentStatus;
  String? shippingStatus;
  DateTime? createdOn;
  int? id;
  CustomProperties? customProperties;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    customOrderNumber: json["CustomOrderNumber"],
    orderTotal: json["OrderTotal"],
    isReturnRequestAllowed: json["IsReturnRequestAllowed"],
    orderStatusEnum: json["OrderStatusEnum"],
    orderStatus: json["OrderStatus"],
    paymentStatus: json["PaymentStatus"],
    shippingStatus: json["ShippingStatus"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    id: json["Id"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "CustomOrderNumber": customOrderNumber,
    "OrderTotal": orderTotal,
    "IsReturnRequestAllowed": isReturnRequestAllowed,
    "OrderStatusEnum": orderStatusEnum,
    "OrderStatus": orderStatus,
    "PaymentStatus": paymentStatus,
    "ShippingStatus": shippingStatus,
        "CreatedOn": createdOn?.toIso8601String(),
        "Id": id,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

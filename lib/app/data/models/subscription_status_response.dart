
import 'custom_properties.dart';

// class SubscriptionStatusResponse {
//   SubscriptionStatusResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   SubscriptionStatusResponseData? data;
//   String? message;
//   List<String>? errorList;
//
//   factory SubscriptionStatusResponse.fromJson(Map<String, dynamic> json) => SubscriptionStatusResponse(
//     data: json["Data"] == null ? null : SubscriptionStatusResponseData.fromJson(json["Data"]),
//     message: json["Message"],
//     errorList: json["ErrorList"] == null ? null : List<String>.from(json["ErrorList"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//         "Data": data?.toJson(),
//         "Message": message,
//         "ErrorList": errorList == null
//             ? null
//             : List<dynamic>.from(errorList!.map((x) => x)),
//       };
// }

class SubscriptionStatusResponseData {
  SubscriptionStatusResponseData({
    this.productId,
    this.productName,
    this.productSeName,
    this.isCurrentCustomerRegistered,
    this.subscriptionAllowed,
    this.alreadySubscribed,
    this.maximumBackInStockSubscriptions,
    this.currentNumberOfBackInStockSubscriptions,
    this.customProperties,
  });

  int? productId;
  String? productName;
  String? productSeName;
  bool? isCurrentCustomerRegistered;
  bool? subscriptionAllowed;
  bool? alreadySubscribed;
  int? maximumBackInStockSubscriptions;
  int? currentNumberOfBackInStockSubscriptions;
  CustomProperties? customProperties;

  factory SubscriptionStatusResponseData.fromJson(Map<String, dynamic> json) => SubscriptionStatusResponseData(
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    isCurrentCustomerRegistered: json["IsCurrentCustomerRegistered"],
    subscriptionAllowed: json["SubscriptionAllowed"],
    alreadySubscribed: json["AlreadySubscribed"],
    maximumBackInStockSubscriptions: json["MaximumBackInStockSubscriptions"],
    currentNumberOfBackInStockSubscriptions: json["CurrentNumberOfBackInStockSubscriptions"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "IsCurrentCustomerRegistered": isCurrentCustomerRegistered,
    "SubscriptionAllowed": subscriptionAllowed,
    "AlreadySubscribed": alreadySubscribed,
    "MaximumBackInStockSubscriptions": maximumBackInStockSubscriptions,
    "CurrentNumberOfBackInStockSubscriptions": currentNumberOfBackInStockSubscriptions,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

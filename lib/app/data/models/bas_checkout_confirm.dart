
import 'custom_properties.dart';

class BasCheckoutConfirm {
  BasCheckoutConfirmData? data;
  String? message;
  List<String>? errorList;

  BasCheckoutConfirm({
    this.data,
    this.message,
    this.errorList,
  });

  factory BasCheckoutConfirm.fromJson(Map<String, dynamic> json) {
    // {OrderId: 9, CustomOrderNumber: db5e9afc-3d8c-4e8a-a31f-3955dcbed8e9, OnePageCheckoutEnabled: false, CustomProperties: {}}

    if( json["Data"] == null && json['CustomOrderNumber']!= null ){
      json['Data'] = BasCheckoutConfirmData.fromJson(json).toJson();
    }

    return BasCheckoutConfirm(
    data: json["Data"] == null ? null : BasCheckoutConfirmData.fromJson(json["Data"]),
    message: json["Message"],
    errorList: json["ErrorList"] == null ? [] : List<String>.from(json["ErrorList"]!.map((x) => x)),
  );
  }

  Map<String, dynamic> toJson() => {
    "Data": data?.toJson(),
    "Message": message,
    "ErrorList": errorList == null ? [] : List<dynamic>.from(errorList!.map((x) => x)),
  };
}

class BasCheckoutConfirmData {
  int? orderId;
  String? customOrderNumber;
  bool? onePageCheckoutEnabled;
  CustomProperties? customProperties;

  BasCheckoutConfirmData({
    this.orderId,
    this.customOrderNumber,
    this.onePageCheckoutEnabled,
    this.customProperties,
  });

  factory BasCheckoutConfirmData.fromJson(Map<String, dynamic> json) => BasCheckoutConfirmData(
    orderId: json["OrderId"],
    customOrderNumber: json["CustomOrderNumber"]?.toString(),
    onePageCheckoutEnabled: json["OnePageCheckoutEnabled"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "OrderId": orderId,
    "CustomOrderNumber": customOrderNumber,
    "OnePageCheckoutEnabled": onePageCheckoutEnabled,
    "CustomProperties": customProperties?.toJson(),
  };
}

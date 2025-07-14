import 'custom_properties.dart';

// class EstimateShippingResponse {
//   EstimateShippingResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   EstimateShippingData? data;
//   String? message;
//   List<String>? errorList;
//
//   factory EstimateShippingResponse.fromJson(Map<String, dynamic> json) => EstimateShippingResponse(
//     data: json["Data"] == null ? null : EstimateShippingData.fromJson(json["Data"]),
//     message: json["Message"],
//         errorList: json["ErrorList"] == null
//             ? null
//             : List<String>.from(json["ErrorList"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Data": data?.toJson(),
//         "Message": message,
//         "ErrorList": errorList == null
//             ? null
//             : List<dynamic>.from(errorList!.map((x) => x)),
//       };
// }

class EstimateShippingData {
  EstimateShippingData({
    this.shippingOptions,
    this.success,
    this.errors,
    this.customProperties,
  });

  List<ShippingOption>? shippingOptions;
  bool? success;
  List<dynamic>? errors;
  CustomProperties? customProperties;

  factory EstimateShippingData.fromJson(Map<String, dynamic> json) => EstimateShippingData(
        shippingOptions: json["ShippingOptions"] == null
            ? null
            : List<ShippingOption>.from(json["ShippingOptions"]!
                .map((x) => ShippingOption.fromJson(x))),
        success: json["Success"],
        errors: json["Errors"] == null
            ? null
            : List<dynamic>.from(json["Errors"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
        "ShippingOptions": shippingOptions == null
            ? null
            : List<dynamic>.from(shippingOptions!.map((x) => x.toJson())),
        "Success": success,
        "Errors":
            errors == null ? null : List<dynamic>.from(errors!.map((x) => x)),
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class ShippingOption {
  ShippingOption({
    this.deliveryDateFormat,
    this.description,
    this.name,
    this.price,
    this.rate,
    this.selected,
    this.shippingRateComputationMethodSystemName,
  });

  dynamic deliveryDateFormat;
  String? description;
  String? name;
  String? price;
  num? rate;
  bool? selected;
  String? shippingRateComputationMethodSystemName;

  factory ShippingOption.fromJson(Map<String, dynamic> json) => ShippingOption(
    deliveryDateFormat: json["DeliveryDateFormat"],
    description: json["Description"],
    name: json["Name"],
    price: json["Price"],
    rate: json["Rate"],
    selected: json["Selected"],
    shippingRateComputationMethodSystemName: json["ShippingRateComputationMethodSystemName"],
  );

  Map<String, dynamic> toJson() => {
    "DeliveryDateFormat": deliveryDateFormat,
    "Description": description,
    "Name": name,
    "Price": price,
    "Rate": rate,
    "Selected": selected,
    "ShippingRateComputationMethodSystemName": shippingRateComputationMethodSystemName,
  };
}

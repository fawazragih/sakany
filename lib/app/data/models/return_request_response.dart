
import 'custom_properties.dart';

class ReturnRequestResponse {
  ReturnRequestResponse({
    this.data,
    this.message,
    this.errorList,
  });

  ReturnRequestData? data;
  String? message;
  List<String>? errorList;

  factory ReturnRequestResponse.fromJson(Map<String, dynamic> json) => ReturnRequestResponse(
    data: json["Data"] == null ? null : ReturnRequestData.fromJson(json["Data"]),
    message: json["Message"],
    errorList: json["ErrorList"] == null ? null : List<String>.from(json["ErrorList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class ReturnRequestData {
  ReturnRequestData({
    this.orderId,
    this.customOrderNumber,
    this.items,
    this.returnRequestReasonId,
    this.availableReturnReasons,
    this.returnRequestActionId,
    this.availableReturnActions,
    this.comments,
    this.allowFiles,
    this.uploadedFileGuid,
    this.result,
    this.customProperties,
  });

  int? orderId;
  String? customOrderNumber;
  List<ReturnRequestProduct>? items;
  int? returnRequestReasonId;
  List<AvailableReturn>? availableReturnReasons;
  int? returnRequestActionId;
  List<AvailableReturn>? availableReturnActions;
  String? comments;
  bool? allowFiles;
  String? uploadedFileGuid;
  String? result;
  CustomProperties? customProperties;

  factory ReturnRequestData.fromJson(Map<String, dynamic> json) => ReturnRequestData(
    orderId: json["OrderId"],
    customOrderNumber: json["CustomOrderNumber"],
    items: json["Items"] == null ? null : List<ReturnRequestProduct>.from(json["Items"]!.map((x) => ReturnRequestProduct.fromJson(x))),
    returnRequestReasonId: json["ReturnRequestReasonId"],
    availableReturnReasons: json["AvailableReturnReasons"] == null ? null : List<AvailableReturn>.from(json["AvailableReturnReasons"]!.map((x) => AvailableReturn.fromJson(x))),
    returnRequestActionId: json["ReturnRequestActionId"],
    availableReturnActions: json["AvailableReturnActions"] == null ? null : List<AvailableReturn>.from(json["AvailableReturnActions"]!.map((x) => AvailableReturn.fromJson(x))),
    comments: json["Comments"],
    allowFiles: json["AllowFiles"],
    uploadedFileGuid: json["UploadedFileGuid"],
    result: json["Result"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "OrderId": orderId,
    "CustomOrderNumber": customOrderNumber,
        "Items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "ReturnRequestReasonId": returnRequestReasonId,
        "AvailableReturnReasons": availableReturnReasons == null
            ? null
            : List<dynamic>.from(
                availableReturnReasons!.map((x) => x.toJson())),
        "ReturnRequestActionId": returnRequestActionId,
        "AvailableReturnActions": availableReturnActions == null
            ? null
            : List<dynamic>.from(
                availableReturnActions!.map((x) => x.toJson())),
        "Comments": comments,
    "AllowFiles": allowFiles,
    "UploadedFileGuid": uploadedFileGuid,
    "Result": result,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class AvailableReturn {
  AvailableReturn({
    this.name,
    this.id,
    this.customProperties,
  });

  String? name;
  int? id;
  CustomProperties? customProperties;

  factory AvailableReturn.fromJson(Map<String, dynamic> json) => AvailableReturn(
    name: json["Name"],
    id: json["Id"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Id": id,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

class ReturnRequestProduct {
  ReturnRequestProduct({
    this.productId,
    this.productName,
    this.productSeName,
    this.attributeInfo,
    this.unitPrice,
    this.quantity,
    this.id,
    this.customProperties,
  });

  int? productId;
  String? productName;
  String? productSeName;
  String? attributeInfo;
  String? unitPrice;
  int? quantity;
  int? id;
  CustomProperties? customProperties;

  factory ReturnRequestProduct.fromJson(Map<String, dynamic> json) => ReturnRequestProduct(
    productId: json["ProductId"],
    productName: json["ProductName"],
    productSeName: json["ProductSeName"],
    attributeInfo: json["AttributeInfo"],
    unitPrice: json["UnitPrice"],
    quantity: json["Quantity"],
    id: json["Id"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "ProductSeName": productSeName,
    "AttributeInfo": attributeInfo,
    "UnitPrice": unitPrice,
    "Quantity": quantity,
    "Id": id,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

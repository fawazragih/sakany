import 'custom_properties.dart';

class ReturnReqHistoryResponse {
  ReturnReqHistoryResponse({
    this.data,
    this.message,
    this.errorList,
  });

  ReturnReqHistoryData? data;
  String? message;
  List<String>? errorList;

  factory ReturnReqHistoryResponse.fromJson(Map<String, dynamic> json) =>
      ReturnReqHistoryResponse(
        data: json["Data"] == null
            ? null
            : ReturnReqHistoryData.fromJson(json["Data"]),
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

class ReturnReqHistoryData {
  ReturnReqHistoryData({
    this.items,
    this.customProperties,
  });

  List<ReturnReqHistoryItem>? items;
  CustomProperties? customProperties;

  factory ReturnReqHistoryData.fromJson(Map<String, dynamic> json) =>
      ReturnReqHistoryData(
        items: json["Items"] == null
            ? null
            : List<ReturnReqHistoryItem>.from(
                json["Items"]!.map((x) => ReturnReqHistoryItem.fromJson(x))),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "CustomProperties": customProperties?.toJson(),
      };
}

class ReturnReqHistoryItem {
  ReturnReqHistoryItem({
    this.customNumber,
    this.returnRequestStatus,
    this.productId,
    this.productName,
    this.productSeName,
    this.quantity,
    this.returnReason,
    this.returnAction,
    this.comments,
    this.uploadedFileGuid,
    this.createdOn,
    this.id,
    this.customProperties,
  });

  String? customNumber;
  String? returnRequestStatus;
  int? productId;
  String? productName;
  String? productSeName;
  int? quantity;
  String? returnReason;
  String? returnAction;
  String? comments;
  String? uploadedFileGuid;
  DateTime? createdOn;
  int? id;
  CustomProperties? customProperties;

  factory ReturnReqHistoryItem.fromJson(Map<String, dynamic> json) =>
      ReturnReqHistoryItem(
        customNumber: json["CustomNumber"],
        returnRequestStatus: json["ReturnRequestStatus"],
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        quantity: json["Quantity"],
        returnReason: json["ReturnReason"],
        returnAction: json["ReturnAction"],
        comments: json["Comments"],
        uploadedFileGuid: json["UploadedFileGuid"],
        createdOn: json["CreatedOn"] == null
            ? null
            : DateTime.parse(json["CreatedOn"]),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "CustomNumber": customNumber,
        "ReturnRequestStatus": returnRequestStatus,
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "Quantity": quantity,
        "ReturnReason": returnReason,
        "ReturnAction": returnAction,
        "Comments": comments,
        "UploadedFileGuid": uploadedFileGuid,
        "CreatedOn": createdOn?.toIso8601String(),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };

  factory ReturnReqHistoryItem.fakeData() {
    return ReturnReqHistoryItem(
      customNumber: "123456789",
      returnRequestStatus: "Pending",
      productId: 1,
      productName: "Product Name",
      productSeName: "Product Se Name",
      quantity: 1,
      returnReason: "Wrong Product",
      returnAction: "Return",
      comments: "No comments",
      uploadedFileGuid: "123456789",
      createdOn: DateTime.now(),
      id: 1,
      customProperties: CustomProperties(
        customerBASAuthCode: "123456789",
        orderPaymentInfoTempKey: "123456789",
      ),
    );
  }
}

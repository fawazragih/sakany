class BasCheckoutStatus {
  BasCheckoutStatusData? data;
  String? message;
  List<dynamic>? errorList;

  BasCheckoutStatus({
    this.data,
    this.message,
    this.errorList,
  });

  factory BasCheckoutStatus.fromJson(Map<String, dynamic> json) =>
      BasCheckoutStatus(
        data: json["Data"] == null
            ? null
            : BasCheckoutStatusData.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? []
            : List<dynamic>.from(json["ErrorList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? []
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class BasCheckoutStatusData {
  Head? head;
  Body? body;
  int? status;
  String? code;
  List<String>? messages;
  Order? confirmData;

  BasCheckoutStatusData({
    this.head,
    this.body,
    this.status,
    this.code,
    this.messages,
    this.confirmData,
  });

  factory BasCheckoutStatusData.fromJson(Map<String, dynamic> json) =>
      BasCheckoutStatusData(
        head: json["Head"] == null ? null : Head.fromJson(json["Head"]),
        body: json["Body"] == null ? null : Body.fromJson(json["Body"]),
        status: json["status"],
        code: json["code"],
        messages: json["messages"] == null
            ? []
            : List<String>.from(json["messages"]!.map((x) => x)),
        confirmData: json["ConfirmData"] == null
            ? null
            : Order.fromJson(json["ConfirmData"]),
      );

  Map<String, dynamic> toJson() => {
        "Head": head?.toJson(),
        "Body": body?.toJson(),
        "status": status,
        "code": code,
        "messages":
            messages == null ? [] : List<dynamic>.from(messages!.map((x) => x)),
        "ConfirmData": confirmData?.toJson(),
      };
}

class Body {
  int? trxStatusId;
  String? trxStatus;
  String? trxToken;
  int? timestamp;
  Order? order;
  dynamic description;
  dynamic callBackUrl;

  Body({
    this.trxStatusId,
    this.trxStatus,
    this.trxToken,
    this.timestamp,
    this.order,
    this.description,
    this.callBackUrl,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        trxStatusId: json["trxStatusId"],
        trxStatus: json["trxStatus"],
        trxToken: json["trxToken"],
        timestamp: json["timestamp"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        description: json["description"],
        callBackUrl: json["callBackUrl"],
      );

  Map<String, dynamic> toJson() => {
        "trxStatusId": trxStatusId,
        "trxStatus": trxStatus,
        "trxToken": trxToken,
        "timestamp": timestamp,
        "order": order?.toJson(),
        "description": description,
        "callBackUrl": callBackUrl,
      };
}

class Order {
  String? appId;
  int? originalOrderId;
  String? orderId;
  String? transactionToken;
  Amount? amount;

  Order({
    this.appId,
    this.orderId,
    this.originalOrderId,
    this.amount,
    this.transactionToken,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        appId: json["appId"],
        orderId: json["orderId"],
        originalOrderId: json["originalOrderId"] ?? json["OriginalOrderId"],
        transactionToken: json["transactionToken"],
        amount: json["amount"] == null ? null : Amount.fromJson(json["amount"]),
      );

  Map<String, dynamic> toJson() => {
        "appId": appId,
        "orderId": orderId,
        "OriginalOrderId": originalOrderId,
        "transactionToken": transactionToken,
        "amount": amount?.toJson(),
      };
}

class Amount {
  double? value;
  String? currency;

  Amount({
    this.value,
    this.currency,
  });

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        value: double.tryParse(json["value"]?.toString() ?? ''),
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "currency": currency,
      };
}

class Head {
  String? signature;
  String? requestTimestamp;

  Head({
    this.signature,
    this.requestTimestamp,
  });

  factory Head.fromJson(Map<String, dynamic> json) => Head(
        signature: json["signature"],
        requestTimestamp: json["requestTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "signature": signature,
        "requestTimestamp": requestTimestamp,
      };
}

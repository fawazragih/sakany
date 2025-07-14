import '../save_billing_response.dart';

class OrderSummaryResponse {
  OrderSummaryResponse({
    this.data,
    this.message,
    this.errorList,
  });

  ConfirmModel? data;
  String? message;
  List<String>?  errorList;

  factory OrderSummaryResponse.fromJson(Map<String, dynamic> json) => OrderSummaryResponse(
    data: json["Data"] == null ? null : ConfirmModel.fromJson(json["Data"]),
    message: json["Message"],
    errorList: json["ErrorList"] == null ? null : List<String>.from(json["ErrorList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Data": data?.toJson(),
    "Message": message,
    "ErrorList": errorList == null ? null : List<dynamic>.from(errorList!.map((x) => x)),
  };
}
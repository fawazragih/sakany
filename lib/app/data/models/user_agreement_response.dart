class UserAgreementResponse {
  UserAgreementResponse({
    this.data,
    this.message,
    this.errorList,
  });

  UserAgreementData? data;
  String? message;
  List<String>? errorList;

  factory UserAgreementResponse.fromJson(Map<String, dynamic> json) => UserAgreementResponse(
    data: json["Data"] == null ? null : UserAgreementData.fromJson(json["Data"]),
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

class UserAgreementData {
  UserAgreementData({
    this.orderItemGuid,
    this.userAgreementText,
  });

  String? orderItemGuid;
  String? userAgreementText;

  factory UserAgreementData.fromJson(Map<String, dynamic> json) => UserAgreementData(
    orderItemGuid: json["OrderItemGuid"],
    userAgreementText: json["UserAgreementText"],
  );

  Map<String, dynamic> toJson() => {
    "OrderItemGuid": orderItemGuid,
    "UserAgreementText": userAgreementText,
  };
}

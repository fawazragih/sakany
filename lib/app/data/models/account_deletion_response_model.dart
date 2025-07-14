
class AccountDeletionResponseModel {
  AccountDeletionResponseModel({
    this.message,
    this.errorList,
  });

  String?message;
  List<String>?  errorList;

  factory AccountDeletionResponseModel.fromJson(Map<String, dynamic> json) => AccountDeletionResponseModel(
    message: json["Message"],
    errorList: json["ErrorList"] == null ? null : List<String>.from(json["ErrorList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "ErrorList": errorList == null ? null : List<dynamic>.from(errorList!.map((x) => x)),
  };
}

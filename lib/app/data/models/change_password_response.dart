
import 'custom_properties.dart';

class ChangePasswordResponse {
  ChangePasswordResponse({
    this.data,
    this.message,
    this.errorList,
  });

  ChangePasswordData? data;
  String? message;
  List<String>? errorList;

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => ChangePasswordResponse(
    data: json["Data"] == null ? null : ChangePasswordData.fromJson(json["Data"]),
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

class ChangePasswordData {
  ChangePasswordData({
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
    this.customProperties,
  });

  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;
  CustomProperties? customProperties;

  factory ChangePasswordData.fromJson(Map<String, dynamic> json) => ChangePasswordData(
    oldPassword: json["OldPassword"],
    newPassword: json["NewPassword"],
    confirmNewPassword: json["ConfirmNewPassword"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "OldPassword": oldPassword,
    "NewPassword": newPassword,
    "ConfirmNewPassword": confirmNewPassword,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

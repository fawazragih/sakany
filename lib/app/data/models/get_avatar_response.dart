
import 'custom_properties.dart';

// class GetAvatarResponse {
//   GetAvatarResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   GetAvatarData? data;
//   String? message;
//   List<String>?  errorList;
//
//   factory GetAvatarResponse.fromJson(Map<String, dynamic> json) => GetAvatarResponse(
//     data: json["Data"] == null ? null : GetAvatarData.fromJson(json["Data"]),
//     message: json["Message"],
//     errorList: json["ErrorList"] == null ? null : List<String>.from(json["ErrorList"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Data": data?.toJson(),
//     "Message": message,
//     "ErrorList": errorList == null ? null : List<dynamic>.from(errorList!.map((x) => x)),
//   };
// }

class GetAvatarData {
  GetAvatarData({
    this.avatarUrl,
    this.customProperties,
  });

  String? avatarUrl;
  CustomProperties?  customProperties;

  factory GetAvatarData.fromJson(Map<String, dynamic> json) => GetAvatarData(
    avatarUrl: json["AvatarUrl"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "AvatarUrl": avatarUrl,
    "CustomProperties": customProperties?.toJson(),
  };
}

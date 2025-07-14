
// class BasSettingsResponse {
//     BasSettingsData? data;
//     String? message;
//     List<dynamic>? errorList;
//
//     BasSettingsResponse({
//         this.data,
//         this.message,
//         this.errorList,
//     });
//
//     factory BasSettingsResponse.fromJson(Map<String, dynamic> json) => BasSettingsResponse(
//         data: json["Data"] == null ? null : BasSettingsData.fromJson(json["Data"]),
//         message: json["Message"],
//         errorList: json["ErrorList"] == null ? [] : List<dynamic>.from(json["ErrorList"]!.map((x) => x)),
//     );
//
//     Map<String, dynamic> toJson() => {
//         "Data": data?.toJson(),
//         "Message": message,
//         "ErrorList": errorList == null ? [] : List<dynamic>.from(errorList!.map((x) => x)),
//     };
// }

class BasSettingsData {
    String? clientId;
    String? appId;

    BasSettingsData({
        this.clientId,
        this.appId,
    });

    factory BasSettingsData.fromJson(Map<String, dynamic> json) => BasSettingsData(
        clientId: json["ClientId"],
        appId: json["AppId"],
    );

    Map<String, dynamic> toJson() => {
        "ClientId": clientId,
        "AppId": appId,
    };
}

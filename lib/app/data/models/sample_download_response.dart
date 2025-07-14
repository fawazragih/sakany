class SampleDownloadResponse {
  SampleDownloadResponse({
    this.data,
    this.message,
    this.errorList,
  });

  SampleDownloadData? data;
  String? message;
  List<String>? errorList;

  factory SampleDownloadResponse.fromJson(Map<String, dynamic> json) => SampleDownloadResponse(
    data: json["Data"] == null ? null : SampleDownloadData.fromJson(json["Data"]),
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

class SampleDownloadData {
  SampleDownloadData({
    this.hasUserAgreement,
    this.orderItemId,
    this.redirect,
    this.downloadUrl,
  });

  bool? hasUserAgreement;
  String? orderItemId;
  bool? redirect;
  String? downloadUrl;

  factory SampleDownloadData.fromJson(Map<String, dynamic> json) => SampleDownloadData(
    hasUserAgreement: json["HasUserAgreement"],
    orderItemId: json["OrderItemId"],
    redirect: json["Redirect"],
    downloadUrl: json["DownloadUrl"],
  );

  Map<String, dynamic> toJson() => {
    "HasUserAgreement": hasUserAgreement,
    "OrderItemId": orderItemId,
    "Redirect": redirect,
    "DownloadUrl": downloadUrl,
  };
}

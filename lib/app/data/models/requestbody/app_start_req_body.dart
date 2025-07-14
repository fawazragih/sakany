class AppStartReqBody {
  AppStartReqBody({
    this.data,
  });

  AppStartData? data;

  factory AppStartReqBody.fromJson(Map<String, dynamic> json) => AppStartReqBody(
    data: json["Data"] == null ? null : AppStartData.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Data": data?.toJson(),
  };
}

class AppStartData {
  AppStartData({
    this.deviceTypeId,
    this.subscriptionId,
  });

  int? deviceTypeId;
  String? subscriptionId;

  factory AppStartData.fromJson(Map<String, dynamic> json) => AppStartData(
    deviceTypeId: json["DeviceTypeId"],
    subscriptionId: json["SubscriptionId"],
  );

  Map<String, dynamic> toJson() => {
    "DeviceTypeId": deviceTypeId,
    "SubscriptionId": subscriptionId,
  };
}

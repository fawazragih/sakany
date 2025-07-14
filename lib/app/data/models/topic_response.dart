class TopicResponse {
  TopicResponse({
    this.data,
    this.message,
    this.errorList,
  });

  TopicData? data;
  String? message;
  List<String>? errorList;

  factory TopicResponse.fromJson(Map<String, dynamic> json) => TopicResponse(
    data: json["Data"] == null ? null : TopicData.fromJson(json["Data"]),
    message: json["Message"],
    errorList: json["ErrorList"] == null ? null : List<String>.from(json["ErrorList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
    "ErrorList": errorList == null ? null : List<dynamic>.from(errorList!.map((x) => x)),
  };
}

class TopicData {
  TopicData({
    this.systemName,
    this.includeInSitemap,
    this.isPasswordProtected,
    this.title,
    this.body,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.topicTemplateId,
    this.id,
  });

  String? systemName;
  bool? includeInSitemap;
  bool? isPasswordProtected;
  String? title;
  String? body;
  String? metaKeywords;
  String? metaDescription;
  String? metaTitle;
  String? seName;
  int? topicTemplateId;
  int? id;

  factory TopicData.fromJson(Map<String, dynamic> json) => TopicData(
    systemName: json["SystemName"],
    includeInSitemap: json["IncludeInSitemap"],
    isPasswordProtected: json["IsPasswordProtected"],
    title: json["Title"],
    body: json["Body"],
    metaKeywords: json["MetaKeywords"],
    metaDescription: json["MetaDescription"],
    metaTitle: json["MetaTitle"],
    seName: json["SeName"],
    topicTemplateId: json["TopicTemplateId"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "SystemName": systemName,
    "IncludeInSitemap": includeInSitemap,
    "IsPasswordProtected": isPasswordProtected,
    "Title": title,
    "Body": body,
    "MetaKeywords": metaKeywords,
    "MetaDescription": metaDescription,
    "MetaTitle": metaTitle,
    "SeName": seName,
    "TopicTemplateId": topicTemplateId,
    "Id": id,
  };
}

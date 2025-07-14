import 'custom_properties.dart';

class SubscriptionListResponse {
  SubscriptionListResponse({
    this.data,
    this.message,
    this.errorList,
  });

  SubscriptionListData? data;
  String? message;
  List<String>? errorList;

  factory SubscriptionListResponse.fromJson(Map<String, dynamic> json) => SubscriptionListResponse(
    data: json["Data"] == null ? null : SubscriptionListData.fromJson(json["Data"]),
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

class SubscriptionListData {
  SubscriptionListData({
    this.subscriptions,
    this.pagerModel,
    this.customProperties,
  });

  List<Subscription>? subscriptions;
  PagerModel? pagerModel;
  CustomProperties? customProperties;

  factory SubscriptionListData.fromJson(Map<String, dynamic> json) => SubscriptionListData(
        subscriptions: json["Subscriptions"] == null
            ? null
            : List<Subscription>.from(
                json["Subscriptions"]!.map((x) => Subscription.fromJson(x))),
        pagerModel: json["PagerModel"] == null ? null : PagerModel.fromJson(json["PagerModel"]),
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  get hasMorePages {
    return (pagerModel?.totalPages ?? 0) >= (pagerModel?.currentPage ?? 0);
  }
  Map<String, dynamic> toJson() => {
        "Subscriptions": subscriptions == null
            ? null
            : List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
        "PagerModel": pagerModel?.toJson(),
        "CustomProperties":
            customProperties?.toJson(),
      };
}



class PagerModel {
  PagerModel({
    this.currentPage,
    this.individualPagesDisplayedCount,
    this.pageIndex,
    this.pageSize,
    this.showFirst,
    this.showIndividualPages,
    this.showLast,
    this.showNext,
    this.showPagerItems,
    this.showPrevious,
    this.showTotalSummary,
    this.totalPages,
    this.totalRecords,
    this.routeActionName,
    this.useRouteLinks,
    this.routeValues,
  });

  int? currentPage;
  int? individualPagesDisplayedCount;
  int? pageIndex;
  int? pageSize;
  bool? showFirst;
  bool? showIndividualPages;
  bool? showLast;
  bool? showNext;
  bool? showPagerItems;
  bool? showPrevious;
  bool? showTotalSummary;
  int? totalPages;
  int? totalRecords;
  String? routeActionName;
  bool? useRouteLinks;
  RouteValues? routeValues;

  factory PagerModel.fromJson(Map<String, dynamic> json) => PagerModel(
    currentPage: json["CurrentPage"],
    individualPagesDisplayedCount: json["IndividualPagesDisplayedCount"],
    pageIndex: json["PageIndex"],
    pageSize: json["PageSize"],
    showFirst: json["ShowFirst"],
    showIndividualPages: json["ShowIndividualPages"],
    showLast: json["ShowLast"],
    showNext: json["ShowNext"],
    showPagerItems: json["ShowPagerItems"],
    showPrevious: json["ShowPrevious"],
    showTotalSummary: json["ShowTotalSummary"],
    totalPages: json["TotalPages"],
    totalRecords: json["TotalRecords"],
    routeActionName: json["RouteActionName"],
    useRouteLinks: json["UseRouteLinks"],
    routeValues: json["RouteValues"] == null ? null : RouteValues.fromJson(json["RouteValues"]),
  );

  Map<String, dynamic> toJson() => {
    "CurrentPage": currentPage,
    "IndividualPagesDisplayedCount": individualPagesDisplayedCount,
    "PageIndex": pageIndex,
    "PageSize": pageSize,
    "ShowFirst": showFirst,
    "ShowIndividualPages": showIndividualPages,
    "ShowLast": showLast,
    "ShowNext": showNext,
    "ShowPagerItems": showPagerItems,
    "ShowPrevious": showPrevious,
    "ShowTotalSummary": showTotalSummary,
    "TotalPages": totalPages,
    "TotalRecords": totalRecords,
    "RouteActionName": routeActionName,
    "UseRouteLinks": useRouteLinks,
        "RouteValues": routeValues?.toJson(),
      };
}

class RouteValues {
  RouteValues({
    this.pageNumber,
  });

  int? pageNumber;

  factory RouteValues.fromJson(Map<String, dynamic> json) => RouteValues(
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
  };
}

class Subscription {
  Subscription({
    this.productId,
    this.productName,
    this.seName,
    this.id,
    this.customProperties,
  });

  int? productId;
  String? productName;
  String? seName;
  int? id;
  CustomProperties? customProperties;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    productId: json["ProductId"],
    productName: json["ProductName"],
    seName: json["SeName"],
    id: json["Id"],
    customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  factory Subscription.fake() => Subscription(
    productId: 1,
    productName: "Product Name",
    seName: "product-name",
    id: 1,
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "SeName": seName,
    "Id": id,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

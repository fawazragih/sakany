import 'custom_properties.dart';

class RewardPointResponse {
  RewardPointResponse({
    this.data,
    this.message,
    this.errorList,
  });

  RewardPointData? data;
  String? message;
  List<String>? errorList;

  RewardPointResponse copyWith({
    RewardPointData? data,
    String? message,
    List<String>? errorList,
  }) =>
      RewardPointResponse(
        data: data ?? this.data,
        message: message ?? this.message,
        errorList: errorList ?? this.errorList,
      );

  factory RewardPointResponse.fromJson(Map<String, dynamic> json) =>
      RewardPointResponse(
        data: json["Data"] == null
            ? null
            : RewardPointData.fromJson(json["Data"]),
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

class RewardPointData {
  RewardPointData({
    this.rewardPoints,
    this.pagerModel,
    this.rewardPointsBalance,
    this.rewardPointsAmount,
    this.minimumRewardPointsBalance,
    this.minimumRewardPointsAmount,
    this.customProperties,
  });

  List<RewardPoint>? rewardPoints;
  PagerModel? pagerModel;
  int? rewardPointsBalance;
  String? rewardPointsAmount;
  int? minimumRewardPointsBalance;
  String? minimumRewardPointsAmount;
  CustomProperties? customProperties;

  get hasMorePages {
    return (pagerModel?.totalPages ?? 0) >= (pagerModel?.currentPage ?? 0);
  }

  RewardPointData copyWith({
    List<RewardPoint>? rewardPoints,
    PagerModel? pagerModel,
    int? rewardPointsBalance,
    String? rewardPointsAmount,
    int? minimumRewardPointsBalance,
    String? minimumRewardPointsAmount,
    CustomProperties? customProperties,
  }) =>
      RewardPointData(
        rewardPoints: rewardPoints ?? this.rewardPoints,
        pagerModel: pagerModel ?? this.pagerModel,
        rewardPointsBalance: rewardPointsBalance ?? this.rewardPointsBalance,
        rewardPointsAmount: rewardPointsAmount ?? this.rewardPointsAmount,
        minimumRewardPointsBalance:
            minimumRewardPointsBalance ?? this.minimumRewardPointsBalance,
        minimumRewardPointsAmount:
            minimumRewardPointsAmount ?? this.minimumRewardPointsAmount,
        customProperties: customProperties ?? this.customProperties,
      );

  factory RewardPointData.fromJson(Map<String, dynamic> json) =>
      RewardPointData(
        rewardPoints: json["RewardPoints"] == null
            ? null
            : List<RewardPoint>.from(
                json["RewardPoints"]!.map((x) => RewardPoint.fromJson(x))),
        pagerModel: json["PagerModel"] == null
            ? null
            : PagerModel.fromJson(json["PagerModel"]),
        rewardPointsBalance: json["RewardPointsBalance"],
        rewardPointsAmount: json["RewardPointsAmount"],
        minimumRewardPointsBalance: json["MinimumRewardPointsBalance"],
        minimumRewardPointsAmount: json["MinimumRewardPointsAmount"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "RewardPoints": rewardPoints == null
            ? null
            : List<dynamic>.from(rewardPoints!.map((x) => x.toJson())),
        "PagerModel": pagerModel?.toJson(),
        "RewardPointsBalance": rewardPointsBalance,
        "RewardPointsAmount": rewardPointsAmount,
        "MinimumRewardPointsBalance": minimumRewardPointsBalance,
        "MinimumRewardPointsAmount": minimumRewardPointsAmount,
        "CustomProperties": customProperties?.toJson(),
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

  PagerModel copyWith({
    int? currentPage,
    int? individualPagesDisplayedCount,
    int? pageIndex,
    int? pageSize,
    bool? showFirst,
    bool? showIndividualPages,
    bool? showLast,
    bool? showNext,
    bool? showPagerItems,
    bool? showPrevious,
    bool? showTotalSummary,
    int? totalPages,
    int? totalRecords,
    String? routeActionName,
    bool? useRouteLinks,
    RouteValues? routeValues,
  }) =>
      PagerModel(
        currentPage: currentPage ?? this.currentPage,
        individualPagesDisplayedCount:
            individualPagesDisplayedCount ?? this.individualPagesDisplayedCount,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
        showFirst: showFirst ?? this.showFirst,
        showIndividualPages: showIndividualPages ?? this.showIndividualPages,
        showLast: showLast ?? this.showLast,
        showNext: showNext ?? this.showNext,
        showPagerItems: showPagerItems ?? this.showPagerItems,
        showPrevious: showPrevious ?? this.showPrevious,
        showTotalSummary: showTotalSummary ?? this.showTotalSummary,
        totalPages: totalPages ?? this.totalPages,
        totalRecords: totalRecords ?? this.totalRecords,
        routeActionName: routeActionName ?? this.routeActionName,
        useRouteLinks: useRouteLinks ?? this.useRouteLinks,
        routeValues: routeValues ?? this.routeValues,
      );

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
        routeValues: json["RouteValues"] == null
            ? null
            : RouteValues.fromJson(json["RouteValues"]),
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

  RouteValues copyWith({
    int? pageNumber,
  }) =>
      RouteValues(
        pageNumber: pageNumber ?? this.pageNumber,
      );

  factory RouteValues.fromJson(Map<String, dynamic> json) => RouteValues(
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
      };
}

class RewardPoint {
  RewardPoint({
    this.points,
    this.pointsBalance,
    this.message,
    this.createdOn,
    this.endDate,
    this.id,
    this.customProperties,
  });

  num? points;
  String? pointsBalance;
  String? message;
  DateTime? createdOn;
  DateTime? endDate;
  int? id;
  CustomProperties? customProperties;

  RewardPoint copyWith({
    int? points,
    String? pointsBalance,
    String? message,
    DateTime? createdOn,
    DateTime? endDate,
    int? id,
    CustomProperties? customProperties,
  }) =>
      RewardPoint(
        points: points ?? this.points,
        pointsBalance: pointsBalance ?? this.pointsBalance,
        message: message ?? this.message,
        createdOn: createdOn ?? this.createdOn,
        endDate: endDate ?? this.endDate,
        id: id ?? this.id,
        customProperties: customProperties ?? this.customProperties,
      );

  factory RewardPoint.fromJson(Map<String, dynamic> json) => RewardPoint(
        points: json["Points"],
        pointsBalance: json["PointsBalance"],
        message: json["Message"],
        createdOn: json["CreatedOn"] == null
            ? null
            : DateTime.parse(json["CreatedOn"]),
        endDate:
            json["EndDate"] == null ? null : DateTime.parse(json["EndDate"]),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory RewardPoint.fake() => RewardPoint(
        points: 10,
        pointsBalance: "1000",
        message: "You have earned 10 points",
        createdOn: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 1)),
        id: 1,
      );

  Map<String, dynamic> toJson() => {
        "Points": points,
        "PointsBalance": pointsBalance,
        "Message": message,
        "CreatedOn": createdOn?.toIso8601String(),
        "EndDate": endDate?.toIso8601String(),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

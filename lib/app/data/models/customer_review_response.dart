import 'custom_properties.dart';

// class CustomerReviewResponse {
//   CustomerReviewResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   CustomerReviewData? data;
//   String? message;
//   List<String>? errorList;
//
//   factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) => CustomerReviewResponse(
//     data: json["Data"] == null ? null : CustomerReviewData.fromJson(json["Data"]),
//     message: json["Message"],
//         errorList: json["ErrorList"] == null
//             ? null
//             : List<String>.from(json["ErrorList"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Data": data?.toJson(),
//         "Message": message,
//         "ErrorList": errorList == null
//             ? null
//             : List<dynamic>.from(errorList!.map((x) => x)),
//       };
// }

class CustomerReviewData {
  CustomerReviewData({
    this.productReviews,
    this.pagerModel,
    this.customProperties,
  });

  List<ProductReview>? productReviews;
  PagerModel? pagerModel;
  CustomProperties? customProperties;

  factory CustomerReviewData.fromJson(Map<String, dynamic> json) =>
      CustomerReviewData(
        productReviews: json["ProductReviews"] == null
            ? null
            : List<ProductReview>.from(
                json["ProductReviews"]!.map((x) => ProductReview.fromJson(x))),
        pagerModel: json["PagerModel"] == null
            ? null
            : PagerModel.fromJson(json["PagerModel"]),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductReviews": productReviews == null
            ? null
            : List<dynamic>.from(productReviews!.map((x) => x.toJson())),
        "PagerModel": pagerModel?.toJson(),
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

  bool get hasNextPage => (totalPages ?? 0) == (currentPage ?? 0);

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

  factory RouteValues.fromJson(Map<String, dynamic> json) => RouteValues(
        pageNumber: json["pageNumber"],
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
      };
}

class ProductReview {
  ProductReview({
    this.productId,
    this.productName,
    this.productSeName,
    this.title,
    this.reviewText,
    this.replyText,
    this.rating,
    this.writtenOnStr,
    this.approvalStatus,
    this.additionalProductReviewList,
    this.customProperties,
  });

  int? productId;
  String? productName;
  String? productSeName;
  String? title;
  String? reviewText;
  String? replyText;
  int? rating;
  String? writtenOnStr;
  dynamic approvalStatus;
  List<dynamic>? additionalProductReviewList;
  CustomProperties? customProperties;

  factory ProductReview.fromJson(Map<String, dynamic> json) => ProductReview(
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        title: json["Title"],
        reviewText: json["ReviewText"],
        replyText: json["ReplyText"],
        rating: json["Rating"],
        writtenOnStr: json["WrittenOnStr"],
        approvalStatus: json["ApprovalStatus"],
        additionalProductReviewList: json["AdditionalProductReviewList"] == null
            ? null
            : List<dynamic>.from(
                json["AdditionalProductReviewList"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "Title": title,
        "ReviewText": reviewText,
        "ReplyText": replyText,
        "Rating": rating,
        "WrittenOnStr": writtenOnStr,
        "ApprovalStatus": approvalStatus,
        "AdditionalProductReviewList": additionalProductReviewList == null
            ? null
            : List<dynamic>.from(additionalProductReviewList!.map((x) => x)),
        "CustomProperties": customProperties?.toJson(),
      };

  factory ProductReview.fake() => ProductReview(
        productId: 1,
        productName: "Product Name",
        productSeName: "product-name",
        title: "Title",
        reviewText: "Review Text",
        replyText: "Reply Text",
        rating: 5,
        writtenOnStr: "2022-01-01T00:00:00",
        approvalStatus: "Approved",
        additionalProductReviewList: [],
        customProperties: CustomProperties(
          customerBASAuthCode: "123456",
          orderPaymentInfoTempKey: "123456",
        ),
      );
}

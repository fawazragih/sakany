
// class ProductReviewResponse {
//   ProductReviewResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   ProductReviewData? data;
//   String? message;
//   List<String>? errorList;
//
//   ProductReviewResponse copyWith({
//     ProductReviewData? data,
//     String? message,
//     List<String>? errorList,
//   }) =>
//       ProductReviewResponse(
//         data: data ?? this.data,
//         message: message ?? this.message,
//         errorList: errorList ?? this.errorList,
//       );
//
//   factory ProductReviewResponse.fromJson(Map<String, dynamic> json) => ProductReviewResponse(
//     data: json["Data"] == null ? null : ProductReviewData.fromJson(json["Data"]),
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

// class ProductReviewData {
//   ProductReviewData({
//     this.productId,
//     this.productName,
//     this.productSeName,
//     this.items,
//     this.addProductReview,
//     this.reviewTypeList,
//     this.addAdditionalProductReviewList,
//     this.customProperties,
//   });
//
//   int? productId;
//   String? productName;
//   String? productSeName;
//   List<ProductReviewItem>? items;
//   AddProductReview? addProductReview;
//   List<dynamic>? reviewTypeList;
//   List<dynamic>? addAdditionalProductReviewList;
//   CustomProperties? customProperties;
//
//   ProductReviewData copyWith({
//     int? productId,
//     String? productName,
//     String? productSeName,
//     List<ProductReviewItem>? items,
//     AddProductReview? addProductReview,
//     List<dynamic>? reviewTypeList,
//     List<dynamic>? addAdditionalProductReviewList,
//     CustomProperties? customProperties,
//   }) =>
//       ProductReviewData(
//         productId: productId ?? this.productId,
//         productName: productName ?? this.productName,
//         productSeName: productSeName ?? this.productSeName,
//         items: items ?? this.items,
//         addProductReview: addProductReview ?? this.addProductReview,
//         reviewTypeList: reviewTypeList ?? this.reviewTypeList,
//         addAdditionalProductReviewList: addAdditionalProductReviewList ?? this.addAdditionalProductReviewList,
//         customProperties: customProperties ?? this.customProperties,
//       );
//
//   factory ProductReviewData.fromJson(Map<String, dynamic> json) => ProductReviewData(
//     productId: json["ProductId"],
//     productName: json["ProductName"],
//     productSeName: json["ProductSeName"],
//     items: json["Items"] == null
//         ? null
//         : List<ProductReviewItem>.from(
//         json["Items"]!.map((x) => ProductReviewItem.fromJson(x))),
//     addProductReview: json["AddProductReview"] == null ? null : AddProductReview.fromJson(json["AddProductReview"]),
//     reviewTypeList: json["ReviewTypeList"] == null
//         ? null
//         : List<dynamic>.from(json["ReviewTypeList"]!.map((x) => x)),
//     addAdditionalProductReviewList:
//     json["AddAdditionalProductReviewList"] == null
//         ? null
//         : List<dynamic>.from(
//         json["AddAdditionalProductReviewList"]!.map((x) => x)),
//     customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ProductId": productId,
//     "ProductName": productName,
//     "ProductSeName": productSeName,
//     "Items": items == null
//         ? null
//         : List<dynamic>.from(items!.map((x) => x.toJson())),
//     "AddProductReview":
//     addProductReview?.toJson(),
//     "ReviewTypeList": reviewTypeList == null
//         ? null
//         : List<dynamic>.from(reviewTypeList!.map((x) => x)),
//     "AddAdditionalProductReviewList": addAdditionalProductReviewList == null
//         ? null
//         : List<dynamic>.from(addAdditionalProductReviewList!.map((x) => x)),
//     "CustomProperties":
//     customProperties?.toJson(),
//   };
// }
class ProductReviewData {
  GeneralInfo? generalInfo;
  Reviews? reviews;

  ProductReviewData({
    this.generalInfo,
    this.reviews,
  });

  factory ProductReviewData.fromJson(Map<String, dynamic> json) =>
      ProductReviewData(
        generalInfo: json["GeneralInfo"] == null
            ? null
            : GeneralInfo.fromJson(json["GeneralInfo"]),
        reviews:
            json["Reviews"] == null ? null : Reviews.fromJson(json["Reviews"]),
      );

  Map<String, dynamic> toJson() => {
        "GeneralInfo": generalInfo?.toJson(),
        "Reviews": reviews?.toJson(),
      };
}

class GeneralInfo {
  int? productId;
  String? productName;
  String? productSeName;
  List<dynamic>? items;
  AddProductReview? addProductReview;
  List<dynamic>? reviewTypeList;
  List<dynamic>? addAdditionalProductReviewList;
  CustomProperties? customProperties;

  GeneralInfo({
    this.productId,
    this.productName,
    this.productSeName,
    this.items,
    this.addProductReview,
    this.reviewTypeList,
    this.addAdditionalProductReviewList,
    this.customProperties,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) => GeneralInfo(
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        items: json["Items"] == null
            ? []
            : List<dynamic>.from(json["Items"]!.map((x) => x)),
        addProductReview: json["AddProductReview"] == null
            ? null
            : AddProductReview.fromJson(json["AddProductReview"]),
        reviewTypeList: json["ReviewTypeList"] == null
            ? []
            : List<dynamic>.from(json["ReviewTypeList"]!.map((x) => x)),
        addAdditionalProductReviewList:
            json["AddAdditionalProductReviewList"] == null
                ? []
                : List<dynamic>.from(
                    json["AddAdditionalProductReviewList"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "Items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
        "AddProductReview": addProductReview?.toJson(),
        "ReviewTypeList": reviewTypeList == null
            ? []
            : List<dynamic>.from(reviewTypeList!.map((x) => x)),
        "AddAdditionalProductReviewList": addAdditionalProductReviewList == null
            ? []
            : List<dynamic>.from(addAdditionalProductReviewList!.map((x) => x)),
        "CustomProperties": customProperties?.toJson(),
      };
}

class CustomProperties {
  CustomProperties();

  factory CustomProperties.fromJson(Map<String, dynamic> json) =>
      CustomProperties();

  Map<String, dynamic> toJson() => {};
}

class Reviews {
  List<ProductReviewItem>? items;
  dynamic draw;
  int? recordsFiltered;
  int? recordsTotal;
  CustomProperties? customProperties;

  Reviews({
    this.items,
    this.draw,
    this.recordsFiltered,
    this.recordsTotal,
    this.customProperties,
  });

  bool hasMore(int appListLength) {
    return recordsTotal != null && recordsTotal! > appListLength;
  }

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        items: json["Data"] == null
            ? []
            : List<ProductReviewItem>.from(
                json["Data"]!.map((x) => ProductReviewItem.fromJson(x))),
        draw: json["draw"],
        recordsFiltered: json["recordsFiltered"],
        recordsTotal: json["recordsTotal"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "draw": draw,
        "recordsFiltered": recordsFiltered,
        "recordsTotal": recordsTotal,
        "CustomProperties": customProperties?.toJson(),
      };
}

class AddProductReview {
  AddProductReview({
    this.title,
    this.reviewText,
    this.rating,
    this.displayCaptcha,
    this.canCurrentCustomerLeaveReview,
    this.successfullyAdded,
    this.canAddNewReview,
    this.result,
    this.customProperties,
  });

  String? title;
  String? reviewText;
  int? rating;
  bool? displayCaptcha;
  bool? canCurrentCustomerLeaveReview;
  bool? successfullyAdded;
  bool? canAddNewReview;
  String? result;
  CustomProperties? customProperties;

  AddProductReview copyWith({
    String? title,
    String? reviewText,
    int? rating,
    bool? displayCaptcha,
    bool? canCurrentCustomerLeaveReview,
    bool? successfullyAdded,
    bool? canAddNewReview,
    dynamic result,
    CustomProperties? customProperties,
  }) =>
      AddProductReview(
        title: title ?? this.title,
        reviewText: reviewText ?? this.reviewText,
        rating: rating ?? this.rating,
        displayCaptcha: displayCaptcha ?? this.displayCaptcha,
        canCurrentCustomerLeaveReview:
            canCurrentCustomerLeaveReview ?? this.canCurrentCustomerLeaveReview,
        successfullyAdded: successfullyAdded ?? this.successfullyAdded,
        canAddNewReview: canAddNewReview ?? this.canAddNewReview,
        result: result ?? this.result,
        customProperties: customProperties ?? this.customProperties,
      );

  factory AddProductReview.fromJson(Map<String, dynamic> json) =>
      AddProductReview(
        title: json["Title"],
        reviewText: json["ReviewText"],
        rating: json["Rating"],
        displayCaptcha: json["DisplayCaptcha"],
        canCurrentCustomerLeaveReview: json["CanCurrentCustomerLeaveReview"],
        successfullyAdded: json["SuccessfullyAdded"],
        canAddNewReview: json["CanAddNewReview"],
        result: json["Result"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "ReviewText": reviewText,
        "Rating": rating,
        "DisplayCaptcha": displayCaptcha,
        "CanCurrentCustomerLeaveReview": canCurrentCustomerLeaveReview,
        "SuccessfullyAdded": successfullyAdded,
        "CanAddNewReview": canAddNewReview,
        "Result": result,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ProductReviewItem {
  ProductReviewItem({
    this.customerId,
    this.customerAvatarUrl,
    this.customerName,
    this.allowViewingProfiles,
    this.title,
    this.reviewText,
    this.replyText,
    this.rating,
    this.writtenOnStr,
    this.helpfulness,
    this.additionalProductReviewList,
    this.id,
    this.customProperties,
  });

  int? customerId;
  String? customerAvatarUrl;
  String? customerName;
  bool? allowViewingProfiles;
  String? title;
  String? reviewText;
  String? replyText;
  int? rating;
  String? writtenOnStr;
  Helpfulness? helpfulness;
  List<dynamic>? additionalProductReviewList;
  int? id;
  CustomProperties? customProperties;

  ProductReviewItem copyWith({
    int? customerId,
    String? customerAvatarUrl,
    String? customerName,
    bool? allowViewingProfiles,
    String? title,
    String? reviewText,
    String? replyText,
    int? rating,
    String? writtenOnStr,
    Helpfulness? helpfulness,
    List<dynamic>? additionalProductReviewList,
    int? id,
    CustomProperties? customProperties,
  }) =>
      ProductReviewItem(
        customerId: customerId ?? this.customerId,
        customerAvatarUrl: customerAvatarUrl ?? this.customerAvatarUrl,
        customerName: customerName ?? this.customerName,
        allowViewingProfiles: allowViewingProfiles ?? this.allowViewingProfiles,
        title: title ?? this.title,
        reviewText: reviewText ?? this.reviewText,
        replyText: replyText ?? this.replyText,
        rating: rating ?? this.rating,
        writtenOnStr: writtenOnStr ?? this.writtenOnStr,
        helpfulness: helpfulness ?? this.helpfulness,
        additionalProductReviewList:
            additionalProductReviewList ?? this.additionalProductReviewList,
        id: id ?? this.id,
        customProperties: customProperties ?? this.customProperties,
      );

  factory ProductReviewItem.fromJson(Map<String, dynamic> json) =>
      ProductReviewItem(
        customerId: json["CustomerId"],
        customerAvatarUrl: json["CustomerAvatarUrl"],
        customerName: json["CustomerName"],
        allowViewingProfiles: json["AllowViewingProfiles"],
        title: json["Title"],
        reviewText: json["ReviewText"],
        replyText: json["ReplyText"],
        rating: json["Rating"],
        writtenOnStr: json["WrittenOnStr"],
        helpfulness: json["Helpfulness"] == null
            ? null
            : Helpfulness.fromJson(json["Helpfulness"]),
        additionalProductReviewList: json["AdditionalProductReviewList"] == null
            ? null
            : List<dynamic>.from(
                json["AdditionalProductReviewList"]!.map((x) => x)),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "CustomerId": customerId,
        "CustomerAvatarUrl": customerAvatarUrl,
        "CustomerName": customerName,
        "AllowViewingProfiles": allowViewingProfiles,
        "Title": title,
        "ReviewText": reviewText,
        "ReplyText": replyText,
        "Rating": rating,
        "WrittenOnStr": writtenOnStr,
        "Helpfulness": helpfulness?.toJson(),
        "AdditionalProductReviewList": additionalProductReviewList == null
            ? null
            : List<dynamic>.from(additionalProductReviewList!.map((x) => x)),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class Helpfulness {
  Helpfulness({
    this.productReviewId,
    this.helpfulYesTotal,
    this.helpfulNoTotal,
    this.customProperties,
  });

  int? productReviewId;
  int? helpfulYesTotal;
  int? helpfulNoTotal;
  CustomProperties? customProperties;

  Helpfulness copyWith({
    int? productReviewId,
    int? helpfulYesTotal,
    int? helpfulNoTotal,
    CustomProperties? customProperties,
  }) =>
      Helpfulness(
        productReviewId: productReviewId ?? this.productReviewId,
        helpfulYesTotal: helpfulYesTotal ?? this.helpfulYesTotal,
        helpfulNoTotal: helpfulNoTotal ?? this.helpfulNoTotal,
        customProperties: customProperties ?? this.customProperties,
      );

  factory Helpfulness.fromJson(Map<String, dynamic> json) => Helpfulness(
        productReviewId: json["ProductReviewId"],
        helpfulYesTotal: json["HelpfulYesTotal"],
        helpfulNoTotal: json["HelpfulNoTotal"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductReviewId": productReviewId,
        "HelpfulYesTotal": helpfulYesTotal,
        "HelpfulNoTotal": helpfulNoTotal,
        "CustomProperties": customProperties?.toJson(),
      };
}

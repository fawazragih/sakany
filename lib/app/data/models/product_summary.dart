import 'package:skeletonizer/skeletonizer.dart';

import 'custom_properties.dart';
import 'picture_model.dart';

class ProductSummary {
  ProductSummary({
    this.name,
    this.shortDescription,
    this.fullDescription,
    this.seName,
    this.sku,
    this.productType,
    this.markAsNew,
    this.productPrice,
    this.defaultPictureModel,
    this.productSpecificationModel,
    this.reviewOverviewModel,
    this.id,
    this.customProperties,
    this.pictureModels,
  });

  String? name;
  String? shortDescription;
  String? fullDescription;
  String? seName;
  String? sku;
  int? productType;
  bool? markAsNew;
  ProductSummaryPrice? productPrice;
  PictureModel? defaultPictureModel;
  List<PictureModel>? pictureModels;
  ProductSpecificationModel? productSpecificationModel;
  ReviewOverviewModel? reviewOverviewModel;
  int? id;
  CustomProperties? customProperties;

  factory ProductSummary.fromJson(Map<String, dynamic> json) => ProductSummary(
        name: json["Name"],
        shortDescription: json["ShortDescription"],
        fullDescription: json["FullDescription"],
        seName: json["SeName"],
        sku: json["Sku"],
        productType: json["ProductType"],
        markAsNew: json["MarkAsNew"],
        productPrice: json["ProductPrice"] == null
            ? null
            : ProductSummaryPrice.fromJson(json["ProductPrice"]),
        defaultPictureModel: json["DefaultPictureModel"] == null
            ? null
            : PictureModel.fromJson(json["DefaultPictureModel"]),
        productSpecificationModel: json["ProductSpecificationModel"] == null
            ? null
            : ProductSpecificationModel.fromJson(
                json["ProductSpecificationModel"]),
        reviewOverviewModel: json["ReviewOverviewModel"] == null
            ? null
            : ReviewOverviewModel.fromJson(json["ReviewOverviewModel"]),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      pictureModels: json["PictureModels"] == null
            ? null
            : List<PictureModel>.from(
                json["PictureModels"]!.map((x) => PictureModel.fromJson(x))),
      );

  factory ProductSummary.fake() => ProductSummary(
        name: BoneMock.words(4),
        shortDescription: "Short Description",
        fullDescription: "Full Description",
        seName: "product-name",
        sku: "product-sku",
        productType: 1,
        markAsNew: false,
        productPrice: ProductSummaryPrice.fake(),
        defaultPictureModel: PictureModel(
          imageUrl: "https://picsum.photos/seed/picsum/200/300",
          thumbImageUrl: "https://picsum.photos/seed/picsum/200/300",
          fullSizeImageUrl: "https://picsum.photos/seed/picsum/200/300",
          title: "Product Name",
        ),
        productSpecificationModel: ProductSpecificationModel.fake(),
        reviewOverviewModel: ReviewOverviewModel(
          productId: 1,
          ratingSum: 4,
          totalReviews: 10,
          allowCustomerReviews: true,
          canAddNewReview: true,
        ),
        id: 1,
        customProperties: CustomProperties(
          customerBASAuthCode: "123456",
          orderPaymentInfoTempKey: "123456",
        ),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "ShortDescription": shortDescription,
        "FullDescription": fullDescription,
        "SeName": seName,
        "Sku": sku,
        "ProductType": productType,
        "MarkAsNew": markAsNew,
        "ProductPrice": productPrice?.toJson(),
        "DefaultPictureModel": defaultPictureModel?.toJson(),
        "ProductSpecificationModel": productSpecificationModel?.toJson(),
        "ReviewOverviewModel": reviewOverviewModel?.toJson(),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ProductSpecificationModel {
  ProductSpecificationModel({
    this.groups,
    this.customProperties,
  });

  List<dynamic>? groups;
  CustomProperties? customProperties;

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) =>
      ProductSpecificationModel(
        groups: json["Groups"] == null
            ? null
            : List<dynamic>.from(json["Groups"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory ProductSpecificationModel.fake() => ProductSpecificationModel(
        groups: [
          {
            "Name": "Group 1",
            "Properties": [
              {
                "Name": "Property 1",
                "Value": "Value 1",
              },
              {
                "Name": "Property 2",
                "Value": "Value 2",
              },
            ],
          },
          {
            "Name": "Group 2",
            "Properties": [
              {
                "Name": "Property 3",
                "Value": "Value 3",
              },
              {
                "Name": "Property 4",
                "Value": "Value 4",
              },
            ],
          },
        ],
      );

  Map<String, dynamic> toJson() => {
        "Groups":
            groups == null ? null : List<dynamic>.from(groups!.map((x) => x)),
        "CustomProperties": customProperties?.toJson(),
      };
}

class ReviewOverviewModel {
  ReviewOverviewModel({
    this.productId,
    this.ratingSum,
    this.totalReviews,
    this.allowCustomerReviews,
    this.canAddNewReview,
    this.customProperties,
  });

  int? productId;
  int? ratingSum;
  int? totalReviews;
  bool? allowCustomerReviews;
  bool? canAddNewReview;
  CustomProperties? customProperties;

  factory ReviewOverviewModel.fromJson(Map<String, dynamic> json) =>
      ReviewOverviewModel(
        productId: json["ProductId"],
        ratingSum: json["RatingSum"],
        totalReviews: json["TotalReviews"],
        allowCustomerReviews: json["AllowCustomerReviews"],
        canAddNewReview: json["CanAddNewReview"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "RatingSum": ratingSum,
        "TotalReviews": totalReviews,
        "AllowCustomerReviews": allowCustomerReviews,
        "CanAddNewReview": canAddNewReview,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ProductSummaryPrice {
  ProductSummaryPrice({
    this.oldPrice,
    this.price,
    this.priceValue,
    this.basePricePAngV,
    this.disableBuyButton,
    this.disableWishlistButton,
    this.disableAddToCompareListButton,
    this.availableForPreOrder,
    this.preOrderAvailabilityStartDateTimeUtc,
    this.isRental,
    this.forceRedirectionAfterAddingToCart,
    this.displayTaxShippingInfo,
    this.customProperties,
  });

  String? oldPrice;
  String? price;
  num? priceValue;
  String? basePricePAngV;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? disableAddToCompareListButton;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  bool? isRental;
  bool? forceRedirectionAfterAddingToCart;
  bool? displayTaxShippingInfo;
  CustomProperties? customProperties;

  factory ProductSummaryPrice.fromJson(Map<String, dynamic> json) =>
      ProductSummaryPrice(
        oldPrice: json["OldPrice"],
        price: json["Price"],
        priceValue: json["PriceValue"],
        basePricePAngV: json["BasePricePAngV"],
        disableBuyButton: json["DisableBuyButton"],
        disableWishlistButton: json["DisableWishlistButton"],
        disableAddToCompareListButton: json["DisableAddToCompareListButton"],
        availableForPreOrder: json["AvailableForPreOrder"],
        preOrderAvailabilityStartDateTimeUtc:
            json["PreOrderAvailabilityStartDateTimeUtc"],
        isRental: json["IsRental"],
        forceRedirectionAfterAddingToCart:
            json["ForceRedirectionAfterAddingToCart"],
        displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory ProductSummaryPrice.fake() => ProductSummaryPrice(
        oldPrice: "10 SAR",
        price: "200.00 SAR",
        priceValue: 200.00,
        basePricePAngV: "200.00 SAR",
        disableBuyButton: false,
        disableWishlistButton: false,
        disableAddToCompareListButton: false,
        availableForPreOrder: false,
        preOrderAvailabilityStartDateTimeUtc: null,
        isRental: false,
        forceRedirectionAfterAddingToCart: false,
        displayTaxShippingInfo: false,
        customProperties: CustomProperties(
          customerBASAuthCode: "123456",
          orderPaymentInfoTempKey: "123456",
        ),
      );

  Map<String, dynamic> toJson() => {
        "OldPrice": oldPrice,
        "Price": price,
        "PriceValue": priceValue,
        "BasePricePAngV": basePricePAngV,
        "DisableBuyButton": disableBuyButton,
        "DisableWishlistButton": disableWishlistButton,
        "DisableAddToCompareListButton": disableAddToCompareListButton,
        "AvailableForPreOrder": availableForPreOrder,
        "PreOrderAvailabilityStartDateTimeUtc":
            preOrderAvailabilityStartDateTimeUtc,
        "IsRental": isRental,
        "ForceRedirectionAfterAddingToCart": forceRedirectionAfterAddingToCart,
        "DisplayTaxShippingInfo": displayTaxShippingInfo,
        "CustomProperties": customProperties?.toJson(),
      };
}

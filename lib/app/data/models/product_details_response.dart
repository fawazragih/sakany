import 'package:app_extensions/app_extensions.dart';
import 'package:sakani_mobile_app/app/data/models/picture_model.dart';

import 'available_option.dart';
import 'custom_attribute.dart';
import 'custom_properties.dart';
import 'estimate_shipping.dart';
import 'gift_card.dart';

// class ProductDetailsResponse {
//   ProductDetailsResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   ProductDetails? data;
//   String? message;
//   List<String>? errorList;
//
//   factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) => ProductDetailsResponse(
//     data: json["Data"] == null ? null : ProductDetails.fromJson(json["Data"]),
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

class ProductDetails {
  ProductDetails({
    this.defaultPictureZoomEnabled,
    this.defaultPictureModel,
    this.pictureModels,
    this.name,
    this.shortDescription,
    this.fullDescription,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.visibleIndividually,
    this.productType,
    this.showSku,
    this.sku,
    this.showManufacturerPartNumber,
    this.manufacturerPartNumber,
    this.showGtin,
    this.gtin,
    this.showVendor,
    this.vendorModel,
    this.hasSampleDownload,
    this.giftCard,
    this.isShipEnabled,
    this.isFreeShipping,
    this.freeShippingNotificationEnabled,
    this.deliveryDate,
    this.isRental,
    this.rentalStartDate,
    this.rentalEndDate,
    this.availableEndDate,
    this.manageInventoryMethod,
    this.stockAvailability,
    this.displayBackInStockSubscription,
    this.emailAFriendEnabled,
    this.compareProductsEnabled,
    this.pageShareCode,
    this.productPrice,
    this.addToCart,
    this.breadcrumb,
    this.productTags,
    this.productAttributes,
    this.productSpecificationModel,
    this.productManufacturers,
    this.productReviewOverview,
    this.productEstimateShipping,
    this.tierPrices,
    this.associatedProducts,
    this.displayDiscontinuedMessage,
    this.currentStoreName,
    this.inStock,
    this.allowAddingOnlyExistingAttributeCombinations,
    this.id,
    this.customProperties,
  });

  bool? defaultPictureZoomEnabled;
  PictureModel? defaultPictureModel;
  List<PictureModel>? pictureModels;
  String? name;
  String? shortDescription;
  String? fullDescription;
  dynamic metaKeywords;
  String? metaDescription;
  String? metaTitle;
  String? seName;
  bool? visibleIndividually;
  num? productType;
  bool? showSku;
  String? sku;
  bool? showManufacturerPartNumber;
  dynamic manufacturerPartNumber;
  bool? showGtin;
  String? gtin;
  bool? showVendor;
  VendorModel? vendorModel;
  bool? hasSampleDownload;
  GiftCard? giftCard;
  bool? isShipEnabled;
  bool? isFreeShipping;
  bool? freeShippingNotificationEnabled;
  String? deliveryDate;
  bool? isRental;
  dynamic rentalStartDate;
  dynamic rentalEndDate;
  dynamic availableEndDate;
  num? manageInventoryMethod;
  String? stockAvailability;
  bool? displayBackInStockSubscription;
  bool? emailAFriendEnabled;
  bool? compareProductsEnabled;
  String? pageShareCode;
  ProductPrice? productPrice;
  AddToCart? addToCart;
  Breadcrumb? breadcrumb;
  List<VendorModel>? productTags;
  List<CustomAttribute>? productAttributes;
  ProductSpecificationModel? productSpecificationModel;
  List<VendorModel>? productManufacturers;
  ProductReviewOverview? productReviewOverview;
  EstimateShipping? productEstimateShipping;
  List<TierPrice>? tierPrices;
  List<ProductDetails>? associatedProducts;
  bool? displayDiscontinuedMessage;
  String? currentStoreName;
  bool? inStock;
  bool? allowAddingOnlyExistingAttributeCombinations;
  int? id;
  CustomProperties? customProperties;

  bool get checkShowSku => showSku == true && sku.isNotNullOrEmpty;
  // bool get showDescription => shortDescription.isNotNullOrEmpty;

  bool get checkShowManufacturerPartNumber =>
      showManufacturerPartNumber == true &&
      manufacturerPartNumber.isNotNullOrEmpty;

  bool get checkShowGtin => showGtin == true && gtin.isNotNullOrEmpty;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        defaultPictureZoomEnabled: json["DefaultPictureZoomEnabled"],
        defaultPictureModel: json["DefaultPictureModel"] == null
            ? null
            : PictureModel.fromJson(json["DefaultPictureModel"]),
        pictureModels: json["PictureModels"] == null
            ? null
            : List<PictureModel>.from(
                json["PictureModels"]!.map((x) => PictureModel.fromJson(x))),
        name: json["Name"],
        shortDescription: json["ShortDescription"],
        fullDescription: json["FullDescription"],
        metaKeywords: json["MetaKeywords"],
        metaDescription: json["MetaDescription"],
        metaTitle: json["MetaTitle"],
        seName: json["SeName"],
        visibleIndividually: json["VisibleIndividually"],
        productType: json["ProductType"],
        showSku: json["ShowSku"],
        sku: json["Sku"],
        showManufacturerPartNumber: json["ShowManufacturerPartNumber"],
        manufacturerPartNumber: json["ManufacturerPartNumber"],
        showGtin: json["ShowGtin"],
        gtin: json["Gtin"],
        showVendor: json["ShowVendor"],
        vendorModel: json["VendorModel"] == null
            ? null
            : VendorModel.fromJson(json["VendorModel"]),
        hasSampleDownload: json["HasSampleDownload"],
        giftCard: json["GiftCard"] == null
            ? null
            : GiftCard.fromJson(json["GiftCard"]),
        isShipEnabled: json["IsShipEnabled"],
        isFreeShipping: json["IsFreeShipping"],
        freeShippingNotificationEnabled:
            json["FreeShippingNotificationEnabled"],
        deliveryDate: json["DeliveryDate"],
        isRental: json["IsRental"],
        rentalStartDate: json["RentalStartDate"],
        rentalEndDate: json["RentalEndDate"],
        availableEndDate: json["AvailableEndDate"],
        manageInventoryMethod: json["ManageInventoryMethod"],
        stockAvailability: json["StockAvailability"],
        displayBackInStockSubscription: json["DisplayBackInStockSubscription"],
        emailAFriendEnabled: json["EmailAFriendEnabled"],
        compareProductsEnabled: json["CompareProductsEnabled"],
        pageShareCode: json["PageShareCode"],
        productPrice: json["ProductPrice"] == null
            ? null
            : ProductPrice.fromJson(json["ProductPrice"]),
        addToCart: json["AddToCart"] == null
            ? null
            : AddToCart.fromJson(json["AddToCart"]),
        breadcrumb: json["Breadcrumb"] == null
            ? null
            : Breadcrumb.fromJson(json["Breadcrumb"]),
        productTags: json["ProductTags"] == null
            ? null
            : List<VendorModel>.from(
                json["ProductTags"]!.map((x) => VendorModel.fromJson(x))),
        productAttributes: json["ProductAttributes"] == null
            ? null
            : List<CustomAttribute>.from(json["ProductAttributes"]!
                .map((x) => CustomAttribute.fromJson(x))),
        productSpecificationModel: json["ProductSpecificationModel"] == null
            ? null
            : ProductSpecificationModel.fromJson(
                json["ProductSpecificationModel"]),
        productManufacturers: json["ProductManufacturers"] == null
            ? null
            : List<VendorModel>.from(json["ProductManufacturers"]!
                .map((x) => VendorModel.fromJson(x))),
        productReviewOverview: json["ProductReviewOverview"] == null
            ? null
            : ProductReviewOverview.fromJson(json["ProductReviewOverview"]),
        productEstimateShipping: json["ProductEstimateShipping"] == null
            ? null
            : EstimateShipping.fromJson(json["ProductEstimateShipping"]),
        tierPrices: json["TierPrices"] == null
            ? null
            : List<TierPrice>.from(
                json["TierPrices"]!.map((x) => TierPrice.fromJson(x))),
        associatedProducts: json["AssociatedProducts"] == null
            ? null
            : List<ProductDetails>.from(json["AssociatedProducts"]!
                .map((x) => ProductDetails.fromJson(x))),
        displayDiscontinuedMessage: json["DisplayDiscontinuedMessage"],
        currentStoreName: json["CurrentStoreName"],
        inStock: json["InStock"],
        allowAddingOnlyExistingAttributeCombinations:
            json["AllowAddingOnlyExistingAttributeCombinations"],
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "DefaultPictureZoomEnabled": defaultPictureZoomEnabled,
        "DefaultPictureModel": defaultPictureModel?.toJson(),
        "PictureModels": pictureModels == null
            ? null
            : List<dynamic>.from(pictureModels!.map((x) => x.toJson())),
        "Name": name,
        "ShortDescription": shortDescription,
        "FullDescription": fullDescription,
        "MetaKeywords": metaKeywords,
        "MetaDescription": metaDescription,
        "MetaTitle": metaTitle,
        "SeName": seName,
        "VisibleIndividually": visibleIndividually,
        "ProductType": productType,
        "ShowSku": showSku,
        "Sku": sku,
        "ShowManufacturerPartNumber": showManufacturerPartNumber,
        "ManufacturerPartNumber": manufacturerPartNumber,
        "ShowGtin": showGtin,
        "Gtin": gtin,
        "ShowVendor": showVendor,
        "VendorModel": vendorModel?.toJson(),
        "HasSampleDownload": hasSampleDownload,
        "GiftCard": giftCard?.toJson(),
        "IsShipEnabled": isShipEnabled,
        "IsFreeShipping": isFreeShipping,
        "FreeShippingNotificationEnabled": freeShippingNotificationEnabled,
        "DeliveryDate": deliveryDate,
        "IsRental": isRental,
        "RentalStartDate": rentalStartDate,
        "RentalEndDate": rentalEndDate,
        "AvailableEndDate": availableEndDate,
        "ManageInventoryMethod": manageInventoryMethod,
        "StockAvailability": stockAvailability,
        "DisplayBackInStockSubscription": displayBackInStockSubscription,
        "EmailAFriendEnabled": emailAFriendEnabled,
        "CompareProductsEnabled": compareProductsEnabled,
        "PageShareCode": pageShareCode,
        "ProductPrice": productPrice?.toJson(),
        "AddToCart": addToCart?.toJson(),
        "Breadcrumb": breadcrumb?.toJson(),
        "ProductTags": productTags == null
            ? null
            : List<dynamic>.from(productTags!.map((x) => x.toJson())),
        "ProductAttributes": productAttributes == null
            ? null
            : List<dynamic>.from(productAttributes!.map((x) => x.toJson())),
        "ProductSpecificationModel": productSpecificationModel?.toJson(),
        "ProductManufacturers": productManufacturers == null
            ? null
            : List<dynamic>.from(productManufacturers!.map((x) => x.toJson())),
        "ProductReviewOverview": productReviewOverview?.toJson(),
        "ProductEstimateShipping": productEstimateShipping?.toJson(),
        "TierPrices": tierPrices == null
            ? null
            : List<dynamic>.from(tierPrices!.map((x) => x.toJson())),
        "AssociatedProducts": associatedProducts == null
            ? null
            : List<dynamic>.from(associatedProducts!.map((x) => x.toJson())),
        "DisplayDiscontinuedMessage": displayDiscontinuedMessage,
        "CurrentStoreName": currentStoreName,
        "InStock": inStock,
        "AllowAddingOnlyExistingAttributeCombinations":
            allowAddingOnlyExistingAttributeCombinations,
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class AddToCart {
  AddToCart({
    this.productId,
    this.enteredQuantity,
    this.minimumQuantityNotification,
    this.allowedQuantities,
    this.customerEntersPrice,
    this.customerEnteredPrice,
    this.customerEnteredPriceRange,
    this.disableBuyButton,
    this.disableWishlistButton,
    this.isRental,
    this.availableForPreOrder,
    this.preOrderAvailabilityStartDateTimeUtc,
    this.preOrderAvailabilityStartDateTimeUserTime,
    this.updatedShoppingCartItemId,
    this.updateShoppingCartItemType,
    this.customProperties,
  });

  int? productId;
  int? enteredQuantity;
  dynamic minimumQuantityNotification;
  List<AvailableOption>? allowedQuantities;
  bool? customerEntersPrice;
  num? customerEnteredPrice;
  String? customerEnteredPriceRange;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? isRental;
  bool? availableForPreOrder;
  dynamic preOrderAvailabilityStartDateTimeUtc;
  dynamic preOrderAvailabilityStartDateTimeUserTime;
  num? updatedShoppingCartItemId;
  dynamic updateShoppingCartItemType;
  CustomProperties? customProperties;

  factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
        productId: json["ProductId"],
        enteredQuantity: json["EnteredQuantity"],
        minimumQuantityNotification: json["MinimumQuantityNotification"],
        allowedQuantities: json["AllowedQuantities"] == null
            ? null
            : List<AvailableOption>.from(json["AllowedQuantities"]!
                .map((x) => AvailableOption.fromJson(x))),
        customerEntersPrice: json["CustomerEntersPrice"],
        customerEnteredPrice: json["CustomerEnteredPrice"],
        customerEnteredPriceRange: json["CustomerEnteredPriceRange"],
        disableBuyButton: json["DisableBuyButton"],
        disableWishlistButton: json["DisableWishlistButton"],
        isRental: json["IsRental"],
        availableForPreOrder: json["AvailableForPreOrder"],
        preOrderAvailabilityStartDateTimeUtc:
            json["PreOrderAvailabilityStartDateTimeUtc"],
        preOrderAvailabilityStartDateTimeUserTime:
            json["PreOrderAvailabilityStartDateTimeUserTime"],
        updatedShoppingCartItemId: json["UpdatedShoppingCartItemId"],
        updateShoppingCartItemType: json["UpdateShoppingCartItemType"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "EnteredQuantity": enteredQuantity,
        "MinimumQuantityNotification": minimumQuantityNotification,
        "AllowedQuantities": allowedQuantities == null
            ? null
            : List<dynamic>.from(allowedQuantities!.map((x) => x.toJson())),
        "CustomerEntersPrice": customerEntersPrice,
        "CustomerEnteredPrice": customerEnteredPrice,
        "CustomerEnteredPriceRange": customerEnteredPriceRange,
        "DisableBuyButton": disableBuyButton,
        "DisableWishlistButton": disableWishlistButton,
        "IsRental": isRental,
        "AvailableForPreOrder": availableForPreOrder,
        "PreOrderAvailabilityStartDateTimeUtc":
            preOrderAvailabilityStartDateTimeUtc,
        "PreOrderAvailabilityStartDateTimeUserTime":
            preOrderAvailabilityStartDateTimeUserTime,
        "UpdatedShoppingCartItemId": updatedShoppingCartItemId,
        "UpdateShoppingCartItemType": updateShoppingCartItemType,
        "CustomProperties": customProperties?.toJson(),
      };
}

class Breadcrumb {
  Breadcrumb({
    this.enabled,
    this.productId,
    this.productName,
    this.productSeName,
    this.categoryBreadcrumb,
    this.customProperties,
  });

  bool? enabled;
  num? productId;
  String? productName;
  String? productSeName;
  List<CategoryBreadcrumb>? categoryBreadcrumb;
  CustomProperties? customProperties;

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        enabled: json["Enabled"],
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        categoryBreadcrumb: json["CategoryBreadcrumb"] == null
            ? null
            : List<CategoryBreadcrumb>.from(json["CategoryBreadcrumb"]!
                .map((x) => CategoryBreadcrumb.fromJson(x))),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Enabled": enabled,
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "CategoryBreadcrumb": categoryBreadcrumb == null
            ? null
            : List<dynamic>.from(categoryBreadcrumb!.map((x) => x.toJson())),
        "CustomProperties": customProperties?.toJson(),
      };
}

class CategoryBreadcrumb {
  CategoryBreadcrumb({
    this.name,
    this.seName,
    this.numberOfProducts,
    this.includeInTopMenu,
    this.subCategories,
    this.haveSubCategories,
    this.route,
    this.id,
    this.customProperties,
  });

  String? name;
  String? seName;
  dynamic numberOfProducts;
  bool? includeInTopMenu;
  List<dynamic>? subCategories;
  bool? haveSubCategories;
  dynamic route;
  num? id;
  CustomProperties? customProperties;

  factory CategoryBreadcrumb.fromJson(Map<String, dynamic> json) =>
      CategoryBreadcrumb(
        name: json["Name"],
        seName: json["SeName"],
        numberOfProducts: json["NumberOfProducts"],
        includeInTopMenu: json["IncludeInTopMenu"],
        subCategories: json["SubCategories"] == null
            ? null
            : List<dynamic>.from(json["SubCategories"]!.map((x) => x)),
        haveSubCategories: json["HaveSubCategories"],
        route: json["Route"],
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "SeName": seName,
        "NumberOfProducts": numberOfProducts,
        "IncludeInTopMenu": includeInTopMenu,
        "SubCategories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories!.map((x) => x)),
        "HaveSubCategories": haveSubCategories,
        "Route": route,
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ProductPrice {
  ProductPrice({
    this.currencyCode,
    this.oldPrice,
    this.price,
    this.priceWithDiscount,
    this.priceValue,
    this.customerEntersPrice,
    this.callForPrice,
    this.productId,
    this.hidePrices,
    this.isRental,
    this.rentalPrice,
    this.displayTaxShippingInfo,
    this.basePricePAngV,
    this.customProperties,
  });

  String? currencyCode;
  String? oldPrice;
  String? price;
  String? priceWithDiscount;
  double? priceValue;
  bool? customerEntersPrice;
  bool? callForPrice;
  num? productId;
  bool? hidePrices;
  bool? isRental;
  String? rentalPrice;
  bool? displayTaxShippingInfo;
  String? basePricePAngV;
  CustomProperties? customProperties;

  factory ProductPrice.fromJson(Map<String, dynamic> json) => ProductPrice(
        currencyCode: json["CurrencyCode"],
        oldPrice: json["OldPrice"],
        price: json["Price"],
        priceWithDiscount: json["PriceWithDiscount"],
        priceValue: json["PriceValue"],
        customerEntersPrice: json["CustomerEntersPrice"],
        callForPrice: json["CallForPrice"],
        productId: json["ProductId"],
        hidePrices: json["HidePrices"],
        isRental: json["IsRental"],
        rentalPrice: json["RentalPrice"],
        displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
        basePricePAngV: json["BasePricePAngV"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "CurrencyCode": currencyCode,
        "OldPrice": oldPrice,
        "Price": price,
        "PriceWithDiscount": priceWithDiscount,
        "PriceValue": priceValue,
        "CustomerEntersPrice": customerEntersPrice,
        "CallForPrice": callForPrice,
        "ProductId": productId,
        "HidePrices": hidePrices,
        "IsRental": isRental,
        "RentalPrice": rentalPrice,
        "DisplayTaxShippingInfo": displayTaxShippingInfo,
        "BasePricePAngV": basePricePAngV,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ProductReviewOverview {
  ProductReviewOverview({
    this.productId,
    this.ratingSum,
    this.totalReviews,
    this.allowCustomerReviews,
    this.canAddNewReview,
    this.customProperties,
  });

  num? productId;
  num? ratingSum;
  num? totalReviews;
  bool? allowCustomerReviews;
  bool? canAddNewReview;
  CustomProperties? customProperties;

  factory ProductReviewOverview.fromJson(Map<String, dynamic> json) =>
      ProductReviewOverview(
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

class ProductSpecificationModel {
  ProductSpecificationModel({
    this.groups,
    this.customProperties,
  });

  List<Group>? groups;
  CustomProperties? customProperties;

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) =>
      ProductSpecificationModel(
        groups: json["Groups"] == null
            ? null
            : List<Group>.from(json["Groups"]!.map((x) => Group.fromJson(x))),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Groups": groups == null
            ? null
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "CustomProperties": customProperties?.toJson(),
      };
}

class Group {
  Group({
    this.name,
    this.attributes,
    this.id,
    this.customProperties,
  });

  String? name;
  List<SpecificationAttr>? attributes;
  num? id;
  CustomProperties? customProperties;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        name: json["Name"],
        attributes: json["Attributes"] == null
            ? null
            : List<SpecificationAttr>.from(
                json["Attributes"]!.map((x) => SpecificationAttr.fromJson(x))),
        id: json["Id"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class SpecificationAttr {
  SpecificationAttr({
    this.name,
    this.values,
    this.id,
  });

  String? name;
  List<SpecificationAttrValue>? values;
  int? id;

  factory SpecificationAttr.fromJson(Map<String, dynamic> json) =>
      SpecificationAttr(
        name: json["Name"],
        values: json["Values"] == null
            ? null
            : List<SpecificationAttrValue>.from(
                json["Values"]!.map((x) => SpecificationAttrValue.fromJson(x))),
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Values": values == null
            ? null
            : List<dynamic>.from(values!.map((x) => x.toJson())),
        "Id": id,
      };
}

class SpecificationAttrValue {
  SpecificationAttrValue({
    this.attributeTypeId,
    this.valueRaw,
    this.colorSquaresRgb,
    this.customProperties,
  });

  int? attributeTypeId;
  String? valueRaw;
  String? colorSquaresRgb;
  CustomProperties? customProperties;

  factory SpecificationAttrValue.fromJson(Map<String, dynamic> json) =>
      SpecificationAttrValue(
        attributeTypeId: json["AttributeTypeId"],
        valueRaw: json["ValueRaw"],
        colorSquaresRgb: json["ColorSquaresRgb"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "AttributeTypeId": attributeTypeId,
        "ValueRaw": valueRaw,
        "ColorSquaresRgb": colorSquaresRgb,
        "CustomProperties": customProperties?.toJson(),
      };
}

class TierPrice {
  TierPrice({
    this.price,
    this.quantity,
  });

  String? price;
  int? quantity;

  factory TierPrice.fromJson(Map<String, dynamic> json) => TierPrice(
        price: json["Price"],
        quantity: json["Quantity"],
      );

  Map<String, dynamic> toJson() => {
        "Price": price,
        "Quantity": quantity,
      };
}

class VendorModel {
  VendorModel({
    this.name,
    this.seName,
    this.productCount,
    this.id,
    this.customProperties,
  });

  String? name;
  String? seName;
  num? productCount;
  int? id;
  CustomProperties? customProperties;

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
        name: json["Name"],
        seName: json["SeName"],
        productCount: json["ProductCount"],
        id: json["Id"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "SeName": seName,
        "ProductCount": productCount,
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

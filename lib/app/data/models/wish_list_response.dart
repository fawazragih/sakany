import 'package:skeletonizer/skeletonizer.dart';

import 'available_option.dart';
import 'custom_properties.dart';
import 'picture_model.dart';

class WishListResponse {
  WishListResponse({
    this.data,
    this.message,
    this.errorList,
  });

  WishListData? data;
  String? message;
  List<String>? errorList;

  factory WishListResponse.fromJson(Map<String, dynamic> json) =>
      WishListResponse(
        data: json["Data"] == null ? null : WishListData.fromJson(json["Data"]),
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

class WishListData {
  WishListData({
    this.customerGuid,
    this.customerFullname,
    this.emailWishlistEnabled,
    this.showSku,
    this.showProductImages,
    this.isEditable,
    this.displayAddToCart,
    this.displayTaxShippingInfo,
    this.items,
    this.warnings,
    this.customProperties,
  });

  String? customerGuid;
  String? customerFullname;
  bool? emailWishlistEnabled;
  bool? showSku;
  bool? showProductImages;
  bool? isEditable;
  bool? displayAddToCart;
  bool? displayTaxShippingInfo;
  List<WishListItem>? items;
  List<String>? warnings;
  CustomProperties? customProperties;

  factory WishListData.fromJson(Map<String, dynamic> json) => WishListData(
        customerGuid: json["CustomerGuid"],
        customerFullname: json["CustomerFullname"],
        emailWishlistEnabled: json["EmailWishlistEnabled"],
        showSku: json["ShowSku"],
        showProductImages: json["ShowProductImages"],
        isEditable: json["IsEditable"],
        displayAddToCart: json["DisplayAddToCart"],
        displayTaxShippingInfo: json["DisplayTaxShippingInfo"],
        items: json["Items"] == null
            ? null
            : List<WishListItem>.from(
                json["Items"]!.map((x) => WishListItem.fromJson(x))),
        warnings: json["Warnings"] == null
            ? null
            : List<String>.from(json["Warnings"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "CustomerGuid": customerGuid,
        "CustomerFullname": customerFullname,
        "EmailWishlistEnabled": emailWishlistEnabled,
        "ShowSku": showSku,
        "ShowProductImages": showProductImages,
        "IsEditable": isEditable,
        "DisplayAddToCart": displayAddToCart,
        "DisplayTaxShippingInfo": displayTaxShippingInfo,
        "Items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "Warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "CustomProperties": customProperties?.toJson(),
      };
}

class WishListItem {
  WishListItem({
    this.sku,
    this.picture,
    this.productId,
    this.productName,
    this.productSeName,
    this.unitPrice,
    this.subTotal,
    this.discount,
    this.maximumDiscountedQty,
    this.quantity,
    this.allowedQuantities,
    this.attributeInfo,
    this.recurringInfo,
    this.rentalInfo,
    this.allowItemEditing,
    this.warnings,
    this.id,
    this.customProperties,
  });

  String? sku;
  PictureModel? picture;
  int? productId;
  String? productName;
  String? productSeName;
  String? unitPrice;
  String? subTotal;
  dynamic discount;
  dynamic maximumDiscountedQty;
  int? quantity;
  List<AvailableOption>? allowedQuantities;
  String? attributeInfo;
  dynamic recurringInfo;
  dynamic rentalInfo;
  bool? allowItemEditing;
  List<String>? warnings;
  int? id;
  CustomProperties? customProperties;

  factory WishListItem.fromJson(Map<String, dynamic> json) => WishListItem(
        sku: json["Sku"],
        picture: json["Picture"] == null
            ? null
            : PictureModel.fromJson(json["Picture"]),
        productId: json["ProductId"],
        productName: json["ProductName"],
        productSeName: json["ProductSeName"],
        unitPrice: json["UnitPrice"],
        subTotal: json["SubTotal"],
        discount: json["Discount"],
        maximumDiscountedQty: json["MaximumDiscountedQty"],
        quantity: json["Quantity"],
        allowedQuantities: json["AllowedQuantities"] == null
            ? null
            : List<AvailableOption>.from(json["AllowedQuantities"]!
                .map((x) => AvailableOption.fromJson(x))),
        attributeInfo: json["AttributeInfo"],
        recurringInfo: json["RecurringInfo"],
        rentalInfo: json["RentalInfo"],
        allowItemEditing: json["AllowItemEditing"],
        warnings: json["Warnings"] == null
            ? null
            : List<String>.from(json["Warnings"]!.map((x) => x)),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Sku": sku,
        "Picture": picture?.toJson(),
        "ProductId": productId,
        "ProductName": productName,
        "ProductSeName": productSeName,
        "UnitPrice": unitPrice,
        "SubTotal": subTotal,
        "Discount": discount,
        "MaximumDiscountedQty": maximumDiscountedQty,
        "Quantity": quantity,
        "AllowedQuantities": allowedQuantities == null
            ? null
            : List<AvailableOption>.from(allowedQuantities!.map((x) => x)),
        "AttributeInfo": attributeInfo,
        "RecurringInfo": recurringInfo,
        "RentalInfo": rentalInfo,
        "AllowItemEditing": allowItemEditing,
        "Warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };

  factory WishListItem.fake() => WishListItem(
        sku: "SKU123",
        picture: PictureModel(
          imageUrl: "https://via.placeholder.com/150",
          thumbImageUrl: "https://via.placeholder.com/50",
          fullSizeImageUrl: "https://via.placeholder.com/1500",
          title: "Product Name",
          alternateText: "Product Name",
        ),
        productId: 123,
        productName: BoneMock.words(5)  ,
        productSeName: "product-name",
        unitPrice: BoneMock.country,
        subTotal: BoneMock.words(2) ,
        discount: 0,
        maximumDiscountedQty: 0,
        quantity: 1,
        allowedQuantities: [
          AvailableOption(
            disabled: false,
            group: "Quantity",
            selected: true,
            text: "1",
            value: "1",
          ),
          AvailableOption(
            disabled: false,
            group: "Quantity",
            selected: false,
            text: "5",
            value: "5",
          ),
        ],
        attributeInfo: "Color: Red, Size: M",
        recurringInfo: null,
        rentalInfo: null,
        allowItemEditing: true,
        warnings: null,
        id: 1,
        customProperties: CustomProperties(
          customerBASAuthCode: "123456",
          orderPaymentInfoTempKey: "123456",
        ),
      );
}

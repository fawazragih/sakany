import 'package:sakani/app/data/models/picture_model.dart';

import 'catalog_products_model.dart';
import 'custom_properties.dart';

class AllVendorsResponse {
  AllVendorsResponse({
    this.data,
    this.message,
    this.errorList,
  });

  List<VendorDetails>? data;
  String? message;
  List<String>? errorList;

  factory AllVendorsResponse.fromJson(Map<String, dynamic> json) =>
      AllVendorsResponse(
        data: json["Data"] == null
            ? null
            : List<VendorDetails>.from(
                json["Data"]!.map((x) => VendorDetails.fromJson(x))),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<String>.from(json["ErrorList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class VendorDetails {
  VendorDetails({
    this.name,
    this.description,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.allowCustomersToContactVendors,
    this.pictureModel,
    this.catalogProductsModel,
    this.id,
    this.customProperties,
  });

  String? name;
  String? description;
  dynamic metaKeywords;
  String? metaDescription;
  String? metaTitle;
  String? seName;
  bool? allowCustomersToContactVendors;
  PictureModel? pictureModel;
  CatalogProductsModel? catalogProductsModel;
  int? id;
  CustomProperties? customProperties;

  factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
        name: json["Name"],
        description: json["Description"],
        metaKeywords: json["MetaKeywords"],
        metaDescription: json["MetaDescription"],
        metaTitle: json["MetaTitle"],
        seName: json["SeName"],
        allowCustomersToContactVendors: json["AllowCustomersToContactVendors"],
        pictureModel: json["PictureModel"] == null
            ? null
            : PictureModel.fromJson(json["PictureModel"]),
        catalogProductsModel: json["CatalogProductsModel"] == null
            ? null
            : CatalogProductsModel.fromJson(json["CatalogProductsModel"]),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory VendorDetails.fake() => VendorDetails(
        name: "Vendor Name",
        description: "Vendor Description",
        metaKeywords: "Vendor Meta Keywords",
        metaDescription: "Vendor Meta Description",
        metaTitle: "Vendor Meta Title",
        seName: "vendor-name",
        allowCustomersToContactVendors: true,
        pictureModel: PictureModel.fake(),
        catalogProductsModel: CatalogProductsModel.fake(),
        id: 1,

      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "MetaKeywords": metaKeywords,
        "MetaDescription": metaDescription,
        "MetaTitle": metaTitle,
        "SeName": seName,
        "AllowCustomersToContactVendors": allowCustomersToContactVendors,
        "PictureModel": pictureModel?.toJson(),
        "CatalogProductsModel": catalogProductsModel?.toJson(),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

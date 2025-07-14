import 'package:app_extensions/app_extensions.dart';

import '../catalog_products_model.dart';
import '../custom_properties.dart';
import '../picture_model.dart';
import '../product_summary.dart';

class ProductListResponse {
  ProductListResponse({
    this.data,
    this.message,
    this.errorList,
  });

  ProductListData? data;
  String? message;
  List<String>? errorList;

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      ProductListResponse(
        data: json["Data"] == null
            ? null
            : ProductListData.fromJson(json["Data"]),
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

class ProductListData {
  ProductListData({
    this.name,
    this.description,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.pictureModel,
    this.displayCategoryBreadcrumb,
    this.categoryBreadcrumb,
    this.subCategories,
    this.featuredProducts,
    this.catalogProductsModel,
    this.id,
    this.customProperties,
  });

  String? name;
  String? description;
  String? metaKeywords;
  String? metaDescription;
  String? metaTitle;
  String? seName;
  PictureModel? pictureModel;
  bool? displayCategoryBreadcrumb;
  List<ProductListData>? categoryBreadcrumb;
  List<SubCategory>? subCategories;
  List<ProductSummary>? featuredProducts;
  CatalogProductsModel? catalogProductsModel;
  num? id;
  CustomProperties? customProperties;

  bool get hasSubcategories => subCategories.isNotNullOrEmpty;

  factory ProductListData.fromJson(Map<String, dynamic> json) =>
      ProductListData(
        name: json["Name"],
        description: json["Description"],
        metaKeywords: json["MetaKeywords"],
        metaDescription: json["MetaDescription"],
        metaTitle: json["MetaTitle"],
        seName: json["SeName"],
        pictureModel: json["PictureModel"] == null
            ? null
            : PictureModel.fromJson(json["PictureModel"]),
        displayCategoryBreadcrumb: json["DisplayCategoryBreadcrumb"],
        categoryBreadcrumb: json["CategoryBreadcrumb"] == null
            ? null
            : List<ProductListData>.from(json["CategoryBreadcrumb"]!
                .map((x) => ProductListData.fromJson(x))),
        subCategories: json["SubCategories"] == null
            ? null
            : List<SubCategory>.from(
                json["SubCategories"]!.map((x) => SubCategory.fromJson(x))),
        featuredProducts: json["FeaturedProducts"] == null
            ? null
            : List<ProductSummary>.from(json["FeaturedProducts"]!
                .map((x) => ProductSummary.fromJson(x))),
        catalogProductsModel: json["CatalogProductsModel"] == null
            ? null
            : CatalogProductsModel.fromJson(json["CatalogProductsModel"]),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "MetaKeywords": metaKeywords,
        "MetaDescription": metaDescription,
        "MetaTitle": metaTitle,
        "SeName": seName,
        "PictureModel": pictureModel?.toJson(),
        "DisplayCategoryBreadcrumb": displayCategoryBreadcrumb,
        "CategoryBreadcrumb": categoryBreadcrumb == null
            ? null
            : List<dynamic>.from(categoryBreadcrumb!.map((x) => x.toJson())),
        "SubCategories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "FeaturedProducts": featuredProducts == null
            ? null
            : List<dynamic>.from(featuredProducts!.map((x) => x)),
        "CatalogProductsModel": catalogProductsModel?.toJson(),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

// class PriceRangeFilter {
//   PriceRangeFilter({
//     this.enabled,
//     this.selectedPriceRange,
//     this.availablePriceRange,
//     this.customProperties,
//   });
//
//   bool? enabled;
//   PriceRange? selectedPriceRange;
//   PriceRange? availablePriceRange;
//   CustomProperties? customProperties;
//
//   factory PriceRangeFilter.fromJson(Map<String, dynamic> json) => PriceRangeFilter(
//     enabled: json["Enabled"],
//     selectedPriceRange: json["SelectedPriceRange"] == null ? null : PriceRange.fromJson(json["SelectedPriceRange"]),
//     availablePriceRange: json["AvailablePriceRange"] == null ? null : PriceRange.fromJson(json["AvailablePriceRange"]),
//     customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Enabled": enabled,
//         "SelectedPriceRange":
//             selectedPriceRange?.toJson(),
//         "AvailablePriceRange":
//             availablePriceRange?.toJson(),
//         "CustomProperties":
//             customProperties?.toJson(),
//       };
// }
//
// class PriceRange {
//   PriceRange({
//     this.from,
//     this.to,
//     this.customProperties,
//   });
//
//   num? from;
//   num? to;
//   CustomProperties? customProperties;
//
//   factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
//         from: json["From"],
//         to: json["To"],
//         customProperties: CustomProperties.fromJson(json["CustomProperties"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "From": from,
//         "To": to,
//         "CustomProperties": customProperties?.toJson(),
//       };
// }

// class SpecificationFilter {
//   SpecificationFilter({
//     this.enabled,
//     this.attributes,
//     this.customProperties,
//   });
//
//   bool? enabled;
//   List<Attribute>? attributes;
//   CustomProperties? customProperties;
//
//   factory SpecificationFilter.fromJson(Map<String, dynamic> json) => SpecificationFilter(
//     enabled: json["Enabled"],
//         attributes: json["Attributes"] == null
//             ? null
//             : List<Attribute>.from(
//                 json["Attributes"]!.map((x) => Attribute.fromJson(x))),
//         customProperties: json["CustomProperties"] == null
//             ? null
//             : CustomProperties.fromJson(json["CustomProperties"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//     "Enabled": enabled,
//         "Attributes": attributes == null
//             ? null
//             : List<dynamic>.from(attributes!.map((x) => x.toJson())),
//         "CustomProperties":
//             customProperties?.toJson(),
//       };
// }

class SubCategory {
  SubCategory({
    this.name,
    this.seName,
    this.description,
    this.pictureModel,
    this.id,
    this.customProperties,
  });

  String? name;
  String? seName;
  String? description;
  PictureModel? pictureModel;
  int? id;
  CustomProperties? customProperties;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        name: json["Name"],
        seName: json["SeName"],
        description: json["Description"],
        pictureModel: json["PictureModel"] == null
            ? null
            : PictureModel.fromJson(json["PictureModel"]),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "SeName": seName,
        "Description": description,
        "PictureModel": pictureModel?.toJson(),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class Attribute {
  Attribute({
    this.name,
    this.values,
    this.id,
    this.customProperties,
  });

  String? name;
  List<AppValue>? values;
  int? id;
  CustomProperties? customProperties;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        name: json["Name"],
        values: json["Values"] == null
            ? null
            : List<AppValue>.from(json["Values"]!.map((x) => AppValue.fromJson(x))),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );
  factory Attribute.fake() => Attribute(
        name: "Size",
        values: [
          AppValue(name: "S"),
          AppValue(name: "M"),
          AppValue(name: "L"),
        ],
        id: 1,
        customProperties: CustomProperties(
          customerBASAuthCode: "123456789",
          orderPaymentInfoTempKey: "123456789",
        ),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Values": values == null
            ? null
            : List<dynamic>.from(values!.map((x) => x.toJson())),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class AppValue {
  AppValue({
    this.name,
    this.colorSquaresRgb,
    this.selected,
    this.id,
    this.customProperties,
  });

  String? name;
  dynamic colorSquaresRgb;
  bool? selected;
  int? id;
  CustomProperties? customProperties;

  factory AppValue.fromJson(Map<String, dynamic> json) => AppValue(
        name: json["Name"],
        colorSquaresRgb: json["ColorSquaresRgb"],
        selected: json["Selected"],
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "ColorSquaresRgb": colorSquaresRgb,
        "Selected": selected,
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

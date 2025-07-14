import '../catalog_products_model.dart';
import '../custom_properties.dart';
import '../picture_model.dart';

class ManufacturersResponse {
  ManufacturersResponse({
    this.data,
    this.message,
    this.errorList,
  });

  List<ManufacturerData>? data;
  String? message;
  List<String>? errorList;

  factory ManufacturersResponse.fromJson(Map<String, dynamic> json) =>
      ManufacturersResponse(
        data: json["Data"] == null
            ? null
            : List<ManufacturerData>.from(
                json["Data"]!.map((x) => ManufacturerData.fromJson(x))),
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

class ManufacturerData {
  ManufacturerData({
    this.name,
    this.description,
    this.metaKeywords,
    this.metaDescription,
    this.metaTitle,
    this.seName,
    this.pictureModel,
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
  List<dynamic>? featuredProducts;
  CatalogProductsModel? catalogProductsModel;
  int? id;
  CustomProperties? customProperties;

  factory ManufacturerData.fromJson(Map<String, dynamic> json) =>
      ManufacturerData(
        name: json["Name"],
        description: json["Description"],
        metaKeywords: json["MetaKeywords"],
        metaDescription: json["MetaDescription"],
        metaTitle: json["MetaTitle"],
        seName: json["SeName"],
        pictureModel: json["PictureModel"] == null
            ? null
            : PictureModel.fromJson(json["PictureModel"]),
        featuredProducts: json["FeaturedProducts"] == null
            ? null
            : List<dynamic>.from(json["FeaturedProducts"]!.map((x) => x)),
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
        "FeaturedProducts": featuredProducts == null
            ? null
            : List<dynamic>.from(featuredProducts!.map((x) => x)),
        "CatalogProductsModel": catalogProductsModel?.toJson(),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

// class CatalogProductsModel {
//   CatalogProductsModel({
//     this.useAjaxLoading,
//     this.warningMessage,
//     this.noResultMessage,
//     this.priceRangeFilter,
//     this.specificationFilter,
//     this.manufacturerFilter,
//     this.allowProductSorting,
//     this.availableSortOptions,
//     this.allowProductViewModeChanging,
//     this.availableViewModes,
//     this.allowCustomersToSelectPageSize,
//     this.pageSizeOptions,
//     this.orderBy,
//     this.viewMode,
//     this.products,
//     this.pageIndex,
//     this.pageNumber,
//     this.pageSize,
//     this.totalItems,
//     this.totalPages,
//     this.firstItem,
//     this.lastItem,
//     this.hasPreviousPage,
//     this.hasNextPage,
//     this.customProperties,
//   });
//
//   bool? useAjaxLoading;
//   dynamic warningMessage;
//   dynamic noResultMessage;
//   PriceRangeFilter? priceRangeFilter;
//   SpecificationFilter? specificationFilter;
//   ManufacturerFilter? manufacturerFilter;
//   bool? allowProductSorting;
//   List<dynamic>? availableSortOptions;
//   bool? allowProductViewModeChanging;
//   List<dynamic>? availableViewModes;
//   bool? allowCustomersToSelectPageSize;
//   List<dynamic>? pageSizeOptions;
//   dynamic orderBy;
//   dynamic viewMode;
//   List<dynamic>? products;
//   int? pageIndex;
//   int? pageNumber;
//   int? pageSize;
//   int? totalItems;
//   int? totalPages;
//   int? firstItem;
//   int? lastItem;
//   bool? hasPreviousPage;
//   bool? hasNextPage;
//   CustomProperties? customProperties;
//
//   factory CatalogProductsModel.fromJson(Map<String, dynamic> json) => CatalogProductsModel(
//     useAjaxLoading: json["UseAjaxLoading"],
//     warningMessage: json["WarningMessage"],
//     noResultMessage: json["NoResultMessage"],
//     priceRangeFilter: json["PriceRangeFilter"] == null ? null : PriceRangeFilter.fromJson(json["PriceRangeFilter"]),
//     specificationFilter: json["SpecificationFilter"] == null ? null : SpecificationFilter.fromJson(json["SpecificationFilter"]),
//     manufacturerFilter: json["ManufacturerFilter"] == null ? null : ManufacturerFilter.fromJson(json["ManufacturerFilter"]),
//     allowProductSorting: json["AllowProductSorting"],
//         availableSortOptions: json["AvailableSortOptions"] == null
//             ? null
//             : List<dynamic>.from(json["AvailableSortOptions"]!.map((x) => x)),
//         allowProductViewModeChanging:
//             json["AllowProductViewModeChanging"],
//         availableViewModes: json["AvailableViewModes"] == null
//             ? null
//             : List<dynamic>.from(json["AvailableViewModes"]!.map((x) => x)),
//         allowCustomersToSelectPageSize:
//             json["AllowCustomersToSelectPageSize"],
//         pageSizeOptions: json["PageSizeOptions"] == null
//             ? null
//             : List<dynamic>.from(json["PageSizeOptions"]!.map((x) => x)),
//         orderBy: json["OrderBy"],
//         viewMode: json["ViewMode"],
//         products: json["Products"] == null
//             ? null
//             : List<dynamic>.from(json["Products"]!.map((x) => x)),
//         pageIndex: json["PageIndex"],
//         pageNumber: json["PageNumber"],
//     pageSize: json["PageSize"],
//     totalItems: json["TotalItems"],
//     totalPages: json["TotalPages"],
//     firstItem: json["FirstItem"],
//     lastItem: json["LastItem"],
//     hasPreviousPage: json["HasPreviousPage"],
//     hasNextPage: json["HasNextPage"],
//     customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "UseAjaxLoading": useAjaxLoading,
//     "WarningMessage": warningMessage,
//     "NoResultMessage": noResultMessage,
//         "PriceRangeFilter":
//             priceRangeFilter?.toJson(),
//         "SpecificationFilter":
//             specificationFilter?.toJson(),
//         "ManufacturerFilter":
//             manufacturerFilter?.toJson(),
//         "AllowProductSorting":
//             allowProductSorting,
//         "AvailableSortOptions": availableSortOptions == null
//             ? null
//             : List<dynamic>.from(availableSortOptions!.map((x) => x)),
//         "AllowProductViewModeChanging": allowProductViewModeChanging,
//         "AvailableViewModes": availableViewModes == null
//             ? null
//             : List<dynamic>.from(availableViewModes!.map((x) => x)),
//         "AllowCustomersToSelectPageSize": allowCustomersToSelectPageSize,
//         "PageSizeOptions": pageSizeOptions == null
//             ? null
//             : List<dynamic>.from(pageSizeOptions!.map((x) => x)),
//         "OrderBy": orderBy,
//         "ViewMode": viewMode,
//         "Products": products == null
//             ? null
//             : List<dynamic>.from(products!.map((x) => x)),
//         "PageIndex": pageIndex,
//         "PageNumber": pageNumber,
//     "PageSize": pageSize,
//     "TotalItems": totalItems,
//     "TotalPages": totalPages,
//     "FirstItem": firstItem,
//     "LastItem": lastItem,
//     "HasPreviousPage": hasPreviousPage,
//     "HasNextPage": hasNextPage,
//         "CustomProperties":
//             customProperties?.toJson(),
//       };
// }

/*class ManufacturerFilter {
  ManufacturerFilter({
    this.enabled,
    this.manufacturers,
    this.customProperties,
  });

  bool? enabled;
  List<dynamic>? manufacturers;
  CustomProperties? customProperties;

  factory ManufacturerFilter.fromJson(Map<String, dynamic> json) => ManufacturerFilter(
    enabled: json["Enabled"],
        manufacturers: json["Manufacturers"] == null
            ? null
            : List<dynamic>.from(json["Manufacturers"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
    "Enabled": enabled,
        "Manufacturers": manufacturers == null
            ? null
            : List<dynamic>.from(manufacturers!.map((x) => x)),
        "CustomProperties":
            customProperties?.toJson(),
      };
}*/


import 'available_option.dart';
import 'catalog_products_model.dart';
import 'custom_properties.dart';

// class SearchResponse {
//   SearchResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   SearchData? data;
//   String? message;
//   List<String>? errorList;
//
//   SearchResponse copyWith({
//     SearchData? data,
//     String? message,
//     List<String>? errorList,
//   }) =>
//       SearchResponse(
//         data: data ?? this.data,
//         message: message ?? this.message,
//         errorList: errorList ?? this.errorList,
//       );
//
//   factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
//     data: json["Data"] == null ? null : SearchData.fromJson(json["Data"]),
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

class SearchData {
  SearchData({
    this.q,
    this.categoryId,
    this.searchInSubcategory,
    this.manufacturerId,
    this.vendorId,
    this.searchInDescription,
    this.advSearchSelected,
    this.allowVendorSearch,
    this.catalogProductsModel,
    this.availableCategories,
    this.availableManufacturers,
    this.availableVendors,
    this.customProperties,
  });

  String? q;
  int? categoryId;
  bool? searchInSubcategory;
  int? manufacturerId;
  int? vendorId;
  bool? searchInDescription;
  bool? advSearchSelected;
  bool? allowVendorSearch;
  CatalogProductsModel? catalogProductsModel;
  List<AvailableOption>? availableCategories;
  List<AvailableOption>? availableManufacturers;
  List<AvailableOption>? availableVendors;
  CustomProperties? customProperties;

  SearchData copyWith({
    String? q,
    int? cid,
    bool? isc,
    int? mid,
    int? vid,
    bool? sid,
    bool? advs,
    bool? asv,
    CatalogProductsModel? catalogProductsModel,
    List<AvailableOption>? availableCategories,
    List<AvailableOption>? availableManufacturers,
    List<AvailableOption>? availableVendors,
    CustomProperties? customProperties,
  }) =>
      SearchData(
        q: q ?? this.q,
        categoryId: cid ?? categoryId,
        searchInSubcategory: isc ?? searchInSubcategory,
        manufacturerId: mid ?? manufacturerId,
        vendorId: vid ?? vendorId,
        searchInDescription: sid ?? searchInDescription,
        advSearchSelected: advs ?? advSearchSelected,
        allowVendorSearch: asv ?? allowVendorSearch,
        catalogProductsModel: catalogProductsModel ?? this.catalogProductsModel,
        availableCategories: availableCategories ?? this.availableCategories,
        availableManufacturers: availableManufacturers ?? this.availableManufacturers,
        availableVendors: availableVendors ?? this.availableVendors,
        customProperties: customProperties ?? this.customProperties,
      );

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    q: json["q"],
    categoryId: json["cid"],
    searchInSubcategory: json["isc"],
    manufacturerId: json["mid"],
    vendorId: json["vid"],
    searchInDescription: json["sid"],
    advSearchSelected: json["advs"],
    allowVendorSearch: json["asv"],
    catalogProductsModel: json["CatalogProductsModel"] == null ? null : CatalogProductsModel.fromJson(json["CatalogProductsModel"]),
        availableCategories: json["AvailableCategories"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableCategories"]!.map((x) => AvailableOption.fromJson(x))),
        availableManufacturers: json["AvailableManufacturers"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableManufacturers"]!.map((x) => AvailableOption.fromJson(x))),
        availableVendors: json["AvailableVendors"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableVendors"]!.map((x) => AvailableOption.fromJson(x))),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
    "q": q,
    "cid": categoryId,
    "isc": searchInSubcategory,
    "mid": manufacturerId,
    "vid": vendorId,
    "sid": searchInDescription,
    "advs": advSearchSelected,
    "asv": allowVendorSearch,
        "CatalogProductsModel": catalogProductsModel?.toJson(),
        "AvailableCategories": availableCategories == null
            ? null
            : List<dynamic>.from(availableCategories!.map((x) => x.toJson())),
        "AvailableManufacturers": availableManufacturers == null
            ? null
            : List<dynamic>.from(
                availableManufacturers!.map((x) => x.toJson())),
        "AvailableVendors": availableVendors == null
            ? null
            : List<dynamic>.from(availableVendors!.map((x) => x)),
        "CustomProperties":
            customProperties?.toJson(),
      };
}


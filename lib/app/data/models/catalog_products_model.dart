import 'package:app_extensions/app_extensions.dart';
import 'custom_properties.dart';
import 'manufacturer_filter.dart';
import 'price_range_filter.dart';
import 'product_list/product_list_response.dart';
import 'product_summary.dart';

class CatalogProductsModel {
  CatalogProductsModel({
    this.useAjaxLoading,
    this.warningMessage,
    this.noResultMessage,
    this.priceRangeFilter,
    this.specificationFilter,
    this.manufacturerFilter,
    this.allowProductSorting,
    this.availableSortOptions,
    this.allowProductViewModeChanging,
    this.availableViewModes,
    this.allowCustomersToSelectPageSize,
    this.pageSizeOptions,
    this.orderBy,
    this.viewMode,
    this.products,
    this.pageIndex,
    this.pageNumber,
    this.pageSize,
    this.totalItems,
    this.totalPages,
    this.firstItem,
    this.lastItem,
    this.hasPreviousPage,
    this.hasNextPage,
    this.customProperties,
  });

  bool? useAjaxLoading;
  String? warningMessage;
  String? noResultMessage;
  PriceRangeFilter? priceRangeFilter;
  SpecificationFilter? specificationFilter;
  ManufacturerFilter? manufacturerFilter;
  bool? allowProductSorting;
  List<AvailableSortOption>? availableSortOptions;
  bool? allowProductViewModeChanging;
  List<AvailableSortOption>? availableViewModes;
  bool? allowCustomersToSelectPageSize;
  List<AvailableSortOption>? pageSizeOptions;
  dynamic orderBy;
  String? viewMode;
  List<ProductSummary>? products;
  int? pageIndex;
  int? pageNumber;
  int? pageSize;
  int? totalItems;
  int? totalPages;
  int? firstItem;
  int? lastItem;
  bool? hasPreviousPage;
  bool? hasNextPage;
  CustomProperties? customProperties;

  bool get hasFilterOption {
    bool specificationFilterEnabled = specificationFilter?.enabled == true &&
        specificationFilter?.attributes.isNotNullOrEmpty == true;

    bool manufacturerFilterEnabled = manufacturerFilter?.enabled == true &&
        manufacturerFilter?.manufacturers?.isNotNullOrEmpty == true;

    bool priceRangeFilterEnabled = priceRangeFilter?.enabled == true;
    bool productsIsNotNullOrEmpty = products.isNotNullOrEmpty == true;

    return (specificationFilterEnabled ||
            manufacturerFilterEnabled ||
            priceRangeFilterEnabled) &&
        productsIsNotNullOrEmpty;
  }

  bool get hasSortOption {
    return allowProductSorting == true && products?.isNotNullOrEmpty == true;
  }

  factory CatalogProductsModel.fromJson(Map<String, dynamic> json) =>
      CatalogProductsModel(
        useAjaxLoading: json["UseAjaxLoading"],
        warningMessage: json["WarningMessage"],
        noResultMessage: json["NoResultMessage"],
        priceRangeFilter: json["PriceRangeFilter"] == null
            ? null
            : PriceRangeFilter.fromJson(json["PriceRangeFilter"]),
        specificationFilter: json["SpecificationFilter"] == null
            ? null
            : SpecificationFilter.fromJson(json["SpecificationFilter"]),
        manufacturerFilter: json["ManufacturerFilter"] == null
            ? null
            : ManufacturerFilter.fromJson(json["ManufacturerFilter"]),
        allowProductSorting: json["AllowProductSorting"],
        availableSortOptions: json["AvailableSortOptions"] == null
            ? null
            : List<AvailableSortOption>.from(json["AvailableSortOptions"]!
                .map((x) => AvailableSortOption.fromJson(x))),
        allowProductViewModeChanging: json["AllowProductViewModeChanging"],
        availableViewModes: json["AvailableViewModes"] == null
            ? null
            : List<AvailableSortOption>.from(json["AvailableViewModes"]!
                .map((x) => AvailableSortOption.fromJson(x))),
        allowCustomersToSelectPageSize: json["AllowCustomersToSelectPageSize"],
        pageSizeOptions: json["PageSizeOptions"] == null
            ? null
            : List<AvailableSortOption>.from(json["PageSizeOptions"]!
                .map((x) => AvailableSortOption.fromJson(x))),
        orderBy: json["OrderBy"],
        viewMode: json["ViewMode"],
        products: json["Products"] == null
            ? null
            : List<ProductSummary>.from(
                json["Products"]!.map((x) => ProductSummary.fromJson(x))),
        pageIndex: json["PageIndex"],
        pageNumber: json["PageNumber"],
        pageSize: json["PageSize"],
        totalItems: json["TotalItems"],
        totalPages: json["TotalPages"],
        firstItem: json["FirstItem"],
        lastItem: json["LastItem"],
        hasPreviousPage: json["HasPreviousPage"],
        hasNextPage: json["HasNextPage"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory CatalogProductsModel.fake() => CatalogProductsModel(
        useAjaxLoading: false,
        warningMessage: "No products found",
        noResultMessage: "No products found",
        priceRangeFilter: PriceRangeFilter.fake(),
        specificationFilter: SpecificationFilter.fake(),
        manufacturerFilter: ManufacturerFilter.fake(),
        allowProductSorting: true,
        availableSortOptions: [AvailableSortOption.fake()],
        allowProductViewModeChanging: true,
        availableViewModes: [AvailableSortOption.fake()],
        allowCustomersToSelectPageSize: true,
        pageSizeOptions: [AvailableSortOption.fake()],
        orderBy: "name",
        viewMode: "grid",
        products: [ProductSummary.fake()],
        pageIndex: 0,
        pageNumber: 1,
        pageSize: 10,
        totalItems: 1,
        totalPages: 1,
        firstItem: 1,
        lastItem: 1,
        hasPreviousPage: false,
        hasNextPage: false,
        customProperties: CustomProperties.fake(),
      );

  Map<String, dynamic> toJson() => {
        "UseAjaxLoading": useAjaxLoading,
        "WarningMessage": warningMessage,
        "NoResultMessage": noResultMessage,
        "PriceRangeFilter": priceRangeFilter?.toJson(),
        "SpecificationFilter": specificationFilter?.toJson(),
        "ManufacturerFilter": manufacturerFilter?.toJson(),
        "AllowProductSorting": allowProductSorting,
        "AvailableSortOptions": availableSortOptions == null
            ? null
            : List<dynamic>.from(availableSortOptions!.map((x) => x.toJson())),
        "AllowProductViewModeChanging": allowProductViewModeChanging,
        "AvailableViewModes": availableViewModes == null
            ? null
            : List<dynamic>.from(availableViewModes!.map((x) => x.toJson())),
        "AllowCustomersToSelectPageSize": allowCustomersToSelectPageSize,
        "PageSizeOptions": pageSizeOptions == null
            ? null
            : List<dynamic>.from(pageSizeOptions!.map((x) => x.toJson())),
        "OrderBy": orderBy,
        "ViewMode": viewMode,
        "Products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "PageIndex": pageIndex,
        "PageNumber": pageNumber,
        "PageSize": pageSize,
        "TotalItems": totalItems,
        "TotalPages": totalPages,
        "FirstItem": firstItem,
        "LastItem": lastItem,
        "HasPreviousPage": hasPreviousPage,
        "HasNextPage": hasNextPage,
        "CustomProperties": customProperties?.toJson(),
      };
}

class SpecificationFilter {
  SpecificationFilter({
    this.enabled,
    this.attributes,
    this.customProperties,
  });

  bool? enabled;
  List<Attribute>? attributes;
  CustomProperties? customProperties;

  factory SpecificationFilter.fromJson(Map<String, dynamic> json) =>
      SpecificationFilter(
        enabled: json["Enabled"],
        attributes: json["Attributes"] == null
            ? null
            : List<Attribute>.from(
                json["Attributes"]!.map((x) => Attribute.fromJson(x))),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory SpecificationFilter.fake() => SpecificationFilter(
        enabled: true,
        attributes: [Attribute.fake()],
        // customProperties: CustomProperties.fake(),
      );

  Map<String, dynamic> toJson() => {
        "Enabled": enabled,
        "Attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "CustomProperties": customProperties?.toJson(),
      };
}

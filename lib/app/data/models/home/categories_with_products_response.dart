
import 'package:tamoily/app/data/models/product_summary.dart';

import '../custom_properties.dart';


class CategoriesWithProducts {
  CategoriesWithProducts({
    this.name,
    this.seName,
    this.subCategories,
    this.products,
    this.id,
    this.customProperties,
  });

  String? name;
  String? seName;
  List<CategoriesWithProducts>? subCategories;
  List<ProductSummary>? products;
  int? id;
  CustomProperties? customProperties;

  factory CategoriesWithProducts.fromJson(Map<String, dynamic> json) => CategoriesWithProducts(
    name: json["Name"],
    seName: json["SeName"],
        subCategories: json["SubCategories"] == null
            ? null
            : List<CategoriesWithProducts>.from(json["SubCategories"]!
                .map((x) => CategoriesWithProducts.fromJson(x))),
        products: json["Products"] == null
            ? null
            : List<ProductSummary>.from(
                json["Products"]!.map((x) => ProductSummary.fromJson(x))),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "SeName": seName,
        "SubCategories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "Products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "Id": id,
        "CustomProperties":
            customProperties?.toJson(),
      };
}

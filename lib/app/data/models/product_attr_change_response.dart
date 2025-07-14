// class ProductAttrChangeResponse {
//   ProductAttrChangeResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   ProductAttrChangeData? data;
//   String? message;
//   List<String>? errorList;
//
//   factory ProductAttrChangeResponse.fromJson(Map<String, dynamic> json) => ProductAttrChangeResponse(
//     data: json["Data"] == null ? null : ProductAttrChangeData.fromJson(json["Data"]),
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

class ProductAttrChangeData {
  ProductAttrChangeData({
    this.gtin,
    this.mpn,
    this.sku,
    this.price,
    this.basePricePangv,
    this.stockAvailability,
    this.enabledAttributeMappingIds,
    this.disabledAttributeMappingIds,
    this.pictureFullSizeUrl,
    this.pictureDefaultSizeUrl,
    this.isFreeShipping,
  });

  String? gtin;
  String? mpn;
  String? sku;
  String? price;
  String? basePricePangv;
  String? stockAvailability;
  List<int>? enabledAttributeMappingIds;
  List<int>? disabledAttributeMappingIds;
  String? pictureFullSizeUrl;
  String? pictureDefaultSizeUrl;
  bool? isFreeShipping;

  factory ProductAttrChangeData.fromJson(Map<String, dynamic> json) =>
      ProductAttrChangeData(
        gtin: json["Gtin"],
        mpn: json["Mpn"],
        sku: json["Sku"],
        price: json["Price"],
        basePricePangv: json["BasePricePangv"],
        stockAvailability: json["StockAvailability"],
        enabledAttributeMappingIds:
            json["enabled_attribute_mapping_ids"] == null
                ? null
                : List<int>.from(
                    json["enabled_attribute_mapping_ids"]!.map((x) => x)),
        disabledAttributeMappingIds:
            json["disabled_attribute_mapping_ids"] == null
                ? null
                : List<int>.from(
                    json["disabled_attribute_mapping_ids"]!.map((x) => x)),
        pictureFullSizeUrl: json["PictureFullSizeUrl"],
        pictureDefaultSizeUrl: json["PictureDefaultSizeUrl"],
        isFreeShipping: json["IsFreeShipping"],
      );

  Map<String, dynamic> toJson() => {
        "Gtin": gtin,
        "Mpn": mpn,
        "Sku": sku,
        "Price": price,
        "BasePricePangv": basePricePangv,
        "StockAvailability": stockAvailability,
        "enabled_attribute_mapping_ids": enabledAttributeMappingIds == null
            ? null
            : List<num>.from(enabledAttributeMappingIds!.map((x) => x)),
        "disabled_attribute_mapping_ids": disabledAttributeMappingIds == null
            ? null
            : List<num>.from(disabledAttributeMappingIds!.map((x) => x)),
        "PictureFullSizeUrl": pictureFullSizeUrl,
        "PictureDefaultSizeUrl": pictureDefaultSizeUrl,
        "IsFreeShipping": isFreeShipping,
      };
}

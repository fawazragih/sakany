
class CategoryTreeResponseData {
  CategoryTreeResponseData({
    this.categoryId,
    this.seName,
    this.name,
    this.iconUrl,
    this.subCategories,
  });

  int? categoryId;
  String? seName;
  String? name;
  String? iconUrl;
  List<CategoryTreeResponseData>? subCategories;
  bool? isExpanded = false;

  factory CategoryTreeResponseData.fromJson(Map<String, dynamic> json) =>
      CategoryTreeResponseData(
        categoryId: json["CategoryId"],
        seName: json["SeName"],
        name: json["Name"],
        iconUrl: json["IconUrl"],
        subCategories: List<CategoryTreeResponseData>.from(json["SubCategories"]!
                .map((x) => CategoryTreeResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CategoryId": categoryId,
        "SeName": seName,
        "Name": name,
        "IconUrl": iconUrl,
        "SubCategories":
            List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class ApiFilter {
  String? search;
  int? categoryId;
  String? orderBy;
  String? price;
  String? specs;
  String? ms;

  ApiFilter({
    this.search,
    this.categoryId,
    this.orderBy,
    this.price,
    this.specs,
    this.ms,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderby': orderBy,
      'price': price,
      'specs': specs,
      'ms': ms,
      'q': search,
    }..removeWhere((key, value) => value == null);
  }

// factory ApiFilter.fromJson(Map<String, dynamic> map) {
//   return ApiFilter(
//     brandId: map['brand'],
//     categoriesId: map['categories'],
//   );
// }
}

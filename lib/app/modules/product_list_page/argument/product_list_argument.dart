import 'package:app_extensions/app_extensions.dart';
import 'package:collection/collection.dart';

enum GetProductListBy {
  CATEGORY('categoryTree'),
  MANUFACTURER('manufacturer'),
  VENDOR('vendor'),
  TAG('tag');

  final String value;

  const GetProductListBy(this.value);
}

class ProductListScreenArguments {
  GetProductListBy? type;
  String? name;
  int? id;

  ProductListScreenArguments({
    this.type,
    this.name,
    this.id,
  });

  Map<String, String> toJson() {
    return {
      'type': type?.value ?? '',
      'name': name ??'',
      'id': id?.toString() ??'',
    }..removeWhere((k,v)=>v.isNullOrEmpty);
  }

  factory ProductListScreenArguments.fromJson(Map<String, dynamic> map) {
    return ProductListScreenArguments(
      type: GetProductListBy.values.firstWhereOrNull(
          (e) => e.value.toLowerCase() == map['type'].toString().toLowerCase()),
      name: map['name'],
      id: int.tryParse(map['id']?.toString() ?? ''),
    );
  }
}
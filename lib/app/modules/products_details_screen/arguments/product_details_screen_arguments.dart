import 'dart:convert';

import 'package:app_extensions/app_extensions.dart';
import 'package:tamoily/app/utils/type_conversion.dart';

import '../../../data/models/product_details_response.dart';

class ProductDetailsScreenArguments {
  String? name;
  int? id;
  ProductDetails? productDetails;
  bool? updateCart;
  int? updateCartItemId;

  ProductDetailsScreenArguments({
    required this.id,
    required this.name,
    this.productDetails,
    this.updateCart,
    this.updateCartItemId,
  });

  factory ProductDetailsScreenArguments.fromJson(Map<String, dynamic> map) {
    return ProductDetailsScreenArguments(
      name: map['name'],
      id: int.tryParse(map['id'].toString()),
      productDetails: map['productDetails'] == null
          ? null
          : ProductDetails.fromJson(jsonDecode(map['productDetails'])),
      updateCart: map['updateCart']?.toString().valueTypeToBool,
      updateCartItemId: map['updateCartItemId']?.toString().valueTypeToInt,
    );
  }

  Map<String, String> toJson() {
    return {
      'name': name ?? '',
      'id': id?.toString() ?? '',
      'productDetails':
          productDetails == null ? '' : jsonEncode(productDetails?.toJson()),
      'updateCart': updateCart?.toString() ?? '',
      'updateCartItemId': updateCartItemId?.toString() ?? '',
    }..removeWhere((e, v) => v.isNullOrEmpty);
  }
}

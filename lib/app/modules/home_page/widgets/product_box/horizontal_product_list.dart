import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani/app/data/models/home/categories_with_products_response.dart';
import '../../../../data/models/product_summary.dart';
import '../product_box/product_box_header.dart';
import 'horizontal_product_template.dart';

class HorizontalProductList extends StatelessWidget {
  final String title;
  final int? categoryId;
  final bool showSeeAllBtn;
  final bool showSubcategories;
  final List<CategoriesWithProducts>? subcategories;

  final List<ProductSummary>? productList;

  const HorizontalProductList({
    super.key,
    required this.title,
    required this.showSeeAllBtn,
    required this.showSubcategories,
    this.subcategories,
    this.productList,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    // context.width;
    // context.statusBarHeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (subcategories != null)
          ProductBoxHeader(
            title: title,
            showSeeAllBtn: showSeeAllBtn,
            showSubcategories: showSubcategories,
            subcategories: subcategories!,
            categoryId: categoryId,
          ),
        if (productList != null)
          SizedBox(
            height: kIsWeb ? 260.h : 260.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: productList?.length,
              itemBuilder: (BuildContext context, int index) {
                return HorizontalProductTemplate(productList![index]);
              },
            ),
          ),
      ],
    );
  }
}

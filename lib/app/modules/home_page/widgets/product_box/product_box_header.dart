import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/home/categories_with_products_response.dart';
import 'package:sakani/app/global_widget/list_title_and_view_all_row.dart';
import 'package:sakani/app/modules/product_list_page/argument/product_list_argument.dart';
import 'package:sakani/app/modules/product_list_page/product_list_view.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import '../../../all_manufacturers_page/all_manufacturers_view.dart';
import '../../../all_manufacturers_page/arguments/all_manufacturers_screen_args.dart';
import 'scrollview_with_scrollbar.dart';

class ProductBoxHeader extends StatelessWidget {
  final String title;
  final int? categoryId;
  final bool showSeeAllBtn;
  final bool showSubcategories;
  final List<CategoriesWithProducts> subcategories;
  final bool  itIsManufacturerList;

  const ProductBoxHeader({
    super.key,
    required this.title,
    required this.showSeeAllBtn,
    required this.showSubcategories,
    required this.subcategories,
    this.categoryId,
    this.itIsManufacturerList = false,
  });

  void openSubcategoriesActionSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ScrollViewWithScrollBar(
            child: Wrap(
              children: [
                for (var index = 0; index < subcategories.length; index++)
                  ListTile(
                    onTap: () {
                      if (subcategories[index].id != null) {
                        Get.toNamed(
                          ProductListPage.navTo(
                              subcategories[index].id!.toString()),
                          parameters: ProductListScreenArguments(
                            id: subcategories[index].id,
                            name: subcategories[index].name,
                            type: GetProductListBy.CATEGORY,
                          ).toJson(),
                        );
                      }
                    },
                    title: Text(
                      subcategories[index].name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    var showOverflow = showSubcategories == true && subcategories.isNotEmpty;
    // logger.d(itIsManufacturerList);

    return ListTitleAndViewAllRow(
      title: title.toUpperCase(),
      onViewAll: !showSeeAllBtn
          ? null
          : () {
              if (itIsManufacturerList) {
                Get.toNamed(
                  AllManufacturersPage.routeName,
                  arguments: AllManufacturersScreenArgs(title: title),
                );
              } else {
                if (categoryId != null) {
                  Get.toNamed(
                    ProductListPage.navTo(categoryId.toString()),
                    parameters: ProductListScreenArguments(
                      id: categoryId?.toInt(),
                      name: title,
                      type: GetProductListBy.CATEGORY,
                    ).toJson(),
                  );
                }
              }
            },
      viewAllText: ConstStrings.COMMON_SEE_ALL.translate,
      showOverflow: showOverflow,
      onOverflowTap: () {
        openSubcategoriesActionSheet(context);
      },
    );
  }
}

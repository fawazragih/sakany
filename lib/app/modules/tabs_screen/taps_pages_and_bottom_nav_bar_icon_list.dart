import 'package:flutter/material.dart';
import 'package:sakani/app/modules/all_categories_page/categories_view.dart';
import 'package:sakani/app/modules/home_page/home_view.dart';
import 'package:sakani/app/modules/search_page/search_view.dart';
import 'package:sakani/app/modules/user_profile_screen/user_profile_screen.dart';
import '../account_screen/account_view.dart';


class TapsPagesAndBottomNavBarIconList {
  TapsPagesAndBottomNavBarIconList._();

  static final List<Widget> widgetList = [
    const HomePage(), //0
    const SizedBox(), //1
    const SizedBox(), //2
    const SizedBox(), //3
    const SizedBox(), //4
    // const SizedBox(), //5
  ];

  static changePageAtIndex(index) {
    if (widgetList[index] is SizedBox) {
      switch (index) {
        case 0:
          return widgetList[index] = placeHolder(index);
        case 1:
          return widgetList[index] = const AllCategoriesPage();
        case 2:
          return widgetList[index] = const SearchPage();
        case 3:
          return widgetList[index] = const AccountPage();

        case 4:
          return widgetList[index] = const UserProfilePage();
      }
    }
  }

  static Center placeHolder(int index) {
    return Center(
      child: Text(
        index.toString(),
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}

class AppBottomNavTabModel {
  final String name;
  final IconData selectedIconData;
  final IconData unelectedIconData;
  final bool inPhone;

  const AppBottomNavTabModel({
    required this.name,
    required this.selectedIconData,
    required this.unelectedIconData,
    this.inPhone = true,
  });
}

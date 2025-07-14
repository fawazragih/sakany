// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
//
// import '../../../global_widget/app_ui_helper/shared_style.dart';
// import '../taps_pages_and_bottom_nav_bar_icon_list.dart';
//
// class BottomNavBar extends StatelessWidget {
//   final ValueChanged<int> onChange;
//   final int selectedIndex;
//
//   const BottomNavBar({
//     Key? key,
//     required this.onChange,
//     required this.selectedIndex,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: context.isPhone
//           ? Card(
//               elevation: 0,
//               clipBehavior: Clip.antiAlias,
//               color: Theme.of(context).primaryColor,
//               margin: EdgeInsets.symmetric(
//                 vertical: 8.0.h,
//                 horizontal: 8.0.w,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(50.0),
//               ),
//               child: GNav(
//                 backgroundColor: Colors.transparent,
//                 style: GnavStyle.google,
//                 textStyle: Get.textTheme.titleMedium?.copyWith(
//                   color: Get.theme.primaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 rippleColor: Colors.grey.shade800,
//                 hoverColor: Colors.grey.shade700,
//                 tabBorderRadius: 50,
//                 haptic: true,
//                 selectedIndex: selectedIndex,
//                 curve: Curves.easeOutExpo,
//                 duration: const Duration(milliseconds: 500),
//                 iconSize: 20.sp,
//                 color: Get.theme.primaryColorDark,
//                 // Theme.of(context).colorScheme.secondary.withOpacity(0.5),
//                 ///active text and icon color
//                 activeColor: Get.theme.primaryColor,
//
//                 ///active background color
//                 tabBackgroundColor: Get.theme.colorScheme.primary,
//                 padding: EdgeInsets.zero,
//                 tabs: TapsPagesAndBottomNavBarIconList.inPhoneTabs
//                     .asMap()
//                     .entries
//                     .map((entry) {
//                   int index = entry.key;
//                   return GButton(
//                     gap: 12,
//                     padding: entry.key == 2
//                         ? const EdgeInsets.all(
//                             16,
//                           )
//                         : EdgeInsets.symmetric(
//                             horizontal: 12.w,
//                             vertical: 16.w,
//                           ),
//                     icon: selectedIndex == index
//                         ? entry.value.selectedIconData
//                         : entry.value.unelectedIconData,
//                     text: entry.value.name.tr.capitalizeFirst!,
//                   );
//                 }).toList(),
//                 onTabChange: onChange,
//               ).paddingSymmetric(
//                 horizontal: 8.0.w,
//                 vertical: 8.0.h,
//               ),
//             )
//           : Container(
//               margin: SharedStyle.singleChildScrollViewHorizontalPadding,
//               clipBehavior: Clip.antiAlias,
//               padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w, top: 10.h),
//               decoration: BoxDecoration(
//                 color: Get.theme.primaryColor,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Get.theme.primaryColorLight,
//                       offset: const Offset(0, -1),
//                       blurRadius: 0.5),
//                   BoxShadow(
//                       color: Get.theme.primaryColorLight,
//                       offset: const Offset(1, 0),
//                       blurRadius: 0.5),
//                   BoxShadow(
//                       color: Get.theme.primaryColorLight,
//                       offset: const Offset(-1, 0),
//                       blurRadius: 0.5)
//                 ],
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30.r),
//                     topRight: Radius.circular(30.r)),
//               ),
//               child: BottomNavigationBar(
//                 currentIndex: selectedIndex,
//                 elevation: 0,
//                 onTap: onChange,
//                 selectedItemColor: Get.theme.iconTheme.color,
//                 unselectedItemColor: Get.theme.disabledColor,
//                 showUnselectedLabels: true,
//                 type: BottomNavigationBarType.fixed,
//                 landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
//                 items: TapsPagesAndBottomNavBarIconList.inTabletTabs
//                     .asMap()
//                     .entries
//                     .map((entry) {
//                   int index = entry.key;
//                   return BottomNavigationBarItem(
//                     label: entry.value.name.tr.capitalizeFirst!,
//                     icon: Icon(
//                       selectedIndex == index
//                           ? entry.value.selectedIconData
//                           : entry.value.unelectedIconData,
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//     );
//   }
// }
//
// class MyBottomNavBarPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     Path path = Path();
//
//     // Path number 1
//
//     paint.color = const Color(0xff0D6EFD);
//     path = Path();
//     path.lineTo(size.width * 0.32, size.height * 0.19);
//     path.cubicTo(size.width * 0.18, size.height / 5, size.width * 0.05,
//         size.height * 0.07, 0, 0);
//     path.cubicTo(0, 0, 0, size.height, 0, size.height);
//     path.cubicTo(
//         0, size.height, size.width, size.height, size.width, size.height);
//     path.cubicTo(size.width, size.height, size.width, 0, size.width, 0);
//     path.cubicTo(size.width * 0.93, size.height * 0.18, size.width * 0.74,
//         size.height * 0.19, size.width * 0.68, size.height * 0.19);
//     path.cubicTo(size.width * 0.62, size.height * 0.19, size.width * 0.61,
//         size.height * 0.22, size.width * 0.61, size.height * 0.3);
//     path.cubicTo(size.width * 0.61, size.height * 0.38, size.width * 0.63,
//         size.height * 0.6, size.width * 0.55, size.height * 0.63);
//     path.cubicTo(size.width * 0.42, size.height * 0.69, size.width * 0.39,
//         size.height * 0.52, size.width * 0.39, size.height * 0.42);
//     path.cubicTo(size.width * 0.38, size.height * 0.3, size.width * 0.39,
//         size.height * 0.19, size.width * 0.32, size.height * 0.19);
//     path.cubicTo(size.width * 0.32, size.height * 0.19, size.width * 0.32,
//         size.height * 0.19, size.width * 0.32, size.height * 0.19);
//     canvas.drawShadow(path, Colors.black, 100, true);
//     // canvas.drawShadow(paint);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

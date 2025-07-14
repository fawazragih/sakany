import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/base_controllers_and_listeners/helpers_methods.dart';
import 'package:sakani/app/data/models/user_login_response.dart';
import 'package:sakani/app/modules/about_app_page/about_app_view.dart';
import 'package:sakani/app/modules/all_cart_modules/shopping_cart_page/shopping_cart_view.dart';
import 'package:sakani/app/modules/all_cart_modules/widgets/cart_icon_button.dart';
import '../../base_controllers_and_listeners/user_auth_controller.dart';
import '../../core/assets_helpers/app_images.dart';
import '../app_ui_helper/shared_style.dart';
import '../app_ui_helper/ui_helpers.dart';
import 'app_back_button.dart';
import 'title_text_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleTextWidget;
  final String logoPath;
  final List<Widget>? actions;
  final double fontSize;
  final bool automaticallyImplyLeading;
  final Color? color;
  final Color? forgroundColor;
  final bool translateTitle;
  final bool? centerTitle;

  // final bool addHorizontalPadding;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final double? elevation;
  final bool stopShowDefaultAction;

  //region show icons
  // final bool showNotificationIcon;
  final bool showCartIcon;

  // final bool showUserIcon;
  // final bool showLogoutIcon;
  // final bool showSettingIcon;
  // final bool showNotification;
  // final bool? showLogo;
  //endregion

  @override
  final Size preferredSize;

  CustomAppBar({
    super.key,
    this.title,
    this.titleTextWidget,
    this.actions,
    this.fontSize = 16,
    this.automaticallyImplyLeading = true,
    this.color,
    this.forgroundColor,
    this.logoPath = AppImages.logoPng,
    this.bottom,
    this.leading,
    this.centerTitle,
    this.elevation,
    this.translateTitle = false,
    //region show icons
    this.stopShowDefaultAction = false,
    // this.showNotificationIcon = false,
    this.showCartIcon = true,
    // this.showNotification = true,
    // this.showLogo = false,// this.showUser = true,
    // this.user,
    // this.showLogoutIcon = false,
    // this.showUserIcon = true,
    // this.addHorizontalPadding = true,
    //endregion
  }) : preferredSize = preferredSizeGetter;

  static Size get preferredSizeGetter =>
      Size.fromHeight(HelpersMethods.appBarSize.height + 8);

  CustomerInfo? get currentUser => Get.find<UserAuthController>().currentUser;

  bool get inBottomSheet => Get.isBottomSheetOpen ?? false;

  List<Widget> get actionList {
    return [
      ...?actions,
      if (!stopShowDefaultAction) ...[
        ///.. logout IconButton
        // if (currentUser != null && showLogoutIcon) const LogoutAppBarButton(),
        if (showCartIcon)
          CartIconButton(
            color: forgroundColor,
            onTap: () => Get.toNamed(ShoppingCartPage.routeName),
          ),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool showBackButton = ModalRoute.of(context)?.canPop ?? false;

    return Card(
      elevation: 0.0,
      margin: EdgeInsets.zero,
      color: color ?? Theme.of(context).appBarTheme.backgroundColor,
      shape: Theme.of(context).appBarTheme.shape,
      child: SafeArea(
        top: true,
        left: true,
        right: true,
        bottom: true,
        // maintainBottomViewPadding: true,
        minimum: EdgeInsets.only(
          // top: inBottomSheet
          //     ? 0
          //     : Platform.isIOS
          //         ? !showBackButton
          //             ? 16.h
          //             : 30.h
          //         : 30.h,
          // top: View.of(context).viewPadding.top.sh,
          top: MediaQuery.paddingOf(context).top,
          left: /*!addHorizontalPadding ? 0.0 : */
              SharedStyle.horizontalScreenPadding,
          right: /*!addHorizontalPadding ? 0.0 : */
              SharedStyle.horizontalScreenPadding,
          bottom: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBackButton) ...[
              AppBackButton(
                iconColor: forgroundColor,
              ),
              UiHelper.horizontalSpaceSmall,
            ],
            Expanded(
              child: titleTextWidget != null
                  ? titleTextWidget!
                  : title != null
                      ? AppBarTitleTextWidget(
                          title: title,
                          translateTitle: translateTitle,
                          fontSize: fontSize,
                          textColor: forgroundColor ??
                              Theme.of(context).appBarTheme.foregroundColor,
                          centerTitle: centerTitle,
                        )
                      : Align(
                          // heightFactor: 2.0,
                          // widthFactor: 0.1,
                          alignment: AlignmentDirectional.centerStart,
                          child: InkWell(
                            onTap: () => Get.toNamed(AboutAppPage.routeName),
                            child: Image.asset(
                              AppImages.logoPng,
                              width: 100.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
            ),
            if (actionList.isNotEmpty) ...actionList,
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Size>('preferredSize', preferredSize));
  }
}

// class AppBarMoreOptionWidget extends StatelessWidget {
//   const AppBarMoreOptionWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsetsDirectional.only(
//         end: 16.0.w,
//       ),
//       clipBehavior: Clip.antiAlias,
//       decoration: SharedStyle.getCardDecoration(
//         borderWidth: 1,
//         cornerRadius: 15.r,
//         color: Get.theme.primaryColorLight,
//       ),
//       child: InkWell(
//         onTap: () {
//           Get.bottomSheet(
//             Card(
//               color: Get.theme.primaryColor,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(
//                     24.0,
//                   ),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   OptionsButton(
//                     onTap: () => Get.toNamed(
//                       ContactsScreen.routeName,
//                     ),
//                     label: AppStrings.contacts.tr.capitalizeFirst!,
//                     iconData: AppIcons.arrow,
//                   ),
//                   UiHelper.verticalSpaceSmall,
//                   OptionsButton(
//                     onTap: () => Get.toNamed(
//                       BoardMembersView.routeName,
//                     ),
//                     label: AppStrings.members.tr.capitalizeFirst!,
//                     iconData: AppIcons.arrow,
//                   ),
//                   UiHelper.verticalSpaceSmall,
//                   OptionsButton(
//                     onTap: () => Get.toNamed(
//                       UserProfileScreen.routeName,
//                     ),
//                     label: AppStrings.profile.tr.capitalizeFirst!,
//                     iconData: AppIcons.arrow,
//                   ),
//                 ],
//               ).marginSymmetric(
//                 vertical: 24.0,
//                 horizontal: 24.0,
//               ),
//             ),
//           );
//         },
//         child: Icon(
//           // AppIcons.settin,
//           FontAwesomeIcons.tableCellsLarge,
//           color: Get.theme.primaryColorDark,
//           size: 24.r,
//         ).paddingAll(12.0.r),
//       ),
//     );
//   }
// }

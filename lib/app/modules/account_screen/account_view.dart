import 'package:flutter/foundation.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/modules/address_list_page/address_list_view.dart';
import 'package:sakani_mobile_app/app/modules/auth_module/signup_screen/arguments/registration_screen_arguments.dart';
import 'package:sakani_mobile_app/app/modules/auth_module/signup_screen/signup_screen.dart';
import 'package:sakani_mobile_app/app/modules/customer_review_page/customer_review_view.dart';
import 'package:sakani_mobile_app/app/modules/downloadable_product_page/downloadable_product_view.dart';
import 'package:sakani_mobile_app/app/modules/orders_pages/order_history_page/order_history_view.dart';
import 'package:sakani_mobile_app/app/modules/return_request_pages/return_request_history_page/return_request_history_view.dart';
import 'package:sakani_mobile_app/app/modules/reward_point_page/reward_point_view.dart';
import 'package:sakani_mobile_app/app/modules/subscription_page/subscription_view.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../global_widget/app_ui_helper/shared_style.dart';
import '../../global_widget/app_ui_helper/ui_helpers.dart';
import '../new_products_page/new_products_view.dart';
import 'account_page_controller.dart';

class AccountPage extends GetView<AccountPageController> {
  static const String routeName = '/app/account';

  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.HOME_NAV_ACCOUNT.translate,
      ),
      body: SingleChildScrollView(
        padding: SharedStyle.singleChildScrollViewHorizontalPadding
            .add(EdgeInsets.symmetric(vertical: 16.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //region name and email
            /*if (controller.fullName.isNotNullOrEmpty ||
                controller.email.isNotNullOrEmpty)
              AccountPageItemWidget(
                  // withAlignment: false,
                  index: -1,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (controller.fullName.isNotNullOrEmpty)
                        Text(
                          controller.fullName!,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              .withBoldFont,
                        ).marginOnly(bottom: 8.0),
                      if (controller.email.isNotNullOrEmpty)
                        Text(
                          controller.email!,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              .withBoldFont,
                        ),
                    ],
                  )),*/

            //endregion

            if (kDebugMode)
              AccountPageItemWidget(
                index: 0,
                title: ConstStrings.ACCOUNT_INFO.translate,
                icon: CupertinoIcons.person,
                onClick: () {
                  //TODO byMe go to user profile page instead of SignupScreen page
                  controller.goto(
                    SignupScreen.routeName,
                    loginRequired: true,
                    args: RegistrationScreenArguments(getCustomerInfo: true)
                        .toJson(),
                  );
                },
              ),
            AccountPageItemWidget(
              index: 1,
              title: ConstStrings.ACCOUNT_CUSTOMER_ADDRESS.translate,
              icon: Icons.location_city_outlined,
              onClick: () => controller.goto(AddressListPage.routeName),
            ),


            AccountPageItemWidget(
              index: 3,
              title: ConstStrings.ACCOUNT_ORDERS.translate,
              icon: Icons.account_balance_wallet_outlined,
              onClick: () => controller.goto(OrderHistoryPage.routeName),
            ),
            if (controller.appLandingData?.hasReturnRequests == true)
              AccountPageItemWidget(
                index: 4,
                title: ConstStrings.ACCOUNT_RETURN_REQUESTS.translate,
                icon: Icons.keyboard_return_rounded,
                onClick: () =>
                    controller.goto(ReturnRequestHistoryPage.routeName),
              ),

            if (kDebugMode &&
                !(controller.appLandingData?.hideDownloadableProducts == true))
              AccountPageItemWidget(
                index: 5,
                title: ConstStrings.ACCOUNT_DOWNLOADABLE_PRODUCTS.translate,
                icon: Icons.download_outlined,
                onClick: () =>
                    controller.goto(DownloadableProductPage.routeName),
              ),

            // Obx(() {
            //   int snapshot = CartCheckAndInitHelper.instance.cartCount.value;
            //   return AccountPageItemWidget(
            //     index: 6,
            //     title: ConstStrings.SHOPPING_CART_TITLE.translate,
            //     icon: CupertinoIcons.shopping_cart,
            //     onClick: () => controller.goto(ShoppingCartPage.routeName,
            //         loginRequired: false),
            //     trailing: snapshot > 0
            //         ? CircleAvatar(
            //             backgroundColor: Theme.of(context).primaryColorDark,
            //             maxRadius: 10,
            //             child: Text(
            //               snapshot.toString(),
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .labelSmall
            //                   ?.copyWith(
            //                       color:
            //                           Theme.of(context).colorScheme.onPrimary,
            //                       height: 0.0),
            //             ),
            //           )
            //         : null,
            //   );
            // }),

            if (controller.appLandingData?.checkShowRewardPointsEnabled == true)
              AccountPageItemWidget(
                index: 7,
                title: ConstStrings.ACCOUNT_REWARD_POINT.translate,
                icon: Icons.new_releases_outlined,
                onClick: () => controller.goto(RewardPointPage.routeName),
              ),
            if (controller
                    .appLandingData?.checkShowProductReviewsTabOnAccountPage ==
                true)
              AccountPageItemWidget(
                index: 8,
                title: ConstStrings.ACCOUNT_MY_REVIEW.translate,
                icon: Icons.text_rotation_none_outlined,
                onClick: () => controller.goto(CustomerReviewPage.routeName),
              ),
            if (!(controller.appLandingData?.hideBackInStockSubscriptionsTab ==
                true))
              AccountPageItemWidget(
                index: 9,
                title:
                    ConstStrings.ACCOUNT_BACK_IN_STOCK_SUBSCRIPTION.translate,
                icon: Icons.subscriptions_outlined,
                onClick: () => controller.goto(SubscriptionPage.routeName),
              ),
            if (controller.appLandingData?.newProductsEnabled ?? false)
              AccountPageItemWidget(
                index: 10,
                title: ConstStrings.ACCOUNT_NEW_PRODUCTS.translate,
                icon: Icons.fiber_new_outlined,
                onClick: () => controller.goto(
                  NewProductsPage.routeName,
                  loginRequired: false,
                ),
              ),
            UiHelper.verticalSpaceTiny,

            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(16.r)),
            //     color: controller.isLoggedIn
            //         ? Colors.red.withOpacity(0.08)
            //         : Colors.green.withOpacity(0.08),
            //     border: Border.all(
            //       color: controller.isLoggedIn
            //           ? Colors.red.withOpacity(0.08)
            //           : Colors.green.withOpacity(0.08),
            //     ),
            //   ),
            //   padding: SharedStyle.contentContainerPadding,
            //   child: InkWell(
            //       onTap: controller.loginOrOutTap,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           controller.isLoggedIn
            //               ? const Icon(Icons.logout, color: Colors.red)
            //               : const Icon(Icons.login, color: Colors.green),
            //           UiHelper.horizontalSpaceSmall,
            //           controller.isLoggedIn
            //               ? AutoSizeText(
            //                   ConstStrings.ACCOUNT_LOGOUT.translate,
            //                   // style: Theme.of(context)
            //                   //     .textTheme
            //                   //     .titleMedium
            //                   //     ?.copyWith(
            //                   //       color: Colors.red,
            //                   //       fontWeight: FontWeight.bold,
            //                   //     ),
            //                 )
            //               : AutoSizeText(
            //                   ConstStrings.ACCOUNT_LOGIN.translate,
            //                   // style: Theme.of(context)
            //                   //     .textTheme
            //                   //     .titleMedium
            //                   //     ?.copyWith(
            //                   //       color: Colors.green,
            //                   //       fontWeight: FontWeight.bold,
            //                   //     ),
            //                 )
            //         ],
            //       )),
            // ),

            UiHelper.verticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}

class AccountPageItemWidget extends StatelessWidget {
  final int index;
  final String? title;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final IconData? icon;
  final VoidCallback? onClick;
  final Widget? trailing;

  const AccountPageItemWidget({
    super.key,
    this.title,
    this.icon,
    this.onClick,
    this.trailing,
    required this.index,
    this.child,
    this.padding,
    this.margin,
  });

  BoxDecoration containerBoxDecorationWithGradient({
    double? radius,
    Color? color,
    required BuildContext context,
  }) {
    // bool isRtl = Directionality.of(context) == TextDirection.rtl;
    bool isRtl = index.isOdd;

    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 16.r)),
        color: color ?? Theme.of(context).colorScheme.primary.withOpacity(0.02),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.60),
              Theme.of(context).primaryColor.withOpacity(0.10),
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
              Theme.of(context).colorScheme.primary.withOpacity(0.6)

              // Theme.of(context).primaryColor.withOpacity(0.60),
              // Theme.of(context).primaryColor.withOpacity(0.10),
              // Theme.of(context).colorScheme.primary.withOpacity(0.05),
              // Theme.of(context).colorScheme.primary.withOpacity(0.6)
            ],
            begin: isRtl ? Alignment.topLeft : Alignment.topRight,
            end: isRtl ? Alignment.bottomRight : Alignment.bottomLeft,
            // stops: const [0.0, 0.39, 0.40, 1.0],
            stops: const [0.0, 0.39, 0.40, 1.0],
          ),
          width: 0.4.r,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var iconColor = Theme.of(context).iconTheme.color;

    return Container(
      padding: padding,
      margin: margin ??
          EdgeInsets.symmetric(
            vertical: UiHelper.verticalSpaceTiny.height ?? 8.h,
          ),
      decoration: containerBoxDecorationWithGradient(context: context),
      child: child ??
          ListTile(
            onTap: onClick,
            leading: icon == null
                ? null
                : Icon(
                    icon,
                    color: iconColor,
                  ),
            title: Text(
              title ?? 'none',
              maxLines: 2,
              style: Theme.of(context).textTheme.labelMedium.withBoldFont,
            ),
            trailing: trailing ?? const SizedBox.shrink(),
          ),
    );
  }
}

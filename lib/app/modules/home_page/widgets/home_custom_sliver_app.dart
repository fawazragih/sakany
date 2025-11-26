import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:tamoily/app/global_widget/app_bar_widgets/customizable_space_bar.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/modules/all_cart_modules/cart_helper/cart_init_and_check_helper.dart';
import 'package:tamoily/app/modules/all_cart_modules/shopping_cart_page/shopping_cart_view.dart';
import 'package:tamoily/app/modules/all_cart_modules/widgets/cart_icon_button.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import '../../../core/theme/app_colors.dart';
import '../../wish_list_page/wish_list_view.dart' show WishListPage;
import 'app_home_slider_widget/app_home_slider_view.dart';

class HomeCustomSliverApp extends StatefulWidget {
  const HomeCustomSliverApp({
    super.key,
    // required this.workSpaceModel,
  });

  @override
  State<HomeCustomSliverApp> createState() => _HomeCustomSliverAppState();
}

class _HomeCustomSliverAppState extends State<HomeCustomSliverApp> {
  bool hideSliver = false;

  @override
  Widget build(BuildContext context) {
    return hideSliver
        ? SliverToBoxAdapter(
            child: CustomAppBar(
            color: Theme.of(context).scaffoldBackgroundColor,
          ))
        : SliverAppBar(
            expandedHeight: 230.h,
            toolbarHeight: 60.h,
            pinned: true,
            floating: false,
            elevation: 0.5,
            // backgroundColor: Theme.of(context).pr,
            automaticallyImplyLeading: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
            ),
            actionsPadding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            actions: [
              Obx(() {
                int snapshot =
                    CartCheckAndInitHelper.instance.wishListCount.value;
                return Badge(
                  isLabelVisible: snapshot > 0,
                  label: Text(snapshot.toString()),
                  child: AppCard(

                    color: LightThemeAppColors.primaryColor,
                    withAlignment: false,
                    withShadow: false,
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      size: 17.r,
                      Icons.favorite_border_outlined,
                    ),
                    onTap: () => Get.toNamed(WishListPage.routeName),
                  ),
                );
              }),
            ],
            leading: CartIconButton(
              // color: Theme.of(context).primaryColor,
              onTap: () => Get.toNamed(ShoppingCartPage.routeName),
            ),
            clipBehavior: Clip.antiAlias,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              expandedTitleScale: 1.1,
              title: CustomizableSpaceBar(
                builder: (context, scrollingRate) {
                  // scrollingRate >= 0.6 ? 125.h : 190.h;
                  logger.d('scrollingRate: $scrollingRate');
                  return SafeArea(
                    bottom: false,
                    child: Visibility(
                      visible: scrollingRate != 1.0,
                      maintainState: true,
                      child: AppHomeSliderView(
                        key: const Key('app_home_slider_view'),
                        onNoData: () {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            setState(() {
                              hideSliver = true;
                            });
                          });
                        },
                      ).marginOnly(
                        top: MediaQuery.viewPaddingOf(context).top,
                      ),
                    ),
                  );
                },
              ),
              // title: SafeArea(
              //   child: AppHomeSliderView(
              //     onNoData: () {
              //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //         setState(() {
              //           hideSliver = true;
              //         });
              //       });
              //     },
              //   ).marginOnly(
              //     top: MediaQuery.viewPaddingOf(context).top,
              //   ),
              // ),
            ),
          );
  }
}

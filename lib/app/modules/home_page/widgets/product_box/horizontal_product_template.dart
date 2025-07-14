import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:sakani/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';
import 'package:sakani/app/global_widget/rating_widget.dart';
import 'package:sakani/app/modules/all_cart_modules/cart_helper/cart_init_and_check_helper.dart';
import 'package:sakani/app/modules/products_details_screen/arguments/product_details_screen_arguments.dart';
import 'package:sakani/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:sakani/main.dart';
import '../../../../data/models/product_summary.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width * 0.1, 0);
    path.cubicTo(size.width * 0.05, 0, size.width * 0.01, size.height * 0.04,
        size.width * 0.01, size.height * 0.08);
    path.cubicTo(size.width * 0.01, size.height * 0.08, size.width * 0.01,
        size.height * 0.93, size.width * 0.01, size.height * 0.93);
    path.cubicTo(size.width * 0.01, size.height * 0.93, size.width * 0.01,
        size.height, size.width * 0.01, size.height);
    path.cubicTo(size.width * 0.01, size.height, size.width * 0.28, size.height,
        size.width * 0.28, size.height);
    path.cubicTo(size.width * 0.32, size.height, size.width * 0.35,
        size.height * 0.97, size.width * 0.37, size.height * 0.94);
    path.cubicTo(size.width * 0.4, size.height * 0.9, size.width * 0.45,
        size.height * 0.87, size.width * 0.51, size.height * 0.87);
    path.cubicTo(size.width * 0.57, size.height * 0.87, size.width * 0.62,
        size.height * 0.9, size.width * 0.65, size.height * 0.94);
    path.cubicTo(size.width * 0.67, size.height * 0.97, size.width * 0.7,
        size.height, size.width * 0.74, size.height);
    path.cubicTo(size.width * 0.74, size.height, size.width, size.height,
        size.width, size.height);
    path.cubicTo(size.width, size.height, size.width, size.height * 0.97,
        size.width, size.height * 0.97);
    path.cubicTo(size.width, size.height * 0.97, size.width, size.height * 0.08,
        size.width, size.height * 0.08);
    path.cubicTo(size.width, size.height * 0.04, size.width * 0.97, 0,
        size.width * 0.92, 0);
    path.cubicTo(
        size.width * 0.92, 0, size.width * 0.1, 0, size.width * 0.1, 0);
    path.close(); // Ensure the path is closed

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HorizontalProductTemplate extends StatelessWidget {
  final ProductSummary productData;

  // final String _new = GlobalService().getString(Const.RIBBON_NEW);

  const HorizontalProductTemplate(this.productData, {super.key});

  addToCartOrWishList(BuildContext context, bool isCart) async {
    if (productData.id == null) return;
    await CartCheckAndInitHelper.instance
        .addToCart(productData.id!.toInt(), productData.name, isCart);
  }

  @override
  Widget build(BuildContext context) {
    //region productImage
    final image = AppImageLoader(
      imageUrl: productData.defaultPictureModel?.imageUrl ??
          productData.defaultPictureModel?.fullSizeImageUrl ??
          productData.defaultPictureModel?.thumbImageUrl ??
          'http://',
      height: 180.0.h,
      width: double.maxFinite,
      fit: BoxFit.cover,
      padding: EdgeInsets.zero,
    );

    var thumbnail = ClipPath(
      clipper: MyCustomClipper(),
      child: image,
    );

    //endregion

    return AppCard(
      radius: 16.0,
      width: 0.4.sw,
      hasBorder: false,
      borderWidth: 0.0,
      margin: EdgeInsetsDirectional.symmetric(horizontal: 5.w, vertical: 10.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: () {
          if (productData.id != null) {
            Get.toNamed(
              ProductsDetailsPage.navToRoute(productData.id!.toString()),
              parameters: ProductDetailsScreenArguments(
                id: productData.id!,
                name: productData.name ?? '',
              ).toJson(),
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Stack(
                children: [
                  // region productImage,
                  productData.markAsNew == true
                      ? Banner(
                          message: ConstStrings.RIBBON_NEW.translate,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .withBoldFont!
                              .copyWith(height: 1.5),
                          location: (appLanding?.rtl ?? false)
                              ? BannerLocation.topStart
                              : BannerLocation.topEnd,
                          color: Color(0xffE8AC32),
                          // color: '#E8AC32'.toColor!,
                          child: thumbnail,
                        )
                      : thumbnail,
                  //endregion

                  //region addToWishlistButton
                  if (productData.productPrice?.disableWishlistButton == false)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: AppCard(
                        onTap: () => addToCartOrWishList(context, false),
                        padding: EdgeInsets.all(4.0.w),
                        borderWidth: 0.1,
                        color: Theme.of(context).colorScheme.secondary,
                        radius: 16,
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20.0.sp,
                        ),
                      ),
                    ),
                  //endregion

                  //region cartButton
                  if (productData.productPrice?.disableBuyButton == false)
                    Positioned(
                      bottom: 1.h,
                      right: 0,
                      left: 2,
                      child: Card(
                        shape: CircleBorder(),
                        color: Theme.of(context).primaryColorDark,
                        margin: EdgeInsets.zero,
                        child: InkWell(
                          onTap: () => addToCartOrWishList(context, true),
                          child: Icon(
                            IconsaxPlusBroken.bag_2,
                            color: context.theme.colorScheme.onPrimary,
                            size: 24.0.r,
                          ).paddingAll(4.0.r),
                        ),
                      ),
                    )
                  //endregion
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //region productName
                Text(
                  productData.name ?? '',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        // fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                  strutStyle: const StrutStyle(
                    forceStrutHeight: true,
                    // fontWeight: FontWeight.bold
                    // height: 1.2.h,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                //endregion

                //region ratingBar,
                AppRatingWidget(
                  rate:
                      productData.reviewOverviewModel?.ratingSum?.toDouble() ??
                          4,
                  starsIconColor: context.theme.colorScheme.primary,
                  iconSize: 12.sp,
                ),
                //endregion

                //region productPrice
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (productData.productPrice?.price != null)
                      Flexible(
                        child: Text(
                          productData.productPrice?.price ?? '0',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (productData.productPrice?.oldPrice != null)
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                          child: Text(
                            productData.productPrice?.oldPrice ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  ],
                ),
                //endregion
              ].withSpaceBetween(
                height: 1.0.h,
              ),
            ).paddingDirection(
              start: 4.0.w,
              bottom: 4.0.w,
            )
          ],
        ),
      ),
    );
  }
}

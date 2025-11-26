import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:tamoily/app/data/local_data/setting_app_service.dart';
import 'package:tamoily/app/data/models/home_slider_response.dart';
import 'package:tamoily/app/data/models/slider_aspect_ratio.dart';
import 'package:tamoily/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import 'package:tamoily/app/global_widget/images_and_videos_widgets/image_slider_widget.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/assets_helpers/app_images.dart';
import 'app_home_slider_controller.dart';

class AppHomeSliderView extends StatelessWidget {
  final VoidCallback? onNoData;

  const AppHomeSliderView({super.key, required this.onNoData});

  AppSettingService get appSettingService => Get.find<AppSettingService>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppHomeSliderController>(
      init: AppHomeSliderController(),
      builder: (controller) {
        // logger.d(controller.homeSliderData?.sliders?.map((e) => e.toJson()).toList(),);
        if (!controller.busy &&
            (controller.homeSliderData == null ||
                controller.homeSliderData?.sliders?.isNullOrEmpty == true)) {
          onNoData?.call();
          return const Offstage();
        }
        return FadeInDown(
          child: Skeletonizer(
            enabled: controller.busy,
            child: controller.busy
                ? Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    color: Colors.grey.shade100,
                    elevation: 0.0,
                    child: Skeleton.shade(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: Image.asset(
                          AppImages.logoPng,
                          width: double.infinity,
                          height: 100.h,
                          color: Colors.grey,
                          fit: BoxFit.contain,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                : ImageSliderWidget<Sliders>(
                    imageUrl: controller.homeSliderData?.sliders ?? [],
                    getImageUrl: (Sliders e) => e.imageUrl ?? '',
                    onImageTap: controller.onSliderImageClick,
                    viewportFraction: 0.9,
                    // aspectRatio: 1.0,
                    borderRadius: BorderRadius.circular(12),
                    showIndicators: true,
                    indicatorsSize: 4.0,
                    fit: BoxFit.cover,
                    // placeHolderPath: AppImages.logoPng,
                    autoPlayInterval:
                        appSettingService.appLandingData?.sliderAutoPlayTimeout,
                    // fit: BoxFit.contain,
                  ),
          ),
        );
      },
    );
  }
}
/*
class BannerSlider extends StatelessWidget {
  final HomeSliderData sliderData;
  final ValueChanged<Sliders>? onSlidTap;

  const BannerSlider(
      {super.key, required this.sliderData, required this.onSlidTap});

  AppSettingService get appSettingService => Get.find<AppSettingService>();

  // final double defaultAspectRatio = 2.2831;
  final double defaultAspectRatio = 1.0;

*/ /*
  Future<double?> setImageRatio() async {
    double? toReturn;

    // Compare with the already saved url. url will be different if any of the image URL got changed
    String urls = '';
    sliderData.sliders?.forEach((element) {
      urls = urls + (element.imageUrl ?? '');
    });

    final SliderAspectRatio? savedData =
        await appSettingService.getSliderAspectRatio();
    if (savedData?.urlHash == urls) {
      toReturn = savedData?.aspectRatio;
      return toReturn;
    }
    double minAspectRatio = 1000;

    sliderData.sliders?.forEach((i) {
      Image image = Image.network(i.imageUrl ?? '');

      image.image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          double imgRatio =
              info.image.width.toDouble() / info.image.height.toDouble();
          minAspectRatio = min(minAspectRatio, imgRatio);

          if (i == sliderData.sliders?.last) {
            double aspectRatio = minAspectRatio;

            // save aspect ratio to sharedPref
            appSettingService.setSliderAspectRatio(
                SliderAspectRatio(aspectRatio: aspectRatio, urlHash: urls));

            // updating new aspect ratio
            // setState(() {
            //   if (kDebugMode) {
            //     print("aspectRatio $aspectRatio");
            //   }
            // });

            toReturn = aspectRatio;
          }
        }),
      );
    });

    if (kDebugMode) {
      print("aspectRatio $toReturn");
    }

    return toReturn;
  }
*/ /*

  @override
  Widget build(BuildContext context) {
    return ImageSliderWidget<Sliders>(
      imageUrl: sliderData.sliders,

      getImageUrl: (Sliders e) => e.imageUrl ?? '',
      onImageTap: onSlidTap,
      viewportFraction: 0.9,
      aspectRatio: defaultAspectRatio,
      borderRadius: BorderRadius.circular(12),
      showIndicators: true,
      indicatorsSize: 4.0,
      fit: BoxFit.contain,

      // placeHolderPath: AppImages.logoPng,
      autoPlayInterval:
          appSettingService.appLandingData?.sliderAutoPlayTimeout,
      // fit: BoxFit.contain,
    );
  }
}*/

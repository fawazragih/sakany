import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tamoily/app/global_widget/images_and_videos_widgets/app_image_loader.dart' show AppImageLoader;
import '../../core/language_and_localization/app_strings.dart';
import '../../global_widget/action_buttons/action_button.dart';
import 'intro_guides_controller.dart';

class IntroGuidesScreen extends GetView<IntroGuidesController> {
  static const String routeName = '/intro_guides_page';

  const IntroGuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroGuidesController>(
      builder: (controller) {
        controller.hideStatusBar();
        return Scaffold(
          // backgroundColor: controller.pageIndex == 0
          //     ? Theme.of(context).colorScheme.primaryContainer
          //     : Theme.of(context).colorScheme.secondaryContainer,
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: IntroductionScreen(
                  key: controller.introKey,
                  globalBackgroundColor: Colors.transparent,
                  onChange: controller.onPageChange,
                  pages: controller.introList
                      .map(
                        (e) => PageViewModel(
                          titleWidget: Row(
                            children: [
                              Text(
                                e.title,
                                style: Theme.of(context).textTheme.titleLarge,
                                maxLines: 2,
                                textDirection: e.title.getTextDirection,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          bodyWidget: Text(
                            e.body,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  height: 1.4,
                                  // fontSize: fontSizeWithSp ?? 12.sp,
                                  // wordSpacing: wordSpacing ?? 0,
                                  // letterSpacing: letterSpacing,
                                  // decoration: textDecoration,
                                  // color: color ?? (light ? Get.theme.scaffoldBackgroundColor : null),
                                  // fontWeight: fontWeight ?? (bold ? FontWeight.bold : null),
                                ),
                            textAlign: TextAlign.justify,
                          ),
                          image: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Center(
                              //   child: Spin(
                              //     key: UniqueKey(),
                              //     spins: controller.pageIndex == 0 ? -0.5 : 0.5,
                              //     child: AppImageLoader.asset(
                              //       AppImages.logoPng,
                              //     ),
                              //   ),
                              // ),
                              Positioned(
                                bottom: -80.h,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: AppImageLoader(
                                    imageUrl:e.imagePath,
                                    height: 0.8.sw,
                                    width: 0.8.sw,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: PageDecoration(
                            bodyAlignment: Alignment.bottomCenter,
                            bodyPadding: EdgeInsets.only(
                              bottom: 60.0.h,
                            ),
                            titlePadding: EdgeInsets.only(
                              bottom: 16.0.h,
                            ),
                            // descriptionPadding: EdgeInsets.zero,
                            // titlePadding: EdgeInsets.zero,
                          ),
                        ),
                      )
                      .toList(growable: false),
                  showSkipButton: false,
                  showDoneButton: false,
                  showNextButton: false,
                  // left, right, top and bottom,
                  safeAreaList: const [
                    false,
                    false,
                    false,
                    true,
                  ],
                  globalFooter: SizedBox(
                    width: double.infinity,
                    child: ActionButton(
                      text: AppStrings.getStarted.tr.capitalizeFirst,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onPressed: controller.onGetStarted,
                    ),
                  ).paddingOnly(
                    left: 16.0,
                    right: 16.0,
                    top: 12.0,
                    bottom: 32.0,
                  ),
                  dotsDecorator: DotsDecorator(
                    size: const Size.square(10.0),
                    activeSize: const Size(30.0, 10.0),
                    activeColor: Theme.of(context).colorScheme.primary,
                    color: Colors.black26,
                    spacing: const EdgeInsets.symmetric(
                      horizontal: 3.0,
                    ),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                  ),
                ).paddingSymmetric(
                  horizontal: 16.0,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

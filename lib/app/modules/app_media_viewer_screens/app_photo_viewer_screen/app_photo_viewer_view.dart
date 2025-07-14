import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/empty_data_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/images_and_videos_widgets/app_image_loader.dart';

import '../../../global_widget/app_bar_widgets/custom_app_bar.dart';
import 'app_photo_viewer_controller.dart';

class AppPhotoViewerPage extends GetView<AppPhotoViewerController> {
  static const String routeName = '/app/app_photo_viewer_screen';

  // final PhotoViewController photoViewController = PhotoViewController();

  const AppPhotoViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',

        translateTitle: true,
      ),
      body: controller.images.isNullOrEmpty
          ? EmptyDataWidget(
              text: AppStrings.noImageToView.tr.capitalize!,
            )
          : Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    children: controller.images!
                        .map(
                          (e) => GestureDetector(
                            onDoubleTap: () {
                              if (controller.transformationController.value !=
                                  Matrix4.identity()) {
                                controller.restImage();
                              }
                            },
                            child: InteractiveViewer(
                              // controller: photoViewController,
                              trackpadScrollCausesScale: true,
                              transformationController:
                                  controller.transformationController,
                              boundaryMargin: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              onInteractionEnd: (details) {
                                // logger.d(details.velocity);
                              },
                              child: Center(
                                child: AppImageLoader(
                                 imageUrl: e!,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                GetBuilder<AppPhotoViewerController>(
                  builder: (controller) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.images!.asMap().entries.map((entry) {
                        bool isCurrent = controller.currentPage == entry.key;
                        return Container(
                          width: 8.0.r,
                          height: 8.0.r,
                          margin: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: /*isCurrent ? BoxShape.rectangle : */
                                BoxShape.circle,
                            // borderRadius:
                            //     isCurrent ? BorderRadius.circular(12.0) : null,
                            color: isCurrent
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.2),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                UiHelper.verticalSpaceSmall,
              ],
            ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).cardColor,
      //   onPressed: () {
      //    controller.restImage();
      //   },
      //   child: const Icon(
      //     Icons.crop_free_outlined,
      //   ),
      // ),
    );
  }
}

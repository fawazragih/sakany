import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:tamoily/app/base_controllers_and_listeners/helpers_methods.dart';
import 'package:tamoily/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import '../../../data/models/app_user_model.dart';
import '../../../global_widget/app_ui_helper/shared_style.dart';
import '../../../global_widget/app_ui_helper/ui_helpers.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard(
      {super.key, required this.profile, required this.onEditProfileTapped});

  final AppUser profile;
  final VoidCallback onEditProfileTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            elevation: 0,
            child: Row(
              children: [
                AppImageLoader(
                  imageUrl: profile.imageUrl,
                  // placeHolderPath: AppImages.userProfilePlaceHolderPng,
                  width: 70.w,
                  height: 70.w,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                UiHelper.horizontalSpaceMedium,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        HelpersMethods.splitOnlyTowUserName(
                              profile.name,
                            ) ??
                            'unknown',
                        textAlign: TextAlign.center,
                        style: SharedStyle.subtitle2(
                          bold: true,
                          fontSizeWithSp: 16.0.sp,
                        ),
                      ),
                      if (profile.phone != null) ...[
                        UiHelper.verticalSpaceSmall,
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 16.sp,
                            ),
                            UiHelper.horizontalSpaceTiny,
                            Text(
                              profile.phone ?? '',
                              style: SharedStyle.subtitle2(
                                color:
                                    Theme.of(context).colorScheme.surfaceTint,
                              ),
                            ),
                          ],
                        ),
                      ],
                      UiHelper.verticalSpaceTiny,
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 16.sp,
                          ),
                          UiHelper.horizontalSpaceTiny,
                          Text(
                            profile.email ?? '',
                            style: SharedStyle.subtitle2(
                              color: Theme.of(context).colorScheme.surfaceTint,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  constraints: BoxConstraints(
                    maxHeight: 24.sp,
                    maxWidth: 24.sp,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: onEditProfileTapped,
                  icon: Icon(
                    IconsaxPlusLinear.user,
                    size: 20.sp,
                  ),
                ),
              ],
            ).paddingSymmetric(
              horizontal: 8.0,
              vertical: 8.0,
            )),
      ],
    );
  }
}

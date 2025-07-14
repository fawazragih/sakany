import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
class UserProfilePhoto extends StatelessWidget {
  const UserProfilePhoto({
    super.key,
    required this.imageUrl,
    this.onTap,
    this.radius = 20,
  });

  final String? imageUrl;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: AppImageLoader(
        imageUrl: 'imageUrl',
        // radius: radius.r,
        bgColor: Get.theme.primaryColorDark,
        padding: EdgeInsets.all(2.0),
        isUserPlaceHolder: true,
        // errorWidget: Icon(
        //   AppIcons.usersOutlined,
        //   color: Get.theme.primaryColor,
        //   size: 18.r,
        // ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../global_widget/app_bar_widgets/custom_app_bar.dart';
import 'about_app_controller.dart';

class AboutAppPage extends GetView<AboutAppController> {
  static const String routeName = '/app/about_app';

  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.about.tr.capitalizeFirst,
        // showLogoutIcon: false,
      ),
      // body: GetBuilder<AboutAppController>(
      //   builder: (controller) {
      //     return ScreenStatusWidgets(
      //       controller: controller,
      //       isEmpty: controller.appSetting == null,
      //       onRetry: controller.startGetData,
      //       dataWidget: SingleChildScrollView(
      //         padding: SharedStyle.singleChildScrollViewHorizontalPadding,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             TitleWithIcon(
      //               title: AppStrings.aboutApp.tr.capitalizeFirst!,
      //             ),
      //             Text(
      //                   controller.appSetting?.about ??
      //                   controller.appSetting?.description ??
      //                   '',
      //               textAlign: TextAlign.justify,
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .bodyMedium
      //                   ?.copyWith(height: 1.2),
      //             ),
      //             UiHelper.verticalSpaceSmall,
      //             TitleWithIcon(
      //               title: AppStrings.contactUs.tr.capitalizeFirst!,
      //             ),
      //             SettingsIconItem(
      //               showIconBorder: true,
      //               iconBorderColor: Theme.of(context).colorScheme.secondary,
      //               title: controller.appSetting?.phones ?? '',
      //               leadingIcon: CupertinoIcons.phone,
      //               boldText: false,
      //               iconSize: 24.sp,
      //               onTap: controller.onPhonesTap,
      //             ),
      //             SettingsIconItem(
      //               showIconBorder: true,
      //               iconBorderColor: Theme.of(context).colorScheme.secondary,
      //               title: controller.appSetting?.whatsapp ?? '',
      //               leadingIcon: FontAwesomeIcons.whatsapp,
      //               boldText: false,
      //               iconSize: 24.sp,
      //               onTap: () => UrlLauncherHelper.openWhatsapp(
      //                   phoneNumber: controller.appSetting?.whatsapp ?? ''),
      //             ),
      //             SettingsIconItem(
      //               showIconBorder: true,
      //               iconBorderColor: Theme.of(context).colorScheme.secondary,
      //               title: controller.appSetting?.email ?? '',
      //               leadingIcon: CupertinoIcons.mail,
      //               boldText: false,
      //               iconSize: 24.sp,
      //               onTap: () => UrlLauncherHelper.openEmail(
      //                   email: controller.appSetting?.email ?? ''),
      //             ),
      //             SettingsIconItem(
      //               showIconBorder: true,
      //               iconBorderColor: Theme.of(context).colorScheme.secondary,
      //               title: controller.appSetting?.website ?? '',
      //               leadingIcon: CupertinoIcons.globe,
      //               boldText: false,
      //               iconSize: 24.sp,
      //               onTap: () => UrlLauncherHelper.openUrlLink(
      //                   urlLink: controller.appSetting?.website ?? ''),
      //             ),
      //           ].withSpaceBetween(
      //             height: UiHelper.verticalSpaceMedium.height,
      //             includeBeforFirst: true,
      //             includeAfterLast: true,
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ).paddingSymmetric(
      //   vertical: 12.0,
      // ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData? iconData;

  const TitleWithIcon({
    super.key,
    required this.title,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Icon(
          iconData ?? CupertinoIcons.forward,
          color: Theme.of(context).colorScheme.primary,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ).paddingOnly(
          bottom: 2.0,
        ),
      ],
    );
  }
}

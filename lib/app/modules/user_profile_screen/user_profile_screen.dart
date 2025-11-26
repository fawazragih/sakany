import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/modules/contact_us_page/contact_us_view.dart';
import 'package:tamoily/app/modules/topic_page/arguments/topic_page_arguments.dart';
import 'package:tamoily/app/modules/topic_page/topic_view.dart';
import 'package:tamoily/app/modules/vendors_pages/vendor_list_page/vendor_list_view.dart';
import 'package:tamoily/app/utils/constants/app_constants.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../data/local_data/setting_app_service.dart';
import '../../global_widget/app_bar_widgets/custom_app_bar.dart';
import '../../global_widget/app_ui_helper/shared_style.dart';
import '../../global_widget/app_ui_helper/ui_helpers.dart';
import '../../global_widget/loading_progress_bar.dart';
import '../../global_widget/retry_and_errors_widgets/retry_widget.dart';
import '../../global_widget/settings_widgets/language_item.dart';
import '../../global_widget/settings_widgets/settings_icon_widget.dart';
import '../auth_module/rest_password_bottom_sheet_widget/reset_password_widget.dart';
import 'user_profile_controller.dart';
import 'widgets/change_default_currency/change_default_currency_view.dart';

class UserProfilePage extends GetView<UserProfileController> {
  static const String routeName = '/UserProfileScreen';

  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // showUserIcon: false,
        title: AppStrings.profile.tr.capitalizeFirst!,
      ),
      body: controller.busy
          ? const Center(
              child: LoadingProgressBar(),
            )
          : controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.getUserProfileData,
                )
              : SingleChildScrollView(
                  child: GetBuilder<UserProfileController>(
                    builder: (controller) => Column(
                      children: [
                        //region name and email
                        if (controller.fullName.isNotNullOrEmpty ||
                            controller.email.isNotNullOrEmpty)
                          AppCard(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.h,
                                vertical: 12.w,
                              ),
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
                              )),

                        //endregion

                        // PhoneProfileViewWidget(),

                        ///.. update profile
                        // UiHelper.verticalSpaceMedium,
                        // SettingsIconItem(
                        //   title: AppStrings.updateProfile.tr.capitalizeFirst!,
                        //   leadingIcon: CupertinoIcons.pen,
                        //   onTap: controller.onUpdateUserProfile,
                        // ),

                        UiHelper.verticalSpaceMedium,
                        SettingsIconItem(
                          title: AppStrings
                              .changeDefaultCurrency.tr.capitalizeFirst!,
                          // subtitle: AppStrings.changeDefaultCurrencyDesc.tr.capitalizeFirst!,
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 16.w,
                          ),
                          leadingIcon: CupertinoIcons.money_dollar_circle,
                          onTap: () {
                            Get.bottomSheet(
                              ChangeDefaultCurrencyWidget(),
                              isScrollControlled: true,
                            );
                          },
                        ),

                        //region biometric
                        if (kDebugMode) ...[
                          //TODO byMe enable biometric login
                          UiHelper.verticalSpaceMedium,
                          SettingsIconItem(
                            title: AppStrings.biometric.tr.capitalizeFirst!,
                            subtitle: AppStrings
                                .enableBiometricLogin.tr.capitalizeFirst!,
                            leadingIcon: Icons.fingerprint_outlined,
                            trailingIcon: Obx(() {
                              return Switch(
                                value: Get.find<AppSettingService>()
                                    .enabledBiometric
                                    .value,
                                activeColor: Colors.green.shade700,
                                onChanged: (value) =>
                                    Get.find<AppSettingService>()
                                        .toggleBiometricState(value),
                              );
                            }),
                          ),
                        ],
                        //endregion.

                        //region change password
                        if (controller
                            .userAuthController.authenticated.value) ...[
                          UiHelper.verticalSpaceMedium,
                          SettingsIconItem(
                            padding: EdgeInsets.symmetric(
                              vertical: 6.h,
                              horizontal: 16.w,
                            ),
                            title:
                                AppStrings.changePassword.tr.capitalizeFirst!,
                            leadingIcon: CupertinoIcons.lock_shield,
                            onTap: () {
                              controller.toastMessage('TODO');
                              return;
                              Get.bottomSheet(
                                const ResetPasswordWidget(),
                              );
                            },
                          ),
                        ],
                        //endregion.

                        //region change Language
                        UiHelper.verticalSpaceMedium,
                        const LanguageItem(),
                        //endregion.

                        //region TOPIC_PRIVACY_POLICY
                        UiHelper.verticalSpaceMedium,
                        SettingsIconItem(
                          title: ConstStrings.MORE_PRIVACY_POLICY.translate,
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 16.w,
                          ),
                          leadingIcon: CupertinoIcons.info_circle,
                          onTap: () {
                            Get.toNamed(
                              TopicPage.routeName,
                              parameters: TopicPageArguments(
                                topicName: AppConstants.TOPIC_PRIVACY_POLICY,
                              ).toJson(),
                            );
                          },
                        ),
                        //endregion.

                        //region Contact Us
                        UiHelper.verticalSpaceMedium,
                        SettingsIconItem(
                          title: ConstStrings.MORE_CONTACT_US.translate,
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 16.w,
                          ),
                          leadingIcon: CupertinoIcons.info_circle,
                          onTap: () {
                            Get.toNamed(ContactUsPage.routeName);
                          },
                        ),
                        //endregion.

                        //region MORE_ABOUT_US
                        UiHelper.verticalSpaceMedium,
                        SettingsIconItem(
                          title: ConstStrings.MORE_ABOUT_US.translate,
                          padding: EdgeInsets.symmetric(
                            vertical: 6.h,
                            horizontal: 16.w,
                          ),
                          leadingIcon: CupertinoIcons.info_circle,
                          onTap: () {
                            Get.toNamed(
                              TopicPage.routeName,
                              parameters: TopicPageArguments(
                                topicName: AppConstants.TOPIC_ABOUT_US,
                              ).toJson(),
                            );
                          },
                        ),
                        //endregion.

                        //region PRODUCT_VENDOR
                        if (controller.appLandingData?.showAllVendors ==
                            true) ...[
                          UiHelper.verticalSpaceMedium,
                          SettingsIconItem(
                            title: ConstStrings.PRODUCT_VENDOR.translate,
                            padding: EdgeInsets.symmetric(
                              vertical: 6.h,
                              horizontal: 16.w,
                            ),
                            leadingIcon: CupertinoIcons.info_circle,
                            onTap: () {
                              Get.toNamed(VendorListPage.routeName);
                            },
                          ),
                        ],
                        //endregion.

                        //region login/logout button
                        UiHelper.verticalSpaceMedium,
                        Obx(() {
                          bool isAuthenticated =
                              controller.userAuthController.authenticated.value;
                          return SettingsIconItem(
                            padding: EdgeInsets.symmetric(
                              vertical: 6.h,
                              horizontal: 16.w,
                            ),
                            title: isAuthenticated
                                ? ConstStrings.ACCOUNT_LOGOUT.translate
                                : ConstStrings.ACCOUNT_LOGIN.translate,
                            leadingIcon:
                                isAuthenticated ? Icons.logout : Icons.login,
                            iconColor:
                                Theme.of(context).primaryColorDark.withOpacity(
                                      isAuthenticated ? 0.5 : 1.0,
                                    ),
                            iconBorderColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            titleStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color
                                        ?.withOpacity(
                                          isAuthenticated ? 0.5 : 1.0,
                                        )),
                            onTap: () => controller.loginOrOutTap(),
                          );
                        }),
                        //endregion
                      ],
                    ).marginSymmetric(
                      horizontal: SharedStyle.horizontalScreenPadding,
                      vertical: 16.0,
                    ),
                  ),
                ),
    );
  }
}

class PhoneProfileViewWidget extends StatelessWidget {
  PhoneProfileViewWidget({
    super.key,
  });

  final UserProfileController controller = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: SharedStyle.getCardDecoration(),
      /* child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularCachedImage(
            imageUrl: controller.userAuthController.currentUser?.imageUrl,
            radius: 44.r,
            isUserPlaceHolder: true,
          ),
          UiHelper.horizontalSpaceLarge,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                UiHelper.verticalSpaceSmall,
                AutoSizeText(
                  controller.userAuthController.currentUser?.name ??
                      AppStrings.userName.tr.capitalizeFirst!,
                  style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: controller.userAuthController.currentUser?.name ==
                              null
                          ? Theme.of(context).hintColor
                          : null),
                ),
                UiHelper.verticalSpaceMedium,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LabelDataWidget(
                      label: AppStrings.email.tr.capitalizeFirst!
                          .replaceFirst(' الإلكتروني', ''),
                      data: controller.userAuthController.currentUser?.email ??
                          'example@example.com',
                      textColor: Get.theme.primaryColor,
                      backgroundColor: Get.theme.colorScheme.primary,
                      onTap: () => controller.copyToClipBoard(
                          controller.userAuthController.currentUser?.email ??
                              ''),
                    ),
                    UiHelper.verticalSpaceMedium,
                    if (controller.userAuthController.currentUser?.phone !=
                        null)
                      LabelDataWidget(
                        label: AppStrings.phoneNum.capitalizeFirst!,
                        data:
                            controller.userAuthController.currentUser?.phone ??
                                '',
                        textColor: Get.theme.primaryColorDark,
                        backgroundColor: Get.theme.colorScheme.primary,
                      ),
                  ],
                ),
              ],
            ),
          ),
          */ /* CustomCardIconButton(
          label: AppStrings.edit.capitalizeFirst!,
          bgColor: Get.theme.colorScheme.primary,
          iconData: AppIcons.edit,
          onTap: () {},
        ),*/ /*
        ],
      ),*/
    );
  }
}

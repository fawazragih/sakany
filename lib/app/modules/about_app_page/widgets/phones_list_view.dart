import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/bottome_sheet_widgets/bottom_sheet_top_container.dart';
import 'package:sakani_mobile_app/app/global_widget/dashed_divider_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';

import '../../../utils/url_launcher_manager.dart';

class PhonesListView extends StatelessWidget {
  final List<String> phones;

  const PhonesListView({super.key, required this.phones});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 0.8.sh,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TopBottomSheetDecorator(
              margin: EdgeInsets.only(
                bottom: 16.0,
              ),
            ),
            // Text(
            //   AppStrings
            //       .pleaseSelectYourFavoritePaymentMethod.tr.capitalizeFirst!,
            //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // UiHelper.verticalSpaceMedium,
            ListView.separated(
              shrinkWrap: true,
              itemCount: phones.length,
              padding: EdgeInsets.zero,
              separatorBuilder: (BuildContext context, int index) =>
                  const DashedDividerWidget(
                // color: Colors.black,
                dashSpace: 4,
                margin: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12.0,
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                final phone = phones[index];
                return AppCard(
                  margin: EdgeInsets.zero,
                  onTap: () {
                    if(Get.isBottomSheetOpen?? false){
                      Get.close(1);
                    }
                    UrlLauncherManager.makePhoneCall(
                        phoneNumber: phone ?? '');
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: Row(
                    children: [
                       CircleAvatar(
                        radius: 14.r,
                        child: Icon(
                          Icons.phone,
                          size: 18.r,
                        ),
                      ),
                      UiHelper.horizontalSpaceSmall,
                      Text(phone),
                    ],
                  ),
                );
              },
            ),
          ],
        ).paddingSymmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import '../../modules/tabs_screen/tabs_screen_controller.dart';

class LogoutAppBarButton extends StatelessWidget {
  const LogoutAppBarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: 15.r,
      color: Get.theme.primaryColorDark,
      padding: EdgeInsets.all(10.0.r),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          // if (onTapLogout != null) onTapLogout!();
          Get.find<TabsScreenController>().logout();
        },
        child: RotatedBox(
          quarterTurns:
              Directionality.of(Get.context!) == TextDirection.ltr ? 0 : 2,
          child: Icon(
            IconsaxPlusLinear.logout,
            color: Get.theme.cardColor,
            size: 20.r,
          ),
        ),
      ),
    );
  }
}

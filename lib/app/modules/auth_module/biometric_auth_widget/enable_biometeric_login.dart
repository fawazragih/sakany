import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/local_data/setting_app_service.dart';
import '../../../global_widget/app_ui_helper/shared_style.dart';

/// this widget can be used in login screen
class EnableBiometricLogin extends StatelessWidget {
  const EnableBiometricLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueBuilder<bool?>(
      initialValue: Get.find<AppSettingService>().enabledBiometric.value,
      builder: (value, updateFn) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4.0,
              ),
            ),
            side: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColorDark,
            ),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (bool? value) => updateFn.call(value),
            checkColor: Theme.of(context).primaryColorDark,
            fillColor: WidgetStateColor.resolveWith(
              (states) => Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Text(
            AppStrings.enableBiometricLogin.tr.capitalizeFirst!,
            style: SharedStyle.subtitle2(
              bold: true,
            ),
          ),
        ],
      ),
      onUpdate: (value) {
        Get.find<AppSettingService>().toggleBiometricState(value!);
      },
      // onDispose: () => print("Widget unmounted"),
    );
  }
}

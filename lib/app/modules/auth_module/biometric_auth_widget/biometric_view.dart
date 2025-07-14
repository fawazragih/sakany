import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'biometric_controller.dart';

class BiometricView extends StatelessWidget {
  static const String routeName = '/biometric_view';

  const BiometricView({super.key});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return GetBuilder<BiometricController>(
      init: BiometricController(),
      builder: (controller) {
        return GestureDetector(
          child: Icon(
            Icons.fingerprint_outlined,
            color: Get.theme.primaryColorDark,
            size: 80.0,
          ),
          // onTap: () => controller.biometricAuthenticate(),
        );
      },
    );
  }
}

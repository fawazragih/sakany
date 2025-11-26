import 'package:animate_do/animate_do.dart';
import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/utils/api_env_config/api_env.dart';
import 'package:tamoily/app/utils/api_env_config/api_env_setter.dart';
import '../../core/assets_helpers/app_images.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/SplashScreen';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: Container(
        height: 8.0.h,
        color: Colors.white,
      ),
      body: Center(
        child: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) => controller.isLocalhostFlavor
              ? EnterBaseUrlForLocalhost(
                  onComplete: () {
                    if (BuildEnvironment.instance.baseUrl.isNullOrEmpty) {
                      controller.buildErrorSnackBar(
                        msg: 'base url can NOT be null or empty',
                      );
                      return;
                    } else {
                      controller.startInitData();
                    }
                  },
                )
              : Stack(
                  children: [
                    SizedBox(
                      height: 1.0.sh,
                      width: 1.0.sw,
                      // child: Container(),
                      child: ElasticIn(
                        duration: const Duration(
                          milliseconds: 2000,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.logoPng,
                            height: 0.25.sw,
                            width: 0.25.sw,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // child: VideoPlayer(
                      //   controller.videoController,
                      // ),
                    ),
                    Positioned(
                      bottom: 100.h,
                      left: 0,
                      right: 0,
                      child: UiHelper.spinKitProgressIndicator(
                        size: 40.r,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class EnterBaseUrlForLocalhost extends StatelessWidget {
  final VoidCallback onComplete;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EnterBaseUrlForLocalhost({
    super.key,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                autofocus: false,
                validator: (value) {
                  if (value.isNullOrEmpty) {
                    return 'this field is required';
                  }
                  return null;
                },
                onSaved: (value) => LocalhostEnv.instance.baseUrl = value!,
                textInputAction: TextInputAction.next,
              ),
              UiHelper.verticalSpaceMedium,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                  child: const Text('Save'),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      onComplete.call();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ).paddingSymmetric(
        horizontal: 24.0,
      ),
    );
  }
}

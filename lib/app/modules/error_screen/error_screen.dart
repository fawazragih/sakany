import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/base_controllers_and_listeners/user_auth_controller.dart';
import 'package:sakani_mobile_app/app/modules/error_screen/error_screen_controller.dart';

import '../../utils/constants/app_constants.dart';

class ErrorScreenArguments {
  String? errorMsg;
  int? errorCode;

  ErrorScreenArguments({
    this.errorMsg,
    this.errorCode,
  });

  Map<String, String> toJson() {
    return {
      'errorMsg': errorMsg.toString(),
      'errorCode': errorCode.toString(),
    }..removeWhere((k, v) => v.isNullOrEmpty);
  }

  factory ErrorScreenArguments.fromJson(Map<String, dynamic> json) {
    return ErrorScreenArguments(
      errorMsg: json['errorMsg'],
      errorCode: int.tryParse(json['errorCode'].toString()),
    );
  }
}

class ErrorScreen extends GetView<ErrorPageController> {
  static const routeName = '/errorScreen';
  // final ErrorScreenArguments screenArgument;

  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_octagon,
              size: 0.5.sw,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                controller.screenArgument?.errorMsg?.isEmpty == true
                    ? 'Something Went Wrong'
                    : controller.screenArgument?.errorMsg ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: () {
                if (controller.screenArgument?.errorCode ==
                    AppConstants.tokenExpireErrorCode) {
                  Get.find<UserAuthController>()
                      .signUserOut()
                      .then((value) => Navigator.of(context).pop('retry'));
                } else {
                  Navigator.of(context).pop('retry');
                }
              },
              child: Text(
                  controller.screenArgument?.errorCode == AppConstants.tokenExpireErrorCode
                      ? 'Continue As Guest'
                      : 'Try Again'),
            )
          ],
        ),
      ),
    );
  }
}



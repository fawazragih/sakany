import 'dart:io';

import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';
import 'store_closed_controller.dart';

class StoreClosedPage extends GetView<StoreClosedController> {
  static const routeName = '/app/store-closed';

  const StoreClosedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.lock_circle,
              size: 0.5.sw,
            ),
            const SizedBox(height: 15),
            Text(
              ConstStrings.STORE_CLOSED.translate,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.withBoldFont,
            ),
            const SizedBox(height: 10),
            Text(
              ConstStrings.STORE_CLOSED_HINT.translate,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium?.withBoldFont,
              // style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 15),
            IconButton(
              onPressed: () =>
                  !kIsWeb && Platform.isIOS ? exit(0) : SystemNavigator.pop(),
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
      ),
    );
  }
}

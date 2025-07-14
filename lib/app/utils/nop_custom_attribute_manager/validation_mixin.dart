import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';

mixin ValidationMixin {
  bool isValidEmailAddress(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  InputDecoration inputDecor(
    String labelTextKey,
    bool isRequired,
    BuildContext context,
  ) {
    return InputDecoration(
      constraints: BoxConstraints(minHeight: 30.h),
      // labelText: widget.labelText,
      // errorText: widget.errorText,
      contentPadding: EdgeInsets.all(16.0.r),
      // labelStyle: AppInputDecorationStyle.labelStyle,
      // hintStyle: AppInputDecorationStyle.hintStyle,
      alignLabelWithHint: true,
      // fillColor: widget.fillColor,
      filled: false,
      // suffixIcon: widget.suffixIcon,
      // prefixIcon: widget.prefixIcon,
      isDense: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          // color: primaryColor,
          width: 1.0.w,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      border: OutlineInputBorder(
        // borderSide: BorderSide(
        //   // color: ,
        //   width: 1.0,
        // ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      labelText: labelTextKey.translate,
      labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
            height: 1.5.h,
            fontSize: 14.sp,
            color: Theme.of(context).hintColor,
          ),
      suffixIcon: isRequired
          ? Icon(
              Icons.star,
              size: 12.r, /*color: Colors.black,*/
            )
          : null,
    );
  }
}

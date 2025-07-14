import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sakani/app/global_widget/all_form_widgets/date_picker_widget.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/modules/products_details_screen/products_details_controller.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:sakani/app/utils/nop_custom_attribute_manager/validation_mixin.dart';

class RentalSectionWidget extends GetWidget<ProductsDetailsController>
    with ValidationMixin {
  const RentalSectionWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    if (controller.productDetails!.isRental == false) {
      return Offstage();
    }

    final formKey = controller.rentalFormKey;

    /*final data = controller.productDetails!;
    final rentalStartDate = controller.rentalStartDate != null
        ? DateFormat('MM/dd/yyyy').format(controller.rentalStartDate!)
        : '';
    final rentalEndDate = controller.rentalEndDate != null
        ? DateFormat('MM/dd/yyyy').format(controller.rentalEndDate!)
        : '';*/

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ConstStrings.PRODUCT_RENT.translate,
          style: Theme.of(context).textTheme.bodySmall.withBoldFont,
        ),
        UiHelper.verticalSpaceSmallMedium,
        Form(
          key: formKey,
          child: Column(
            children: [
              DateTimePickerFormWidget(
                keyName: 'start',
                initialValue: controller.rentalStartDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                hintText: ConstStrings.PRODUCT_RENTAL_START.translate,
                isRequired: true,
                dateFormat: DateFormat('MM/dd/yyyy'),
                prefixIcon: Icon(
                  CupertinoIcons.calendar,
                  color: Theme.of(context).disabledColor,
                ),
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              DateTimePickerFormWidget(
                keyName: 'end',
                initialValue: controller.rentalEndDate,
                firstDate: (controller.rentalStartDate ?? DateTime.now()),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                hintText: ConstStrings.PRODUCT_RENTAL_END.translate,
                isRequired: true,
                prefixIcon: Icon(
                  CupertinoIcons.calendar,
                  color: Theme.of(context).disabledColor,
                ),
                dateFormat: DateFormat('MM/dd/yyyy'),
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              /*InputTextFieldWidget(
                  key: UniqueKey(),
                  keyName: '1',
                  textInputType: TextInputType.text,
                  // autofocus: false,
                  autoFocus: false,
                  readOnly: true,
                  initialValue: rentalStartDate,
                  isRequired: true,
                  // validator: (value) {
                  //   // if (data.isRental == true && (value == null || value.isEmpty)) {
                  //   //   return ConstStrings.IS_REQUIRED
                  //   //       .getStringWithNumberStr('');
                  //   // }
                  //   return null;
                  // },
                  onTap: () => _selectDate(true),
                  // textInputAction: TextInputAction.next,
                  hintText: ConstStrings.PRODUCT_RENTAL_START.translate,
                  // decoration: inputDecor(ConstStrings.PRODUCT_RENTAL_START, true, context),
                ),
                InputTextFieldWidget(
                  key: UniqueKey(),
                  readOnly: true,
                  keyName: '2',
                  textInputType: TextInputType.text,
                  autoFocus: false,
                  initialValue: rentalEndDate,
                  isRequired: true,
                  // validator: (value) {
                  //   if (data.isRental == true &&
                  //       (value == null || value.isEmpty)) {
                  //     return ConstStrings.IS_REQUIRED
                  //         .getStringWithNumberStr('');
                  //   }
                  //   return null;
                  // },
                  onTap: () => _selectDate(false),
                  // textInputAction: TextInputAction.done,
                  hintText: ConstStrings.PRODUCT_RENTAL_END.translate,
                  // decoration: inputDecor(ConstStrings.PRODUCT_RENTAL_END, true, context),
                )*/
            ].withSpaceBetween(
              height: 12.0,
            ),
          ),
        ),
      ],
    ).marginOnly(bottom: 16.h);
  }
}

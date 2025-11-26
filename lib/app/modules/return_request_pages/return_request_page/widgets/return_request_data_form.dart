import 'package:app_extensions/app_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamoily/app/data/models/return_request_response.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/drop_down_menu_form_field_widget.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/modules/return_request_pages/return_request_page/return_request_controller.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

import 'return_request_product_template.dart';

class ReturnRequestDataForm extends StatelessWidget {
  final ReturnRequestData? data;
  final ReturnRequestController controller;

  const ReturnRequestDataForm({
    super.key,
    this.data,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: SharedStyle.singleChildScrollViewHorizontalPadding
          .add(EdgeInsets.symmetric(vertical: 16.0.h)),
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ConstStrings.RETURN_REQ_TITLE_WHICH_ITEM.translate,
              style: Theme.of(context).textTheme.labelMedium.withBoldFont,
            ),
            UiHelper.verticalSpaceSmallMedium,
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: data?.items?.length ?? 0,
              itemBuilder: (context, index) {
                // return listItem(data?.items?[index]);
                var item = data?.items?[index];
                return ReturnRequestProductTemplate(
                  item: item,
                  onUpdateQty: (value) async {
                    // if (item?.id != null) {
                    //   setState(() {
                    //     if ((controller.quantityMap[item!.id!] ?? 0) > 0) {
                    //       controller.quantityMap[item.id!] = (controller.quantityMap[item.id] ?? 0) - 1;
                    //     }
                    //   });
                    // }
                    if (item?.id != null) {
                      controller.quantityMap[item!.id!] = value;
                      return true;
                    }
                    return false;
                  },
                );
              },
            ),
            UiHelper.verticalSpaceMedium,
            Text(
              ConstStrings.RETURN_REQ_TITLE_WHY.translate,
              style: Theme.of(context).textTheme.labelMedium.withBoldFont,
            ),
            UiHelper.verticalSpaceSmall,
            AppDropDownMenuFormFieldWidget<AvailableReturn?>(
              keyName: ConstStrings.RETURN_REQ_REASON,
              initialValue: controller.selectedReason,
              labelText: ConstStrings.RETURN_REQ_REASON.translate,
              hintText: ConstStrings.RETURN_REQ_REASON.translate,
              itemsList: data?.availableReturnReasons ?? [],
              getItemName: (value) => value?.name ?? '',
              onChanged: (value) => data?.returnRequestReasonId = value?.id ?? 0,
              onSaved: (value) => data?.returnRequestReasonId = value?.id ?? 0,
            ),
            UiHelper.verticalSpaceSmall,
            AppDropDownMenuFormFieldWidget<AvailableReturn?>(
              keyName: ConstStrings.RETURN_REQ_ACTION,
              labelText: ConstStrings.RETURN_REQ_ACTION.translate,
              hintText: ConstStrings.RETURN_REQ_ACTION.translate,
              initialValue: controller.selectedAction,
              itemsList: data?.availableReturnActions ?? [],
              getItemName: (value) => value?.name ?? '',
              onChanged: (value) {
                data?.returnRequestActionId = value?.id ?? 0;
              },
              onSaved: (value) {
                data?.returnRequestActionId = value?.id ?? 0;
              },
            ),
            if (data?.allowFiles ?? false) ...[
              Text(
                ConstStrings.RETURN_REQ_UPLOAD.translate,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.single;

                        // TODO update UI
                        // setState(() {
                        controller.selectedFileName = file.name;
                        // });

                        if (file.path != null) {
                          controller.uploadFile(file.path!);
                        }
                      }
                    },
                    child: Text(
                      ConstStrings.RETURN_REQ_UPLOAD_FILE.translate,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (controller.selectedFileName.isNotEmpty)
                    Flexible(
                      child: Text(
                        controller.selectedFileName,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 14.sp),
                      ),
                    )
                ],
              )
            ],
            const SizedBox(height: 15),
            InputTextFieldWidget(
              keyName: ConstStrings.RETURN_REQ_COMMENTS,
              labelText: ConstStrings.RETURN_REQ_COMMENTS.translate,
              hintText: ConstStrings.RETURN_REQ_COMMENTS.translate,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              autoFocus: false,
              validator: (value) => null,
              onChanged: (value) => data?.comments = value,
              initialValue: data?.comments ?? '',
              textInputAction: TextInputAction.done,
              isRequired: false,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/product_review_response.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/global_widget/all_form_widgets/input_text_field_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/all_form_widgets/rate_form_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/empty_data_widget.dart';
import 'package:sakani_mobile_app/app/global_widget/pagination_list_builder.dart';
import 'package:sakani_mobile_app/app/global_widget/shimmer_list.dart';
import 'package:sakani_mobile_app/app/routes/app_routs_and_pages.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';

import '../../core/language_and_localization/app_strings.dart';
import 'product_review_controller.dart';
import 'widgets/review_template_widget.dart';

class ProductReviewPage extends GetView<ProductReviewController> {
  static const String routeName = '/app/product-review/:product_id';

  static String navTo(String productId) =>
      '${routeName.removeParams}/$productId';

  const ProductReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: ConstStrings.TITLE_REVIEW.translate,
      ),
      body: GetBuilder<ProductReviewController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async => controller.pagingController.refresh(),
            child: PaginationListBuilder<ProductReviewItem>(
              pagingController: controller.pagingController,
              // shrinkWrap: true,
              newPageProgressIndicatorBuilder: AppReadyShimmerList(
                inGrid: false,
                horizontal: false,
                imageHeight: 180.0.h,
                containerWidth: double.infinity,
                itemCount: 2,
              ),
              emptyDataWidget: SizedBox(
                height: Get.height / 1.1,
                child: Center(
                  child: EmptyDataWidget(),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: SharedStyle.horizontalScreenPadding,
                vertical: 16,
              ),
              itemBuilder: (ProductReviewItem item, int index) {
                return ReviewsTemplateWidget(
                  review: item,
                  isByCurrentUser: false,
                  //isByCurrentUser: controller.userAuthController.currentUser. == item.customerId,
                  postHelpfulness: (value) {
                    if (item.helpfulness?.productReviewId != null) {
                      controller.postHelpfulness(
                        item.helpfulness!.productReviewId!,
                        isHelpful: value,
                      );
                    }
                  },
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<ProductReviewController>(
        id: controller.bottomNavigationBarId,
        builder: (controller) {
          return ActionButton(
            text: ConstStrings.REVIEW_WRITE.translate.toUpperCase(),
            onPressed: () {
              Get.bottomSheet(
                AddReviewDialog(controller: controller),
                isDismissible: true,
              );
            },
          );
        },
      ).marginOnly(
        bottom: SharedStyle.horizontalScreenPadding / 2,
        left: SharedStyle.horizontalScreenPadding,
        right: SharedStyle.horizontalScreenPadding,
      ),
    );
  }
}

class AddReviewDialog extends StatelessWidget {
  const AddReviewDialog({
    super.key,
    required this.controller,
  });

  final ProductReviewController controller;

  @override
  Widget build(BuildContext context) {
    final formData = controller.data?.generalInfo?.addProductReview;

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 16,
        ),
        child: Wrap(
          children: [
            FormBuilder(
              key: controller.formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextFieldWidget(
                      keyName: ConstStrings.REVIEW_TITLE,
                      keyboardType: TextInputType.name,
                      autoFocus: false,
                      isRequired: true,
                      requiredValidatorText:
                          ConstStrings.REVIEW_TITLE_REQ.translate,
                      onChanged: (value) => formData?.title = value,
                      initialValue: formData?.title ?? '',
                      textInputAction: TextInputAction.next,
                      labelText: ConstStrings.REVIEW_TITLE.translate,
                      hintText: ConstStrings.REVIEW_TITLE.translate,
                    ),
                    const SizedBox(height: 15),
                    InputTextFieldWidget(
                      keyName: ConstStrings.REVIEW_TEXT,
                      keyboardType: TextInputType.multiline,
                      labelText: ConstStrings.REVIEW_TEXT.translate,
                      hintText: ConstStrings.REVIEW_TEXT.translate,
                      autoFocus: false,
                      requiredValidatorText:
                          ConstStrings.REVIEW_TEXT_REQ.translate,
                      isRequired: true,
                      // minLines: 3,
                      maxLines: 3,
                      onChanged: (value) => formData?.reviewText = value,
                      initialValue: formData?.reviewText ?? '',
                      // decoration: inputDecor(Const.REVIEW_TEXT, true, context),
                    ),
                    const SizedBox(height: 15),
                    RatingFormFieldWidget(
                      keyName: 'reviewRate',
                      labelText: ConstStrings.REVIEW_RATING.translate,
                      isRequired: true,
                      initialValue: formData?.rating?.toDouble() ?? 0,
                      onChange: (value) {
                        formData?.rating = value?.round();
                      },
                    ),
                    const SizedBox(height: 15),
                    ActionButton(
                      onPressed: () {
                        if ((controller.formKey.currentState?.validate() ??
                                false) &&
                            formData != null) {
                          Navigator.of(context).pop();
                          controller.postReview(formData);
                        } else {
                          controller
                              .toastMessage(AppStrings.fillAllData.translate);
                        }
                      },
                      text: ConstStrings.REVIEW_SUBMIT_BTN.translate
                          .toUpperCase(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

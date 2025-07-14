import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/core/language_and_localization/app_strings.dart';
import 'package:sakani_mobile_app/app/data/models/get_billing_address_response.dart';
import 'package:sakani_mobile_app/app/data/models/order_details_response.dart';
import 'package:sakani_mobile_app/app/data/models/shopping_cart_response.dart';
import 'package:sakani_mobile_app/app/global_widget/action_buttons/action_button.dart';
import 'package:sakani_mobile_app/app/global_widget/app_bar_widgets/custom_app_bar.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/shared_style.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/modules/all_cart_modules/shopping_cart_page/widgets/order_total_table.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/products_details_view.dart';
import 'package:sakani_mobile_app/app/modules/products_details_screen/widgets/full_description_widget.dart';
import 'package:sakani_mobile_app/app/routes/app_routs_and_pages.dart';
import 'package:sakani_mobile_app/app/utils/constants/const_strings.dart';
import '../../../global_widget/screen_status_widgets.dart';
import 'order_details_controller.dart';

class OrderDetailsPage extends GetView<OrderDetailsController> {
  static const String routeName = '/app/order-details/:order_id';

  static String navToRoute(String id) => '${routeName.removeParams}/$id';

  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: ConstStrings.TITLE_ORDER_DETAILS.translate,
          ),
          /* body: controller.showRetryButton
              ? RetryWidget(
                  onRetry: controller.fetchOrderDetails,
                )
              : Skeletonizer(
                  enabled: controller.busy,
                  child: !controller.busy && controller.orderDetailsData == null
                      ? EmptyDataWidget()
                      : SingleChildScrollView(
                          padding: SharedStyle
                              .singleChildScrollViewHorizontalPadding,
                          child: Column(
                            children: [
                              UiHelper.verticalSpaceMedium,
                              //region orderInfoCard,
                              AppCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w,
                                    vertical: 12.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        CupertinoIcons.info,
                                      ),
                                      UiHelper.horizontalSpaceSmall,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TitleAndValueRow(
                                              title: ConstStrings
                                                  .ORDER_NUMBER.translate,
                                              value:
                                                  '${controller.orderDetailsData?.customOrderNumber}',
                                            ),
                                            TitleAndValueRow(
                                              title: ConstStrings
                                                  .ORDER_STATUS.translate,
                                              value:
                                                  '${controller.orderDetailsData?.orderStatus}',
                                            ),
                                            TitleAndValueRow(
                                              title: ConstStrings
                                                  .ORDER_DATE.translate,
                                              value:
                                                  '${controller.orderDetailsData?.createdOn?.toDateYMD}',
                                            ),
                                            TitleAndValueRow(
                                              title: ConstStrings
                                                  .ORDER_TOTAL.translate,
                                              value:
                                                  '${controller.orderDetailsData?.orderTotal}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              //endregion

                              //region billingAddressCard
                              if (controller.orderDetailsData?.billingAddress !=
                                  null)
                                AppCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w,
                                    vertical: 12.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                      ),
                                      UiHelper.horizontalSpaceSmall,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ConstStrings.BILLING_ADDRESS_TAB
                                                  .translate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  .withBoldFont,
                                            ),
                                            Text(
                                              controller
                                                      .orderDetailsData
                                                      ?.billingAddress
                                                      ?.getFormattedAddress ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              //endregion

                              //region shippingAddressCard,
                              if ((controller.orderDetailsData?.isShippable ??
                                      false) &&
                                  !(controller
                                          .orderDetailsData?.pickupInStore ??
                                      false))
                                AppCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w,
                                    vertical: 12.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.pin_drop_outlined,
                                      ),
                                      UiHelper.horizontalSpaceSmall,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ConstStrings.SHIPPING_ADDRESS_TAB
                                                  .translate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  .withBoldFont,
                                            ),
                                            Text(
                                              controller
                                                      .orderDetailsData
                                                      ?.shippingAddress
                                                      ?.getFormattedAddress ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              //endregion

                              //region storeAddressCard,
                              if (controller.orderDetailsData?.pickupInStore ??
                                  false)
                                AppCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w,
                                    vertical: 12.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.pin_drop_outlined,
                                      ),
                                      UiHelper.horizontalSpaceSmall,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ConstStrings.PICK_UP_POINT_ADDRESS
                                                  .translate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  .withBoldFont,
                                            ),
                                            Text(
                                              controller
                                                      .orderDetailsData
                                                      ?.pickupAddress
                                                      ?.getFormattedAddress ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              //endregion

                              //region shippingMethodCard,

                              AppCard(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w,
                                  vertical: 12.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.local_shipping_outlined),
                                    UiHelper.horizontalSpaceSmall,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TitleAndValueRow(
                                            title: ConstStrings
                                                .SHIPPING_METHOD.translate,
                                            value:
                                                '${controller.orderDetailsData?.shippingMethod}',
                                          ),
                                          TitleAndValueRow(
                                            title: AppStrings
                                                .shippingStatus.translate,
                                            value:
                                                '${controller.orderDetailsData?.shippingStatus}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //endregion

                              //region paymentMethodCard,
                              AppCard(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w,
                                  vertical: 12.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.payment_outlined),
                                    UiHelper.horizontalSpaceSmall,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TitleAndValueRow(
                                            title: ConstStrings
                                                .PAYMENT_METHOD.translate,
                                            value:
                                                '${controller.orderDetailsData?.paymentMethod}',
                                          ),
                                          TitleAndValueRow(
                                            title: AppStrings
                                                .paymentStatus.translate,
                                            value:
                                                '${controller.orderDetailsData?.paymentMethodStatus}',
                                          ),
                                          if (controller.orderDetailsData
                                                  ?.canRePostProcessPayment ??
                                              false)
                                            ActionButton(
                                              onPressed: () {
                                                controller.repostPayment(
                                                    controller.orderId!);
                                              },
                                              text: ConstStrings
                                                  .ORDER_RETRY_PAYMENT
                                                  .translate,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //endregion

                              //region selectedAttributesCard,
                              if (controller.orderDetailsData
                                      ?.showCheckoutAttributeInfo ==
                                  true)
                                AppCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w,
                                    vertical: 12.h,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ConstStrings
                                            .SELECTED_ATTRIBUTES.translate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            .withBoldFont,
                                      ),
                                      Html(
                                        data: controller.orderDetailsData
                                                ?.checkoutAttributeInfo ??
                                            '',
                                        style: htmlNoPaddingStyle(),
                                        onLinkTap: (
                                          String? url,
                                          Map<String, String> attributes,
                                          element,
                                        ) {},
                                      ),
                                    ],
                                  ),
                                ),
                              //endregion

                              //region shipments,
                              if (kDebugMode ||
                                  controller
                                          .orderDetailsData?.showShipmentInfo ==
                                      true)
                                AppCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w,
                                    vertical: 12.h,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ConstStrings.ORDER_SHIPMENT.translate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            .withBoldFont,
                                      ),
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.orderDetailsData
                                                  ?.shipments?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            var item = controller
                                                .orderDetailsData
                                                ?.shipments?[index];
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.0.h),
                                              child: Text(
                                                '${ConstStrings.ORDER_SHIPMENT_ID.translate} ${item?.id}\n'
                                                '${ConstStrings.SHIPMENT_TRACKING_NUMBER.translate}: ${item?.trackingNumber}\n'
                                                '${ConstStrings.ORDER_DATE_SHIPPED.translate}: '
                                                '${item?.shippedDate?.toDateYMDHMA}\n'
                                                '${ConstStrings.ORDER_DATE_DELIVERED.translate}: '
                                                '${item?.deliveryDate?.toDateYMDHMA}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    .withBoldFont,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              //endregion

                              //region notesCard,
                              if (kDebugMode ||
                                  controller.orderDetailsData?.showOrderNotes ==
                                      true)
                                AppCard(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0.w,
                                    vertical: 12.h,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ConstStrings.ORDER_NOTES.translate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            .withBoldFont,
                                      ),
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.orderDetailsData
                                              ?.orderNotes?.length,
                                          itemBuilder: (context, index) {
                                            var item = controller
                                                .orderDetailsData
                                                ?.orderNotes?[index];
                                            return ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                item?.note ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    .withBoldFont,
                                              ),
                                              subtitle: Text(
                                                DateTime.tryParse(
                                                            item?.createdOn ??
                                                                '')
                                                        ?.toDateYMDHMA ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              trailing: item?.hasDownload ==
                                                      true
                                                  ? InkWell(
                                                      child: const Icon(
                                                        CupertinoIcons
                                                            .arrow_down_to_line_alt,
                                                      ),
                                                      onTap: () {
                                                        if (item?.id == null)
                                                          return;

                                                        controller
                                                            .downloadNotesAttachment(
                                                          item!.id!,
                                                        );
                                                      })
                                                  : null,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              //endregion

                              //region cartItemsCard,
                              AppCard(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w,
                                  vertical: 12.h,
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller
                                      .orderDetailsData?.items?.length,
                                  itemBuilder: (context, index) {
                                    Item? item = controller
                                        .orderDetailsData?.items?[index];

                                    return InkWell(
                                      onTap: () => controller
                                          .navigateToProductDetails(item),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item?.productName ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                .withBoldFont,
                                          ),
                                          Text(
                                            '${ConstStrings.PRICE.translate}: ${item?.unitPrice}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                .withBoldFont,
                                          ),
                                        ].withSpaceBetween(
                                          height: 8.0.h,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              //endregion
                              const SizedBox(height: 10),
                              OrderTotalTable(
                                orderTotals: OrderTotals(
                                  displayTax:
                                      controller.orderDetailsData?.displayTax ??
                                          false,
                                  displayTaxRates: controller
                                          .orderDetailsData?.displayTaxRates ??
                                      false,
                                  giftCards:
                                      controller.orderDetailsData?.giftCards,
                                  hideShippingTotal: false,
                                  isEditable: false,
                                  orderTotal:
                                      controller.orderDetailsData?.orderTotal,
                                  orderTotalDiscount: controller
                                      .orderDetailsData?.orderTotalDiscount,
                                  paymentMethodAdditionalFee: controller
                                      .orderDetailsData
                                      ?.paymentMethodAdditionalFee,
                                  redeemedRewardPoints: controller
                                          .orderDetailsData
                                          ?.redeemedRewardPoints ??
                                      0,
                                  redeemedRewardPointsAmount: controller
                                      .orderDetailsData
                                      ?.redeemedRewardPointsAmount,
                                  requiresShipping: false,
                                  selectedShippingMethod: controller
                                      .orderDetailsData?.shippingMethod,
                                  shipping: controller
                                      .orderDetailsData?.orderShipping,
                                  subTotal: controller
                                          .orderDetailsData?.orderSubtotal ??
                                      "",
                                  subTotalDiscount: controller
                                      .orderDetailsData?.orderSubTotalDiscount,
                                  tax: controller.orderDetailsData?.tax,
                                  taxRates:
                                      controller.orderDetailsData?.taxRates,
                                  willEarnRewardPoints: null,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ].withSpaceBetween(
                              height: 12.h,
                            ),
                          ),
                        ),
                ),*/

          body: ScreenStatusWidgets(
            controller: controller,
            isEmpty: controller.orderDetailsData == null,
            onRetry: controller.fetchOrderDetails,
            dataWidget: SingleChildScrollView(
              padding: SharedStyle.singleChildScrollViewHorizontalPadding,
              child: Column(
                children: [
                  UiHelper.verticalSpaceMedium,
                  //region orderInfoCard,
                  AppCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.info,
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleAndValueRow(
                                  title: ConstStrings.ORDER_NUMBER.translate,
                                  value:
                                      '${controller.orderDetailsData?.customOrderNumber}',
                                ),
                                TitleAndValueRow(
                                  title: ConstStrings.ORDER_STATUS.translate,
                                  value:
                                      '${controller.orderDetailsData?.orderStatus}',
                                ),
                                TitleAndValueRow(
                                  title: ConstStrings.ORDER_DATE.translate,
                                  value:
                                      '${controller.orderDetailsData?.createdOn?.toDateYMD}',
                                ),
                                TitleAndValueRow(
                                  title: ConstStrings.ORDER_TOTAL.translate,
                                  value:
                                      '${controller.orderDetailsData?.orderTotal}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  //endregion

                  //region billingAddressCard
                  if (controller.orderDetailsData?.billingAddress != null)
                    AppCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ConstStrings.BILLING_ADDRESS_TAB.translate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      .withBoldFont,
                                ),
                                Text(
                                  controller.orderDetailsData?.billingAddress
                                          ?.getFormattedAddress ??
                                      '',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  //endregion

                  //region shippingAddressCard,
                  if ((controller.orderDetailsData?.isShippable ?? false) &&
                      !(controller.orderDetailsData?.pickupInStore ?? false))
                    AppCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ConstStrings.SHIPPING_ADDRESS_TAB.translate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      .withBoldFont,
                                ),
                                Text(
                                  controller.orderDetailsData?.shippingAddress
                                          ?.getFormattedAddress ??
                                      '',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  //endregion

                  //region storeAddressCard,
                  if (controller.orderDetailsData?.pickupInStore ?? false)
                    AppCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 12.h,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                          ),
                          UiHelper.horizontalSpaceSmall,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ConstStrings.PICK_UP_POINT_ADDRESS.translate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      .withBoldFont,
                                ),
                                Text(
                                  controller.orderDetailsData?.pickupAddress
                                          ?.getFormattedAddress ??
                                      '',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  //endregion

                  //region shippingMethodCard,

                  AppCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.local_shipping_outlined),
                        UiHelper.horizontalSpaceSmall,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleAndValueRow(
                                title: ConstStrings.SHIPPING_METHOD.translate,
                                value:
                                    '${controller.orderDetailsData?.shippingMethod}',
                              ),
                              TitleAndValueRow(
                                title: AppStrings.shippingStatus.translate,
                                value:
                                    '${controller.orderDetailsData?.shippingStatus}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //endregion

                  //region paymentMethodCard,
                  AppCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.payment_outlined),
                        UiHelper.horizontalSpaceSmall,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleAndValueRow(
                                title: ConstStrings.PAYMENT_METHOD.translate,
                                value:
                                    '${controller.orderDetailsData?.paymentMethod}',
                              ),
                              TitleAndValueRow(
                                title: AppStrings.paymentStatus.translate,
                                value:
                                    '${controller.orderDetailsData?.paymentMethodStatus}',
                              ),
                              if (controller.orderDetailsData
                                      ?.canRePostProcessPayment ??
                                  false)
                                ActionButton(
                                  onPressed: () {
                                    controller
                                        .repostPayment(controller.orderId!);
                                  },
                                  text: ConstStrings
                                      .ORDER_RETRY_PAYMENT.translate,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //endregion

                  //region selectedAttributesCard,
                  if (controller.orderDetailsData?.showCheckoutAttributeInfo ==
                      true)
                    AppCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.SELECTED_ATTRIBUTES.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                .withBoldFont,
                          ),
                          Html(
                            data: controller
                                    .orderDetailsData?.checkoutAttributeInfo ??
                                '',
                            style: htmlNoPaddingStyle(),
                            onLinkTap: (
                              String? url,
                              Map<String, String> attributes,
                              element,
                            ) {},
                          ),
                        ],
                      ),
                    ),
                  //endregion

                  //region shipments,
                  if (kDebugMode ||
                      controller.orderDetailsData?.showShipmentInfo == true)
                    AppCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.ORDER_SHIPMENT.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                .withBoldFont,
                          ),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller
                                      .orderDetailsData?.shipments?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                var item = controller
                                    .orderDetailsData?.shipments?[index];
                                return Padding(
                                  padding: EdgeInsets.only(top: 8.0.h),
                                  child: Text(
                                    '${ConstStrings.ORDER_SHIPMENT_ID.translate} ${item?.id}\n'
                                    '${ConstStrings.SHIPMENT_TRACKING_NUMBER.translate}: ${item?.trackingNumber}\n'
                                    '${ConstStrings.ORDER_DATE_SHIPPED.translate}: '
                                    '${item?.shippedDate?.toDateYMDHMA}\n'
                                    '${ConstStrings.ORDER_DATE_DELIVERED.translate}: '
                                    '${item?.deliveryDate?.toDateYMDHMA}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        .withBoldFont,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  //endregion

                  //region notesCard,
                  if (kDebugMode ||
                      controller.orderDetailsData?.showOrderNotes == true)
                    AppCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ConstStrings.ORDER_NOTES.translate,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                .withBoldFont,
                          ),
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller
                                  .orderDetailsData?.orderNotes?.length,
                              itemBuilder: (context, index) {
                                var item = controller
                                    .orderDetailsData?.orderNotes?[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    item?.note ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        .withBoldFont,
                                  ),
                                  subtitle: Text(
                                    DateTime.tryParse(item?.createdOn ?? '')
                                            ?.toDateYMDHMA ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  trailing: item?.hasDownload == true
                                      ? InkWell(
                                          child: const Icon(
                                            CupertinoIcons
                                                .arrow_down_to_line_alt,
                                          ),
                                          onTap: () {
                                            if (item?.id == null) return;
                                            controller.downloadNotesAttachment(
                                              item!.id!,
                                            );
                                          })
                                      : null,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  //endregion

                  //region cartItemsCard,
                  AppCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0.w,
                      vertical: 12.h,
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.orderDetailsData?.items?.length,
                      itemBuilder: (context, index) {
                        Item? item = controller.orderDetailsData?.items?[index];

                        return InkWell(
                          onTap: () =>
                              controller.navigateToProductDetails(item),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item?.productName ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    .withBoldFont,
                              ),
                              Text(
                                '${ConstStrings.PRICE.translate}: ${item?.unitPrice}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    .withBoldFont,
                              ),
                            ].withSpaceBetween(
                              height: 8.0.h,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //endregion
                  const SizedBox(height: 10),
                  OrderTotalTable(
                    orderTotals: OrderTotals(
                      displayTax:
                          controller.orderDetailsData?.displayTax ?? false,
                      displayTaxRates:
                          controller.orderDetailsData?.displayTaxRates ?? false,
                      giftCards: controller.orderDetailsData?.giftCards,
                      hideShippingTotal: false,
                      isEditable: false,
                      orderTotal: controller.orderDetailsData?.orderTotal,
                      orderTotalDiscount:
                          controller.orderDetailsData?.orderTotalDiscount,
                      paymentMethodAdditionalFee: controller
                          .orderDetailsData?.paymentMethodAdditionalFee,
                      redeemedRewardPoints:
                          controller.orderDetailsData?.redeemedRewardPoints ??
                              0,
                      redeemedRewardPointsAmount: controller
                          .orderDetailsData?.redeemedRewardPointsAmount,
                      requiresShipping: false,
                      selectedShippingMethod:
                          controller.orderDetailsData?.shippingMethod,
                      shipping: controller.orderDetailsData?.orderShipping,
                      subTotal:
                          controller.orderDetailsData?.orderSubtotal ?? "",
                      subTotalDiscount:
                          controller.orderDetailsData?.orderSubTotalDiscount,
                      tax: controller.orderDetailsData?.tax,
                      taxRates: controller.orderDetailsData?.taxRates,
                      willEarnRewardPoints: null,
                    ),
                  ),
                  const SizedBox(height: 20),
                ].withSpaceBetween(
                  height: 12.h,
                ),
              ),
            ),
          ),
          bottomNavigationBar: controller.busy || controller.showRetryButton
              ? null
              : Padding(
                  padding: SharedStyle.bottomNavigationPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          text: ConstStrings.ORDER_REORDER.translate
                              .toUpperCase(),
                          onPressed: () =>
                              controller.reorder(controller.orderId!),
                        ),
                      ),
                      controller.pdfLinkSink > -1
                          ? AppCard(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0.w,
                                vertical: 12.0.w,
                              ),
                              radius: 14.r,
                              margin: EdgeInsetsDirectional.only(start: 12.0.w),
                              withAlignment: false,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderColor:
                                  Theme.of(context).colorScheme.primary,
                              onTap: () async {
                                controller.downloadPdfInvoice(
                                  orderId: controller.pdfLinkSink,
                                );
                              },
                              child: Icon(
                                CupertinoIcons.arrow_down_doc_fill,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          : Offstage()
                    ],
                  ),
                ),
        );
      },
    );
  }
}

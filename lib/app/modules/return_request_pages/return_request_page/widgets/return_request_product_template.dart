import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamoily/app/base_controllers_and_listeners/helpers_methods.dart';
import 'package:tamoily/app/data/models/return_request_response.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/increment_and_decrement_buttons.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';

import '../../../../utils/constants/const_strings.dart';
import '../../../products_details_screen/products_details_view.dart';

class ReturnRequestProductTemplate extends StatelessWidget {
  final ReturnRequestProduct? item;
  final AsyncValueSetterAndGetter<int, bool> onUpdateQty;

  const ReturnRequestProductTemplate({
    super.key,
    this.item,
    required this.onUpdateQty,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      withAlignment: false,
      padding: EdgeInsets.symmetric(
        horizontal: 12.0.w,
        vertical: 12.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${item?.productName}',
            style: Theme.of(context).textTheme.labelMedium?.withBoldFont,
          ),
          UiHelper.verticalSpaceSmallMedium,
          TitleAndValueRow(
            title: ConstStrings.PRICE.translate,
            value: item?.unitPrice ?? '',
          ),

          Row(
            children: [
              Text(
                ConstStrings.RETURN_REQ_RETURN_QTY.translate,
                style: Theme.of(context).textTheme.labelMedium.withBoldFont,
              ),
              UiHelper.horizontalSpaceSmallMedium,
              Expanded(
                child: IncrementAndDecrementButtons(
                  key: Key('${item?.productId}-${item?.quantity}'),
                  qty: item?.quantity ?? 0,
                  onDecrement: onUpdateQty,
                  onIncrement: onUpdateQty,
                  iconBgColor: Theme.of(context).primaryColorDark,
                  iconColor: Theme.of(context).colorScheme.onPrimary,
                  iconSize: 22.0,
                  circularIcons: false,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  iconPadding: EdgeInsets.all(0),
                  textContentPadding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 6.w,
                  ),
                  loadingProgressSize: 20,
                ),
              ),
              Spacer(),
            ],
          ),

          // Row(
          //   children: [
          //     FloatingActionButton(
          //       child: const Icon(
          //         Icons.remove,
          //         size: 18.0,
          //       ),
          //       onPressed: () {
          //         if (item?.id != null) {
          //           setState(() {
          //             if ((controller.quantityMap[item!.id!] ?? 0) > 0) {
          //               controller.quantityMap[item.id!] =
          //                   (controller.quantityMap[item.id] ?? 0) - 1;
          //             }
          //           });
          //         }
          //       },
          //     ),
          //     const SizedBox(width: 15),
          //     Text('${controller.quantityMap[item?.id]}'),
          //     const SizedBox(width: 15),
          //     RoundButton(
          //       icon: const Icon(
          //         Icons.add,
          //         size: 18.0,
          //       ),
          //       radius: 35,
          //       onClick: () {
          //         if (item?.id != null) {
          //           setState(() {
          //             if ((controller.quantityMap[item?.id] ?? 0) < (item?.quantity ?? 0)) {
          //               controller.quantityMap[item!.id!] = (controller.quantityMap[item.id] ?? 0) + 1;
          //             }
          //           });
          //         }
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
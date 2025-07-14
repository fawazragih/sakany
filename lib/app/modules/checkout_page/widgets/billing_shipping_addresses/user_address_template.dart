import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakani_mobile_app/app/data/models/get_billing_address_response.dart';
import 'package:sakani_mobile_app/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';

class UserAddressTemplate extends StatelessWidget {
  final Address address;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const UserAddressTemplate({
    super.key,
    required this.address,
    required this.index,
    required this.onTap,
    required this.onDelete,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    // bool isSelected = controller.selectedID == address.id;
    return AppCard(
      hasBorder: false,
      margin: const EdgeInsets.only(
        bottom: 12.0,
      ),
      padding: EdgeInsets.zero,
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 12.0,
      //   vertical: 12.0,
      // ),
      color: isSelected ? Theme.of(context).colorScheme.secondary : null,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            UiHelper.verticalSpace(12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // textBaseline: TextBaseline.alphabetic,
              children: [
                CircleAvatar(
                  radius: 15.0,
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 18.0,
                  ),
                ),
                UiHelper.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        address.address1 ?? address.id?.toString() ?? '',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      // UiHelper.verticalSpaceTiny,
                      // Text(
                      //   address.address2 ?? '',
                      //   maxLines: 1,
                      //   style: Get.textTheme.bodySmall,
                      // ),
                      UiHelper.verticalSpaceTiny,
                      Text(
                        '📞 ${address.phoneNumber ?? ''}',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingSymmetric(
              horizontal: 12.0,
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.primary,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12),
                )),
                child: InkWell(
                  onTap: onDelete,
                  child: Icon(
                    Icons.delete,
                    size: 16.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ).paddingAll(
                    6.0,
                    // end: 6.0,
                    // start: 6.0,
                    // top: 6.0,
                    // bottom: 6.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani/app/data/models/get_billing_address_response.dart';
import 'package:sakani/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';

class ItemAddressList extends StatelessWidget {
  final Address address;
  final void Function(Address address) onEditClicked, onDeleteClicked;

  const ItemAddressList({
    super.key,
    required this.address,
    required this.onEditClicked,
    required this.onDeleteClicked,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(
        horizontal: 12.0.w,
        vertical: 12.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                    '${address.firstName ?? ''} ${address.lastName ?? ''}'),
              ),
              AppCard(
                padding: EdgeInsets.all(4.r),
                color: Theme.of(context).colorScheme.secondary,
                // hasBorder: false,
                borderWidth: 0.5,
                radius: 16.r,
                onTap: () => onEditClicked(address),
                child:  Icon(CupertinoIcons.pencil),
              ),
              UiHelper.horizontalSpaceVeryTiny,
              AppCard(
                padding: EdgeInsets.all(4.r),
                color: Theme.of(context).colorScheme.secondary,
                radius: 16.r,
                borderWidth: 0.5,
                // hasBorder: false,
                child:  Icon(CupertinoIcons.delete),
                onTap: () => onDeleteClicked(address),
              ),
            ],
          ),
          Text(address.getFormattedAddress),
          SizedBox(height: 5.h),
        ],
      ),
    );
  }
}

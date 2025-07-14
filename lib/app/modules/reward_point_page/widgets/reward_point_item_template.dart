import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani/app/data/models/reward_point_response.dart';
import 'package:sakani/app/global_widget/dashed_divider_widget.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import 'package:app_extensions/app_extensions.dart';

class ItemRewardPoint extends StatelessWidget {
  final RewardPoint? item;

  // final GlobalService _globalService = GlobalService();
  // final dateTimeFormat = 'MM/dd/yy hh:mm';

  const ItemRewardPoint({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.labelMedium?.withBoldFont;

    return AppCard(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ConstStrings.REWARD_POINT_DATE.translate,
                  style: textStyle,
                ),
              ),
              Expanded(
                child: Text(
                  item?.createdOn?.toDateYMDHMA ?? '',
                  style: textStyle,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          DashedDividerWidget(),
          Row(
            children: [
              Expanded(
                child: Text(
                  ConstStrings.REWARD_POINT_.translate,
                  style: textStyle,
                ),
              ),
              Expanded(
                child: Text(
                  item?.points?.toString() ?? '',
                  style: textStyle,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          DashedDividerWidget(),
          Row(
            children: [
              Expanded(
                child: Text(
                  ConstStrings.REWARD_POINT_BALANCE.translate,
                  style: textStyle,
                ),
              ),
              Expanded(
                child: Text(
                  item?.pointsBalance ?? '',
                  style: textStyle,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          DashedDividerWidget(),
          Row(
            children: [
              Expanded(
                child: Text(
                  ConstStrings.REWARD_POINT_MSG.translate,
                  style: textStyle,
                ),
              ),
              Expanded(
                child: Text(
                  item?.message ?? '',
                  style: textStyle,
                ),
              ),
            ],
          ),
          DashedDividerWidget(),
          Row(
            children: [
              Expanded(
                child: Text(
                  ConstStrings.REWARD_POINT_END_DATE.translate,
                  style: textStyle,
                ),
              ),
              Expanded(
                child: Text(
                  item?.endDate?.toDateYMDHMA ?? '',
                  style: textStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

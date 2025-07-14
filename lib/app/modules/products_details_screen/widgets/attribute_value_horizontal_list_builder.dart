import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakani_mobile_app/app/data/models/custom_attribute.dart';
import 'package:sakani_mobile_app/app/global_widget/horizontal_list_builder.dart';
import 'package:sakani_mobile_app/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import 'package:sakani_mobile_app/app/global_widget/my_card_design.dart';
import 'package:sakani_mobile_app/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';

class AttributeValueHorizontalListBuilder extends StatelessWidget {
  final CustomAttribute currentAttribute;
  final Map<int, List<AttributeValue>>? attrMap;

  // final bool isMultipleSelectionAllowed;
  // final bool isSelected;
  final ValueChanged<AttributeValue> onTap;

  const AttributeValueHorizontalListBuilder({
    super.key,
    required this.currentAttribute,
    this.attrMap,
    // required this.isMultipleSelectionAllowed,
    required this.onTap,
    // required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return HorizontalListBuilder(
      items: currentAttribute.values,
      itemCount: currentAttribute.values?.length ?? 0,
      widget: (value) {
        Widget? leading;
        if (currentAttribute.attributeControlType == AttributeControlType.ColorSquares) {
          logger.d('colorSquaresRgb=>${value.colorSquaresRgb}');
          leading = Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: (value.colorSquaresRgb).toColor,
              shape: BoxShape.circle,
            ),
          );
        } else if (currentAttribute.attributeControlType == AttributeControlType.ImageSquare) {
          leading = AppImageLoader(
           imageUrl: value.imageSquaresPictureModel?.imageUrl ?? 'http://',
            width: 50.w,
            height: 50.h,
          );
        }

        bool isSelected = attrMap?[currentAttribute.id]?.contains(value) == true;
        bool enabled = currentAttribute.attributeControlType !=
            AttributeControlType.ReadonlyCheckboxes;

        return AppCard(
          radius: 12,
          margin: EdgeInsetsDirectional.only(end: 8.0.w),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          // hasBorder: false,
          // borderColor: isSelected ? Theme.of(context).primaryColorDark : null,
          // borderColor: isSelected ? Theme.of(context).primaryColorLight : null,
          color: !enabled
              ? Theme.of(context).dividerColor
              : isSelected
                  ? Theme.of(context).colorScheme.primary
                  : null,
          onTap: !enabled ? null : () => onTap.call(value),
          child: Row(
            children: [
              if (leading != null) leading.paddingDirection(end: 8.0.w),
              Text(
                value.name ?? '',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    .withBoldFont
                    ?.copyWith(
                      color: !enabled ? Theme.of(context).disabledColor : null,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}

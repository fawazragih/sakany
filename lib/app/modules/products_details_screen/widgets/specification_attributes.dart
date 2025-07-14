import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/models/product_details_response.dart';
import '../products_details_controller.dart';

class SpecificationAttributes extends GetWidget<ProductsDetailsController> {
  const SpecificationAttributes({
    super.key,
  });

  bool get populateSpecificationAttributes {
    return controller.productDetails?.productSpecificationModel?.groups !=
            null &&
        controller.productDetails?.productSpecificationModel?.groups
                ?.any((element) => element.attributes?.isNotEmpty == true) !=
            null;
  }

  @override
  Widget build(BuildContext context) {
    // logger.f(populateSpecificationAttributes);
    if (populateSpecificationAttributes) {
      final List<Group> groups =
          controller.productDetails!.productSpecificationModel!.groups!;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < groups.length; i++)
            for (int j = 0; j < (groups[i].attributes?.length ?? 0); j++)
              SpecificationAttributeItem(attribute: groups[i].attributes![j])
        ],
      ).marginOnly(bottom: 16.h);
    }

    return Offstage();
  }
}

class SpecificationAttributeItem extends StatelessWidget {
  final SpecificationAttr attribute;

  const SpecificationAttributeItem({super.key, required this.attribute});

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context).textTheme.bodySmall?.withBoldFont;

    return Row(
      children: [
        if (attribute.name.isNotNullOrEmpty)
          Text('${attribute.name} :', style: titleStyle),
        Expanded(
          flex: 2,
          child: Html(data: attribute.values?.firstOrNull?.valueRaw ?? ''),
        ),
      ],
    );
  }
}

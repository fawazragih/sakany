import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:tamoily/app/data/models/price_range_filter.dart';
import 'package:tamoily/app/global_widget/all_form_widgets/input_text_field_widget.dart';

import '../../../../global_widget/app_ui_helper/ui_helpers.dart';
import '../../../../utils/constants/const_strings.dart';

class PriceRangeFilterWidget extends StatefulWidget {
  // final double min;
  // final double max;
  final TextEditingController txtMin;
  final TextEditingController txtMax;
  final PriceRangeFilter priceRangeFilter;

  const PriceRangeFilterWidget({
    super.key,
    required this.priceRangeFilter,
    required this.txtMin,
    required this.txtMax,
  });

  @override
  State<PriceRangeFilterWidget> createState() => _PriceRangeFilterWidgetState();
}

class _PriceRangeFilterWidgetState extends State<PriceRangeFilterWidget> {
  late TextEditingController txtMin;
  late TextEditingController txtMax;
  RangeValues? _currentRangeValues;

  late double min = widget.priceRangeFilter.availablePriceRange?.from ?? 0;
  late double max = widget.priceRangeFilter.availablePriceRange?.to ?? 0;

  @override
  void initState() {
    super.initState();
    txtMin = widget.txtMin;
    txtMax = widget.txtMax;
    // if (showPriceRangeFilter) {
    _currentRangeValues = RangeValues(
      widget.priceRangeFilter.selectedPriceRange?.from?.toDouble() ?? 0,
      widget.priceRangeFilter.selectedPriceRange?.to?.toDouble() ?? 0,
    );

    txtMin.text =
        widget.priceRangeFilter.selectedPriceRange?.from?.round().toString() ??
            '';

    txtMax.text =
        widget.priceRangeFilter.selectedPriceRange?.to?.round().toString() ??
            '0';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${ConstStrings.FILTER_PRICE_RANGE.translate} :',
          style: Theme.of(context).textTheme.bodySmall?.withBoldFont,
        ),
        UiHelper.verticalSpaceMedium,
        Row(
          children: [
            Text('Min ${min.round()}'),
            const Spacer(),
            Text('Max ${max.round()}'),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
            allowedInteraction: SliderInteraction.tapAndSlide,
            // overlayShape: SliderComponentShape.noThumb,
          ),
          child: RangeSlider(
            values: _currentRangeValues ?? RangeValues(min, max),
            min: min,
            max: max,
            // overlayColor: WidgetStateProperty.all(Colors.red),
            activeColor: Theme.of(context).primaryColorDark,
            labels: RangeLabels(
              _currentRangeValues?.start.round().toString() ?? '0',
              _currentRangeValues?.end.round().toString() ?? '0',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                txtMin.text = values.start.round().toString();
                txtMax.text = values.end.round().toString();
              });
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InputTextFieldWidget(
                keyName: '',
                controller: txtMin,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                // decoration: const InputDecoration(
                //   focusedBorder: InputBorder.none,
                //   enabledBorder: InputBorder.none,
                //   hintText: '0',
                // ),
                // onEditingComplete: () {
                //   logger.f('message');
                //   setState(() {
                //     FocusScope.of(context).unfocus();
                //     _currentRangeValues = RangeValues(double.parse(txtMin.text), double.parse(txtMax.text));
                //   });
                // },
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Expanded(
              child: InputTextFieldWidget(
                keyName: '',
                controller: txtMax,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                // decoration: const InputDecoration(
                //   focusedBorder: InputBorder.none,
                //   enabledBorder: InputBorder.none,
                //   border:
                //   hintText: '0',
                // ),
                // onEditingComplete: () {
                //   setState(() {
                //     FocusScope.of(context).unfocus();
                //     _currentRangeValues = RangeValues(
                //         double.parse(txtMin.text), double.parse(txtMax.text));
                //   });
                // },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import '../base_controllers_and_listeners/helpers_methods.dart';
import '../core/language_and_localization/app_strings.dart';
import '../utils/constants/const_strings.dart';
import 'app_ui_helper/different_dialogs.dart';
import 'app_ui_helper/ui_helpers.dart';

class IncrementAndDecrementButtons extends StatefulWidget {
  final Color? color;
  final int qty;
  final int? maxIncrease;
  final double iconSize;
  final double? loadingProgressSize;
  final Color? loadingProgressColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final EdgeInsetsGeometry? textContentPadding;
  final Color? iconBgColor;
  final bool initLoadingIncrement;
  final bool showIconInInkWell;
  final bool inColumn;
  final bool circularIcons;
  final MainAxisAlignment? mainAxisAlignment;
  final AsyncValueSetterAndGetter<int, bool> onDecrement;
  final AsyncValueSetterAndGetter<int, bool> onIncrement;
  final AsyncValueGetter<bool>? onDelete;

  const IncrementAndDecrementButtons({
    super.key,
    required this.onDecrement,
    this.color,
    required this.onIncrement,
    this.qty = 0,
    this.onDelete,
    this.maxIncrease,
    this.showIconInInkWell = true,
    this.inColumn = false,
    this.iconSize = 28,
    this.mainAxisAlignment,
    this.iconColor,
    this.iconBgColor,
    this.circularIcons = true,
    this.loadingProgressSize,
    this.loadingProgressColor,
    this.initLoadingIncrement = false,
    this.iconPadding,
    this.textContentPadding,
  });

  @override
  State<IncrementAndDecrementButtons> createState() =>
      _IncrementAndDecrementButtonsState();
}

class _IncrementAndDecrementButtonsState
    extends State<IncrementAndDecrementButtons> {
  int qty = 0;
  bool _increment = false;
  bool _decrement = false;
  bool _removing = false;

  int tempQty = 0;

  set increment(bool value) {
    if (mounted) {
      setState(() {
        _increment = value;
      });
    }
  }

  set decrement(bool value) {
    if (mounted) {
      setState(() {
        _decrement = value;
      });
    }
  }

  set removing(bool value) {
    if (mounted) {
      setState(() {
        _removing = value;
      });
    }
    // logger.d('done remove');
  }

  @override
  void initState() {
    super.initState();
    _increment = widget.initLoadingIncrement;
    qty = widget.qty;
    tempQty = qty;
  }

  final _debounce = Debouncer(
    delay: const Duration(milliseconds: 500),
  );

  @override
  Widget build(BuildContext context) {
    var widgetList = [
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _decrement
            ? UiHelper.spinKitProgressIndicator(
                size: widget.loadingProgressSize,
                color: widget.loadingProgressColor,
              )
            : _AddOrRemoveIconButton(
                iconColor: widget.iconColor,
                iconBgColor: widget.iconBgColor,
                iconData: widget.circularIcons
                    ? Icons.remove_circle_outline_rounded
                    : Icons.remove,
                inInkWell: widget.showIconInInkWell,
                iconSize: widget.iconSize,
                padding: widget.iconPadding,
                onTap: () {
                  tempQty = tempQty - 1;
                  _debounce.call(() async {
                    if (tempQty < 1) {
                      tempQty = qty;
                      DifferentDialogs.toastMessage(
                          message:
                              '${ConstStrings.PRODUCT_QUANTITY_POSITIVE.translate.capitalizeFirst!} 1');
                      qty = 1;
                      tempQty = 1;
                    }

                    decrement = true;
                    if (tempQty < 1) {
                      tempQty = 0;
                    }
                    bool result = await widget.onDecrement(tempQty);
                    if (result) {
                      qty = tempQty;
                    }
                    decrement = false;
                  });
                },
              ),
      ),
      Flexible(
        child: TextField(
          readOnly: true,
          keyboardType: TextInputType.number,
          autofocus: false,
          onChanged: (value) {
            //TODO handle change quantity
            // setState(() {
            //   data.addToCart?.enteredQuantity = int.parse(value);
            // });
          },
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyMedium?.withBoldFont,
          decoration: InputDecoration(
            border: InputBorder.none ?? OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            enabledBorder: InputBorder.none?? OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
            contentPadding: widget.textContentPadding ?? EdgeInsets.zero,
            isDense: true,
            hintText: _increment || _decrement ? '...' : qty.toString(),
          ),
        ),
      ),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _increment
            ? UiHelper.spinKitProgressIndicator(
          size: widget.loadingProgressSize,
          color: widget.loadingProgressColor,
        )
            : _AddOrRemoveIconButton(
                padding: widget.iconPadding,
                iconColor: widget.iconColor,
                iconBgColor: widget.iconBgColor,
                iconData: widget.circularIcons
                    ? Icons.add_circle_outline_rounded
                    : Icons.add,
                iconSize: widget.iconSize,
                inInkWell: widget.showIconInInkWell,
                onTap: () {
                  tempQty = tempQty + 1;
                  _debounce.call(() async {
                    if (widget.maxIncrease != null &&
                        tempQty >= widget.maxIncrease!) {
                      tempQty = qty;
                      DifferentDialogs.toastMessage(
                        message:
                            '${AppStrings.cantAddMoreThan.tr.capitalizeFirst!} ${widget.maxIncrease}',
                      );
                      tempQty = widget.maxIncrease!;
                      qty = widget.maxIncrease!;
                    }

                    increment = true;
                    bool result = await widget.onIncrement(tempQty);
                    if (result) {
                      qty = tempQty;
                    }
                    increment = false;
                  });
                },
              ),
      ),
      if (widget.onDelete != null && !widget.inColumn)
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _removing
              ? UiHelper.horizontalSpaceSpinKitProgressIndicator(
            size: widget.loadingProgressSize,
            color: widget.loadingProgressColor,
          )
              : /*widget.inColumn
                  ? AppIconButton(
                      iconColor: widget.iconColor,
                      iconBgColor: widget.iconBgColor,
                      iconData: Icons.delete_outline_outlined,
                      iconSize: widget.iconSize,
                      inInkWell: widget.showIconInInkWell,
                      onTap: _onDeleteTap,
                    )
                  :*/
              RawChip(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                  onPressed: _onDeleteTap,
                  label: Text(
                    AppStrings.removeFromCart.tr.capitalizeFirst!,
                  ),
                  avatar: Icon(
                    Icons.delete_outline_outlined,
                    color: Get.theme.colorScheme.secondary,
                    size: 20,
                  ),
                  backgroundColor: Colors.transparent,
                ),
        ),
    ];

    return widget.inColumn
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgetList.reversed.toList(),
          )
        : Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
            children: widgetList,
          );
  }

  void _onDeleteTap() async {
    removing = true;
    var result = await widget.onDelete?.call();
    if (result != null && result) {
      qty = tempQty;
    }
    removing = false;
  }

  @override
  void didUpdateWidget(covariant IncrementAndDecrementButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initLoadingIncrement != oldWidget.initLoadingIncrement) {
      increment = widget.initLoadingIncrement;
    }
  }
}

class _AddOrRemoveIconButton extends StatelessWidget {
  final IconData iconData;
  final double iconSize;
  final Color? iconColor;
  final Color? iconBgColor;
  final EdgeInsetsGeometry? padding;
  final bool inInkWell;
  final VoidCallback onTap;

  const _AddOrRemoveIconButton({
    required this.iconData,
    required this.onTap,
    this.iconSize = 24,
    this.inInkWell = false,
    this.iconColor,
    this.iconBgColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return inInkWell
        ? Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const CircleBorder(),
            color: iconBgColor ?? Theme.of(context).colorScheme.primary,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: padding ?? const EdgeInsets.all(8.0),
                child: Icon(
                  iconData,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            ),
          )
        : IconButton(
            visualDensity: VisualDensity.comfortable,
            padding: EdgeInsets.zero,
            icon: Icon(
              iconData,
              size: iconSize,
              color: iconColor,
            ),
            onPressed: onTap,
          );
  }
}

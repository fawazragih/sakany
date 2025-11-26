import 'package:app_extensions/app_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamoily/app/core/language_and_localization/app_strings.dart';
import 'package:tamoily/app/data/models/custom_attribute.dart';
import 'package:tamoily/app/data/models/requestbody/form_value.dart';
import 'package:tamoily/app/global_widget/app_ui_helper/ui_helpers.dart';
import 'package:tamoily/app/global_widget/my_card_design.dart';
import 'package:tamoily/app/utils/api_env_config/app_logger_config.dart';
import '../../../utils/nop_custom_attribute_manager/custom_attribute_manager.dart';
import '../../../utils/nop_custom_attribute_manager/validation_mixin.dart';
import 'attribute_value_horizontal_list_builder.dart';

class ProductCustomAttributes2 extends StatefulWidget {
  final List<CustomAttribute>? attributes;
  final List<int>? disabledAttributeIds;

  final String attributePrefix;

  final Function(PlatformFile file, int attributeId)? onFileSelected;

  final Function(bool, List<FormValue>)? onClick;

  const ProductCustomAttributes2({
    super.key,
    this.attributes,
    this.disabledAttributeIds,
    this.onClick,
    this.onFileSelected,
    required this.attributePrefix,
  });

  @override
  State<ProductCustomAttributes2> createState() =>
      _ProductCustomAttributesState2();
}

class _ProductCustomAttributesState2 extends State<ProductCustomAttributes2>
    with ValidationMixin {
  List<CustomAttribute>? attributes;
  List<int>? disabledAttributeIds;

  static const KEY_DATE_PICKER_ATTRIBUTE = -3;
  static const KEY_TEXT_ATTRIBUTE = -1;
  static const KEY_FILE_ATTRIBUTE = -2;

  Map<int, List<AttributeValue>>? _attrMap = {};

  // map attribute ID to uploaded file's GUID
  final Map<num, String> _fileGuidMap = {};

  // map attribute ID to selected date
  final Map<int, DateTime> _dateTimeMap = {};

  @override
  void initState() {
    super.initState();
    attributes = widget.attributes;
    // var d = CustomAttribute.fromJson(json.decode(json.encode(testMap)));
    // attributes?.add(d);
    disabledAttributeIds = widget.disabledAttributeIds;
  }

  @override
  Widget build(BuildContext context) {
    // logger.d('attributes are=>${widget.attributes?.length}');
    // logger.d('attributes are=>${attributes?.map((e) => e.toJson())}');
    if (attributes?.isEmpty ?? false) {
      return const SizedBox.shrink();
    }

    // populate preselected attributes
    if (_attrMap == null || _attrMap?.isEmpty == true) {
      _attrMap = <int, List<AttributeValue>>{};

      attributes?.forEach((attribute) {
        List<AttributeValue> selectedValue = [];

        attribute.values?.forEach((element) {
          if (element.isPreSelected == true) selectedValue.add(element);
        });

        logger.d(selectedValue);

        if (attribute.id != null) {
          _attrMap?[attribute.id!] = selectedValue;
        }
        //TxODO: handle else case
      });
    }

    List<Widget> listings = [];

    listings.add(Divider());

    for (final currentAttribute in attributes!) {
      if (disabledAttributeIds?.contains(currentAttribute.id) == true) {
        //remove disabledAttributeIds
        continue;
      }

      // logger.d('currentAttribute.attributeControlType=>${currentAttribute.attributeControlType}');

      Widget attributeView;

      switch (currentAttribute.attributeControlType) {
        //region Checkboxes,ReadonlyCheckboxes,DropdownList,ImageSquare...
        case AttributeControlType.Checkboxes:
        case AttributeControlType.ReadonlyCheckboxes:
        case AttributeControlType.DropdownList:
        case AttributeControlType.ImageSquare:
        case AttributeControlType.ColorSquares:
        case AttributeControlType.RadioList:
          String subtitleOfPreSelected = '';

          _attrMap?[currentAttribute.id]?.forEach((AttributeValue element) {
            subtitleOfPreSelected =
                '$subtitleOfPreSelected, ${element.name ?? ''}';
          });

          // logger.d(subtitleOfPreSelected);

          subtitleOfPreSelected = subtitleOfPreSelected.replaceFirst(', ', '');

          // attributeView = ListTile(
          //   contentPadding: EdgeInsets.only(right: 5.0.w),
          //   title: Row(
          //     children: [
          //       Text(
          //           currentAttribute.textPrompt ?? currentAttribute.name ?? ''),
          //       if (currentAttribute.isRequired ?? false)
          //         SizedBox(
          //           width: 10.w,
          //         ),
          //       if (currentAttribute.isRequired ?? false) ...[
          //         SizedBox(
          //           width: 8.w,
          //         ),
          //         Icon(
          //           Icons.star,
          //           size: 13.r,
          //           // color: Colors.red,
          //         ),
          //       ]
          //     ],
          //   ),
          //   subtitle: (subtitleOfPreSelected.isNotEmpty)
          //       ? Text(subtitleOfPreSelected)
          //       : null,
          //   trailing: Icon(
          //     Icons.arrow_forward_ios_sharp,
          //     size: 15.r,
          //   ),
          //   onTap: () =>
          //       {_settingModalBottomSheet(context, currentAttribute, _attrMap)},
          // );

          attributeView = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(currentAttribute.textPrompt ?? currentAttribute.name ?? ''),
              UiHelper.verticalSpaceSmallMedium,
              // getAttributeValueWidget(currentAttribute),
              AttributeValueHorizontalListBuilder(
                attrMap: _attrMap,
                currentAttribute: currentAttribute,
                onTap: (value) {
                  bool isSelected =
                      _attrMap?[currentAttribute.id]?.contains(value) == true;
                  if (isSelected) {
                    _attrMap?[currentAttribute.id]?.remove(value);
                  } else {
                    // if (currentAttribute.attributeControlType != null && !isMultipleSelectionAllowed(currentAttribute.attributeControlType!.toInt())) {
                    if (!currentAttribute.isMultipleSelectionAllowed) {
                      _attrMap?[currentAttribute.id]?.clear();
                    }

                    _attrMap?[currentAttribute.id]?.add(value);
                  }

                  var priceAdjNeeded = false;

                  currentAttribute.values?.forEach((element) {
                    if (element.priceAdjustment?.isNotEmpty == true) {
                      priceAdjNeeded = true;
                    }
                  });

                  if (widget.onClick != null) {
                    widget.onClick!(priceAdjNeeded, getSelectedAttributes());
                  }
                },
              ),
            ],
          );
          break;
        //endregion

        //region TextBox
        case AttributeControlType.TextBox:
        case AttributeControlType.MultilineTextbox:
          if (currentAttribute.defaultValue?.isNotNullOrEmpty == true) {
            _attrMap?[currentAttribute.id]?.add(
              AttributeValue(
                  id: KEY_TEXT_ATTRIBUTE, name: currentAttribute.defaultValue),
            );
          }
          attributeView = TextFormField(
            initialValue: currentAttribute.defaultValue ?? '',
            maxLines: currentAttribute.attributeControlType ==
                    AttributeControlType.TextBox
                ? 1
                : 3,
            keyboardType: currentAttribute.attributeControlType ==
                    AttributeControlType.TextBox
                ? TextInputType.text
                : TextInputType.multiline,
            textInputAction: currentAttribute.attributeControlType ==
                    AttributeControlType.TextBox
                ? TextInputAction.done
                : TextInputAction.newline,
            validator: (value) {
              if (currentAttribute.isRequired == true) {
                return AppStrings.thisFieldIsRequired.tr.capitalizeFirst!;
              }
              return null;
            },
            // decoration: inputDecor(
            //     currentAttribute.textPrompt ?? currentAttribute.name ?? '',
            //     currentAttribute.isRequired ?? false,context),
            style: Theme.of(context).textTheme.labelSmall.withBoldFont,
            decoration: InputDecoration(
              labelText:
                  currentAttribute.textPrompt ?? currentAttribute.name ?? '',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),

            onChanged: (value) {
              _attrMap?[currentAttribute.id]?.clear();
              _attrMap?[currentAttribute.id]?.add(
                AttributeValue(id: KEY_TEXT_ATTRIBUTE, name: value),
              );
            },
          );
          break;
        //endregion

        //region dateTimePicker
        case AttributeControlType.Datepicker:
          // set initialValue to map
          if (currentAttribute.selectedDay != null &&
              currentAttribute.selectedMonth != null &&
              currentAttribute.selectedYear != null) {
            _attrMap?[currentAttribute.id]
                ?.add(AttributeValue(id: KEY_DATE_PICKER_ATTRIBUTE));
            var date = DateTime(
                currentAttribute.selectedYear!.toInt(),
                currentAttribute.selectedMonth!.toInt(),
                currentAttribute.selectedDay!.toInt());
            if (currentAttribute.id != null) {
              _dateTimeMap[currentAttribute.id!] = date;
            }
          }

          attributeView = TextFormField(
            key: UniqueKey(),
            keyboardType: TextInputType.text,
            autofocus: false,
            readOnly: true,
            initialValue: _dateTimeMap.containsKey(currentAttribute.id)
                ? _dateTimeMap[currentAttribute.id]?.toDateYMD
                : '',
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _dateTimeMap.containsKey(currentAttribute.id)
                    ? _dateTimeMap[currentAttribute.id]
                    : DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2050),
              );

              if (pickedDate != null && currentAttribute.id != null) {
                // To show selected date on TextField
                _attrMap?[currentAttribute.id]?.clear();
                _attrMap?[currentAttribute.id]?.add(
                  AttributeValue(id: KEY_DATE_PICKER_ATTRIBUTE),
                );
                _dateTimeMap[currentAttribute.id!] = pickedDate;
                widget.onClick!(false, getSelectedAttributes());
              }
            },
            decoration: InputDecoration(
              labelText:
                  currentAttribute.textPrompt ?? currentAttribute.name ?? '',
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (currentAttribute.isRequired == true) {
                return AppStrings.thisFieldIsRequired.tr.capitalizeFirst!;
              }
              return null;
            },
          );
          break;
        //endregion

        //TODO handle file upload flow
        //region fileUpload
        case AttributeControlType.FileUpload:
          String subtitle =
              _attrMap?[currentAttribute.id]?.firstOrNull?.name ?? '';

          attributeView = AppCard(
            // withShadow: false,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentAttribute.textPrompt ??
                            currentAttribute.name ??
                            '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ).marginOnly(bottom: 2.0),
                      if (subtitle.isNotNullOrEmpty) Text(subtitle),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 16,
                ),
              ],
            ),
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null &&
                  widget.onFileSelected != null &&
                  currentAttribute.id != null) {
                PlatformFile file = result.files.single;

                // To show selected file as Subtitle
                _attrMap?[currentAttribute.id]?.clear();
                _attrMap?[currentAttribute.id]?.add(
                  AttributeValue(id: KEY_FILE_ATTRIBUTE, name: file.name),
                );
                if (widget.onClick != null) {
                  widget.onClick!(false, getSelectedAttributes());
                }
                if (widget.onFileSelected != null) {
                  widget.onFileSelected!(file, currentAttribute.id!);
                }
              }
            },
          );

          break;
        //endregion

        default:
          attributeView = const Offstage();
          break;
      }

      listings.add(attributeView);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5.w, 0, 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listings.withSpaceBetween(
          height: 16.0.h,
          includeBeforFirst: false,
          includeAfterLast: false,
        ),
      ),
    );
  }

  List<FormValue> getSelectedAttributes() {
    String attributePrefix = widget.attributePrefix;

    List<FormValue> formValues = [];

    _attrMap?.forEach((mapKey, mapValue) {
      for (var element in mapValue) {
        if (element.id == KEY_TEXT_ATTRIBUTE) {
          formValues.add(FormValue(
            key: '${attributePrefix}_${mapKey.toString()}',
            value: element.name,
          ));
        } else if (element.id == KEY_FILE_ATTRIBUTE) {
          var attributeValue =
              _fileGuidMap.containsKey(mapKey) ? _fileGuidMap[mapKey] : '';

          formValues.add(FormValue(
            key: '${attributePrefix}_${mapKey.toString()}',
            value: attributeValue,
            // file: element.file,
          ));
        } else if (element.id == KEY_DATE_PICKER_ATTRIBUTE) {
          var date =
              _dateTimeMap.containsKey(mapKey) ? _dateTimeMap[mapKey] : null;

          if (date != null) {
            formValues.add(FormValue(
              key: '${attributePrefix}_${mapKey.toString()}_day',
              value: date.day.toString(),
            ));

            formValues.add(FormValue(
              key: '${attributePrefix}_${mapKey.toString()}_month',
              value: date.month.toString(),
            ));

            formValues.add(FormValue(
              key: '${attributePrefix}_${mapKey.toString()}_year',
              value: date.year.toString(),
            ));
          }
        } else {
          formValues.add(FormValue(
            key: '${attributePrefix}_${mapKey.toString()}',
            value: element.id.toString(),
          ));
        }
      }
    });

    return formValues;
  }

/*  Widget getAttributeValueWidget(
    CustomAttribute currentAttribute,
  ) {
    return HorizontalListBuilder(
      items: currentAttribute.values,
      itemCount: currentAttribute.values?.length ?? 0,
      widget: (value) {
        var name = Text(value.name ?? '');
        Widget? leading;
        if (currentAttribute.attributeControlType ==
            AttributeControlType.ColorSquares) {
          logger.d('colorSquaresRgb=>${value.colorSquaresRgb}');
          leading = Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: (value.colorSquaresRgb).toColor,
              shape: BoxShape.circle,
            ),
          );
        } else if (currentAttribute.attributeControlType ==
            AttributeControlType.ImageSquare) {
          leading = AppImageLoader.network(
            value.imageSquaresPictureModel?.imageUrl ?? 'http://',
            width: 50.w,
            height: 50.h,
          );
        }

        bool isSelected =
            _attrMap?[currentAttribute.id]?.contains(value) == true;
        bool enabled = currentAttribute.attributeControlType !=
            AttributeControlType.ReadonlyCheckboxes;
        return AppCard(
          radius: 12,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
          color: !enabled
              ? Theme.of(context).dividerColor
              : isSelected
                  ? Theme.of(context).colorScheme.primary
                  : null,
          onTap: !enabled
              ? null
              : () {
                  if (isSelected) {
                    _attrMap?[currentAttribute.id]?.remove(value);
                  } else {
                    // if (currentAttribute.attributeControlType != null && !isMultipleSelectionAllowed(currentAttribute.attributeControlType!.toInt())) {
                    if (!currentAttribute.isMultipleSelectionAllowed) {
                      _attrMap?[currentAttribute.id]?.clear();
                    }

                    _attrMap?[currentAttribute.id]?.add(value);
                  }

                  var priceAdjNeeded = false;

                  currentAttribute.values?.forEach((element) {
                    if (element.priceAdjustment?.isNotEmpty == true) {
                      priceAdjNeeded = true;
                    }
                  });

                  if (widget.onClick != null) {
                    widget.onClick!(priceAdjNeeded, getSelectedAttributes());
                  }
                },
          child: Row(
            children: [
              if (leading != null) leading,
              name,
            ],
          ),
        );
      },
    );
  }*/

/*
  void _settingModalBottomSheet(
    context,
    CustomAttribute attribute,
    Map<num, List<AttributeValue>>? attrMap,
  ) {
    List<Widget> listings = [];

    attribute.values?.forEach((AttributeValue element) {
      Widget? leading;
      if (attribute.attributeControlType == AttributeControlType.ColorSquares) {
        //TODO: handle the right default color here
        leading = Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
              color: (element.colorSquaresRgb).toColor, shape: BoxShape.circle),
        );
      } else if (attribute.attributeControlType ==
          AttributeControlType.ImageSquare) {
        leading = AppImageLoader.network(
          element.imageSquaresPictureModel?.imageUrl ?? 'http://',
          width: 50.w,
          height: 50.h,
        );
      }

      listings.add(
        ListTile(
          leading: leading,
          title: Text(
            (element.name ?? '') +
                (element.priceAdjustment?.isNotEmpty == true
                    ? ' (${element.priceAdjustment})'
                    : ''),
            style: const TextStyle(),
          ),
          trailing: attrMap?[attribute.id]?.contains(element) ?? false
              ? const Icon(
                  Icons.check_sharp,
                  size: 20,
                )
              : null,
          onTap: () {
            if (attrMap?[attribute.id]?.contains(element) ?? false) {
              attrMap?[attribute.id]?.remove(element);
            } else {
              if (attribute.attributeControlType != null &&
                  !isMultipleSelectionAllowed(
                      attribute.attributeControlType!.toInt())) {
                attrMap?[attribute.id]?.clear();
              }

              attrMap?[attribute.id]?.add(element);
            }

            var priceAdjNeeded = false;

            attribute.values?.forEach((element) {
              if (element.priceAdjustment?.isNotEmpty == true) {
                priceAdjNeeded = true;
              }
            });
            Navigator.of(context).pop();

            if (widget.onClick != null) {
              widget.onClick!(priceAdjNeeded, getSelectedAttributes());
            }
          },
          enabled: attribute.attributeControlType !=
              AttributeControlType.ReadonlyCheckboxes,
          selected: attrMap?[attribute.id]?.contains(element) ?? false,
        ),
      );
    });

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (context, setState) {
            return ScrollViewWithScrollBar(
              child: Wrap(
                children: listings,
              ),
            );
          });
        });
  }
  */
}

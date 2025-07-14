import 'package:app_extensions/app_extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sakani/app/data/models/custom_attribute.dart';
import 'package:sakani/app/data/models/requestbody/form_value.dart';
import 'package:sakani/app/global_widget/images_and_videos_widgets/app_image_loader.dart';
import 'package:sakani/app/global_widget/my_card_design.dart';
import 'package:sakani/app/modules/home_page/widgets/product_box/scrollview_with_scrollbar.dart';
import 'package:sakani/app/modules/products_details_screen/widgets/attribute_value_horizontal_list_builder.dart';
import 'package:sakani/app/utils/constants/const_strings.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../global_widget/app_ui_helper/ui_helpers.dart';
import 'validation_mixin.dart';

//TODO use eint AttributeControlType
/*eint AttributeControlType {
   dropdownList  (1),
   radioList  (2),
   checkboxes  (3),
   textBox  (4),
   multilineTextbox  (10),
   datePicker  (20),
   fileUpload  (30),
   colorSquares  (40),
   imageSquare  (45),
   readonlyCheckboxes  (50);

   final int value;

  const AttributeControlType(this.value);


}*/

class AttributeControlType {
  static const DropdownList = 1;
  static const RadioList = 2;
  static const Checkboxes = 3;
  static const TextBox = 4;
  static const MultilineTextbox = 10;
  static const Datepicker = 20;
  static const FileUpload = 30;
  static const ColorSquares = 40;
  static const ImageSquare = 45;
  static const ReadonlyCheckboxes = 50;
}

class CustomAttributeManager with ValidationMixin {
  Map<int, List<AttributeValue>>? _attrMap;
  final Map<int, String> _fileGuidMap =
      {}; // map attribute ID to uploaded file's GUID
  final Map<int, DateTime> _dateTimeMap =
      {}; // map attribute ID to selected date

  final BuildContext? context;
  final Function(bool)? onClick;
  final Function(PlatformFile file, int attributeId)? onFileSelected;

  static const KEY_TEXT_ATTRIBUTE = -1;
  static const KEY_FILE_ATTRIBUTE = -2;
  static const KEY_DATE_PICKER_ATTRIBUTE = -3;

  CustomAttributeManager({this.context, this.onClick, this.onFileSelected});

  Widget populateCustomAttributes(
      List<CustomAttribute>? attributes, BuildContext context,
      {List<int>? disabledAttributeIds}) {
    if (attributes?.isEmpty ?? false) {
      return const SizedBox.shrink();
    }

    // populate preselected attributes
    if (_attrMap == null) {
      _attrMap = <int, List<AttributeValue>>{};
      attributes?.forEach((attribute) {
        List<AttributeValue> selectedValue = [];
        attribute.values?.forEach((element) {
          if (element.isPreSelected ?? false) selectedValue.add(element);
        });
        if (attribute.id != null) {
          _attrMap?[attribute.id!] = selectedValue;
        }
        //TODO: handle else case
      });
    }

    List<Widget> listings = [];
    listings.add(Divider(color: Colors.grey[300]));

    // for (final attribute in attributes!) {
    //   if (disabledAttributeIds?.contains(attribute.id) == true) {
    //     continue;
    //   }
    //
    //   Widget attributeView;
    //
    //   switch (attribute.attributeControlType) {
    //     case AttributeControlType.Checkboxes:
    //     case AttributeControlType.ReadonlyCheckboxes:
    //     case AttributeControlType.DropdownList:
    //     case AttributeControlType.ImageSquare:
    //     case AttributeControlType.ColorSquares:
    //     case AttributeControlType.RadioList:
    //       String subtitle = '';
    //       _attrMap?[attribute.id]?.forEach((element) {
    //         subtitle = '$subtitle, ${element.name ?? ''}';
    //       });
    //
    //       subtitle = subtitle.replaceFirst(', ', '');
    //
    //       attributeView = ListTile(
    //           contentPadding: EdgeInsets.only(right: 5.0.w),
    //           title: Row(
    //             children: [
    //               Text(attribute.textPrompt ?? attribute.name ?? ''),
    //               // if (attribute.isRequired ?? false)
    //               //   SizedBox(
    //               //     width: 10.w,
    //               //   ),
    //               if (attribute.isRequired ?? false) ...[
    //                 SizedBox(
    //                   width: 8.w,
    //                 ),
    //                 Icon(
    //                   Icons.star,
    //                   size: 13.r,
    //                   // color: Colors.red,
    //                 ),
    //               ]
    //             ],
    //           ),
    //           subtitle: (subtitle.isNotEmpty) ? Text(subtitle) : null,
    //           trailing: Icon(
    //             Icons.arrow_forward_ios_sharp,
    //             size: 15.r,
    //           ),
    //           onTap: () => {_settingModalBottomSheet(context, attribute)});
    //       break;
    //
    //     case AttributeControlType.TextBox:
    //     case AttributeControlType.MultilineTextbox:
    //       // set initialValue to map
    //       if (attribute.defaultValue?.isNotEmpty == true) {
    //         _attrMap?[attribute.id]?.add(
    //           AttributeValue(
    //               id: KEY_TEXT_ATTRIBUTE, name: attribute.defaultValue),
    //         );
    //       }
    //       attributeView = TextFormField(
    //         initialValue: attribute.defaultValue ?? '',
    //         maxLines:
    //             attribute.attributeControlType == AttributeControlType.TextBox
    //                 ? 1
    //                 : 3,
    //         keyboardType:
    //             attribute.attributeControlType == AttributeControlType.TextBox
    //                 ? TextInputType.text
    //                 : TextInputType.multiline,
    //         textInputAction:
    //             attribute.attributeControlType == AttributeControlType.TextBox
    //                 ? TextInputAction.done
    //                 : TextInputAction.newline,
    //         decoration: inputDecor(attribute.textPrompt ?? attribute.name ?? '',
    //             attribute.isRequired ?? false, context),
    //         onChanged: (value) {
    //           _attrMap?[attribute.id]?.clear();
    //           _attrMap?[attribute.id]?.add(
    //             AttributeValue(id: KEY_TEXT_ATTRIBUTE, name: value),
    //           );
    //         },
    //       );
    //       break;
    //
    //     case AttributeControlType.Datepicker:
    //       // set initialValue to map
    //       if (attribute.selectedDay != null &&
    //           attribute.selectedMonth != null &&
    //           attribute.selectedYear != null) {
    //         _attrMap?[attribute.id]?.add(
    //           AttributeValue(id: KEY_DATE_PICKER_ATTRIBUTE),
    //         );
    //         var date = DateTime(
    //             attribute.selectedYear!.toInt(),
    //             attribute.selectedMonth!.toInt(),
    //             attribute.selectedDay!.toInt());
    //         if (attribute.id != null) _dateTimeMap[attribute.id!] = date;
    //       }
    //
    //       attributeView = TextFormField(
    //         key: UniqueKey(),
    //         keyboardType: TextInputType.text,
    //         autofocus: false,
    //         readOnly: true,
    //         initialValue: _dateTimeMap.containsKey(attribute.id)
    //             ? getFormattedDate(_dateTimeMap[attribute.id])
    //             : '',
    //         validator: (value) {
    //           return null;
    //         },
    //         onTap: () async {
    //           final DateTime? pickedDate = await showDatePicker(
    //             context: context,
    //             initialDate: _dateTimeMap.containsKey(attribute.id)
    //                 ? _dateTimeMap[attribute.id]
    //                 : DateTime.now(),
    //             firstDate: DateTime(1950),
    //             lastDate: DateTime(2050),
    //           );
    //
    //           if (pickedDate != null && attribute.id != null) {
    //             // To show selected date on TextField
    //             _attrMap?[attribute.id]?.clear();
    //             _attrMap?[attribute.id]?.add(
    //               AttributeValue(id: KEY_DATE_PICKER_ATTRIBUTE),
    //             );
    //             _dateTimeMap[attribute.id!] = pickedDate;
    //             onClick!(false);
    //           }
    //         },
    //         textInputAction: TextInputAction.done,
    //         decoration: inputDecor(attribute.textPrompt ?? attribute.name ?? '',
    //             attribute.isRequired ?? false, context),
    //       );
    //       break;
    //
    //     case AttributeControlType.FileUpload:
    //       String subtitle = _attrMap?[attribute.id]?.firstOrNull?.name ?? '';
    //
    //       attributeView = ListTile(
    //         contentPadding: EdgeInsets.only(right: 5.0.w),
    //         title: Row(
    //           children: [
    //             Flexible(
    //                 child: Text(attribute.textPrompt ?? attribute.name ?? '')),
    //             if (attribute.isRequired ?? false)
    //               SizedBox(
    //                 width: 10.w,
    //               ),
    //             if (attribute.isRequired ?? false)
    //               const Icon(
    //                 Icons.star,
    //                 size: 13,
    //                 color: Colors.red,
    //               ),
    //           ],
    //         ),
    //         subtitle: Text(subtitle),
    //         trailing: const Icon(
    //           Icons.arrow_forward_ios_sharp,
    //           size: 15,
    //         ),
    //         onTap: () async {
    //           FilePickerResult? result = await FilePicker.platform.pickFiles();
    //
    //           if (result != null &&
    //               onFileSelected != null &&
    //               attribute.id != null) {
    //             PlatformFile file = result.files.single;
    //
    //             // To show selected file as Subtitle
    //             _attrMap?[attribute.id]?.clear();
    //             _attrMap?[attribute.id]?.add(
    //               AttributeValue(id: KEY_FILE_ATTRIBUTE, name: file.name),
    //             );
    //             if (onClick != null) onClick!(false);
    //             if (onFileSelected != null) {
    //               onFileSelected!(file, attribute.id!);
    //             }
    //           }
    //         },
    //       );
    //       break;
    //
    //     default:
    //       attributeView = const SizedBox.shrink();
    //       break;
    //   }
    //
    //   listings.add(attributeView);
    // }

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

                  if (onClick != null) {
                    onClick!(priceAdjNeeded);
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
                onClick!(false);
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
                  onFileSelected != null &&
                  currentAttribute.id != null) {
                PlatformFile file = result.files.single;

                // To show selected file as Subtitle
                _attrMap?[currentAttribute.id]?.clear();
                _attrMap?[currentAttribute.id]?.add(
                  AttributeValue(id: KEY_FILE_ATTRIBUTE, name: file.name),
                );
                if (onClick != null) {
                  onClick!(false);
                }
                if (onFileSelected != null) {
                  onFileSelected!(file, currentAttribute.id!);
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

    listings.add(Divider(color: Colors.grey[300]));

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

  void _settingModalBottomSheet(context, CustomAttribute attribute) {
    List<Widget> listings = [];

    attribute.values?.forEach((element) {
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
        leading = AppImageLoader(
          imageUrl: element.imageSquaresPictureModel?.imageUrl ?? 'http://',
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
          trailing: _attrMap?[attribute.id]?.contains(element) ?? false
              ? const Icon(
                  Icons.check_sharp,
                  size: 20,
                )
              : null,
          onTap: () {
            if (_attrMap?[attribute.id]?.contains(element) ?? false) {
              _attrMap?[attribute.id]?.remove(element);
            } else {
              if (attribute.attributeControlType != null &&
                  !isMultipleSelectionAllowed(
                      attribute.attributeControlType!.toInt())) {
                _attrMap?[attribute.id]?.clear();
              }

              _attrMap?[attribute.id]?.add(element);
            }

            var priceAdjNeeded = false;

            attribute.values?.forEach((element) {
              if (element.priceAdjustment?.isNotEmpty == true) {
                priceAdjNeeded = true;
              }
            });
            Navigator.of(context).pop();

            if (onClick != null) onClick!(priceAdjNeeded);
          },
          enabled: attribute.attributeControlType !=
              AttributeControlType.ReadonlyCheckboxes,
          selected: _attrMap?[attribute.id]?.contains(element) ?? false,
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

  bool isMultipleSelectionAllowed(int attributeControlType) {
    switch (attributeControlType) {
      case AttributeControlType.DropdownList:
      case AttributeControlType.ImageSquare:
      case AttributeControlType.ColorSquares:
      case AttributeControlType.RadioList:
        return false;
    }
    return true;
  }

  List<FormValue> getSelectedAttributes(String attributePrefix) {
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

  void addUploadedFileGuid(int attributeId, String guid) {
    _fileGuidMap[attributeId] = guid;
  }

  String checkRequiredAttributes(List<CustomAttribute> attributes) {
    String errorMsg = '';
    for (var attribute in attributes) {
      if ((attribute.isRequired ?? false) &&
          (_attrMap?[attribute.id]?.isEmpty ?? false)) {
        errorMsg =
            '$errorMsg ${ConstStrings.IS_REQUIRED.getStringWithNumberStr(attribute.textPrompt ?? attribute.name ?? '')}';
        errorMsg =
            '$errorMsg ${attribute.textPrompt ?? attribute.name} ${ConstStrings.IS_REQUIRED.translate}';
      }
    }
    return errorMsg.trimRight();
  }
}

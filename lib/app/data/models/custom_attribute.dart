import 'package:tamoily/app/utils/nop_custom_attribute_manager/custom_attribute_manager.dart';

import 'picture_model.dart';
import 'custom_properties.dart';

class CustomAttribute {
  CustomAttribute({
    this.productId,
    this.productAttributeId,
    this.name,
    this.description,
    this.textPrompt,
    this.isRequired,
    this.defaultValue,
    this.selectedDay,
    this.selectedMonth,
    this.selectedYear,
    this.hasCondition,
    this.allowedFileExtensions,
    this.attributeControlType,
    this.values,
    this.id,
    this.customProperties,
  });

  int? productId;
  int? productAttributeId;
  String? name;
  String? description;
  String? textPrompt;
  bool? isRequired;
  String? defaultValue;
  num? selectedDay;
  num? selectedMonth;
  num? selectedYear;
  bool? hasCondition;
  List<dynamic>? allowedFileExtensions;
  int? attributeControlType;
  List<AttributeValue>? values;
  int? id;
  CustomProperties? customProperties;

  bool get isMultipleSelectionAllowed {
    if (attributeControlType == null) {
      return false;
    }

    switch (attributeControlType) {
      case AttributeControlType.DropdownList:
      case AttributeControlType.ImageSquare:
      case AttributeControlType.ColorSquares:
      case AttributeControlType.RadioList:
        return false;
    }
    return true;
  }

  factory CustomAttribute.fromJson(Map<String, dynamic> json) =>
      CustomAttribute(
        productId: json["ProductId"],
        productAttributeId: json["ProductAttributeId"],
        name: json["Name"],
        description: json["Description"],
        textPrompt: json["TextPrompt"],
        isRequired: json["IsRequired"],
        defaultValue: json["DefaultValue"],
        selectedDay: json["SelectedDay"],
        selectedMonth: json["SelectedMonth"],
        selectedYear: json["SelectedYear"],
        hasCondition: json["HasCondition"],
        allowedFileExtensions: json["AllowedFileExtensions"] == null
            ? null
            : List<dynamic>.from(json["AllowedFileExtensions"]!.map((x) => x)),
        attributeControlType: json["AttributeControlType"],
        values: json["Values"] == null
            ? null
            : List<AttributeValue>.from(
                json["Values"]!.map((x) => AttributeValue.fromJson(x))),
        id: int.tryParse(json["Id"].toString()),
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "ProductAttributeId": productAttributeId,
        "Name": name,
        "Description": description,
        "TextPrompt": textPrompt,
        "IsRequired": isRequired,
        "DefaultValue": defaultValue,
        "SelectedDay": selectedDay,
        "SelectedMonth": selectedMonth,
        "SelectedYear": selectedYear,
        "HasCondition": hasCondition,
        "AllowedFileExtensions": allowedFileExtensions == null
            ? null
            : List<dynamic>.from(allowedFileExtensions!.map((x) => x)),
        "AttributeControlType": attributeControlType,
        "Values": List<dynamic>.from(values!.map((x) => x.toJson())),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

class AttributeValue {
  AttributeValue({
    this.name,
    this.colorSquaresRgb,
    this.imageSquaresPictureModel,
    this.priceAdjustment,
    this.priceAdjustmentUsePercentage,
    this.priceAdjustmentValue,
    this.isPreSelected,
    this.pictureId,
    this.customerEntersQty,
    this.quantity,
    this.id,
    this.customProperties,
  });

  String? name;
  String? colorSquaresRgb;
  PictureModel? imageSquaresPictureModel;
  String? priceAdjustment;
  bool? priceAdjustmentUsePercentage;
  double? priceAdjustmentValue;
  bool? isPreSelected;
  num? pictureId;
  bool? customerEntersQty;
  num? quantity;
  num? id;
  CustomProperties? customProperties;


  factory AttributeValue.fromJson(Map<String, dynamic> json) => AttributeValue(
        name: json["Name"],
        colorSquaresRgb: json["ColorSquaresRgb"],
        imageSquaresPictureModel: json["ImageSquaresPictureModel"] == null
            ? null
            : PictureModel.fromJson(json["ImageSquaresPictureModel"]),
        priceAdjustment: json["PriceAdjustment"],
        priceAdjustmentUsePercentage: json["PriceAdjustmentUsePercentage"],
        priceAdjustmentValue: json["PriceAdjustmentValue"],
        isPreSelected: json["IsPreSelected"],
        pictureId: json["PictureId"],
        customerEntersQty: json["CustomerEntersQty"],
        quantity: json["Quantity"],
        id: json["Id"],
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "ColorSquaresRgb": colorSquaresRgb,
        "ImageSquaresPictureModel": imageSquaresPictureModel?.toJson(),
        "PriceAdjustment": priceAdjustment,
        "PriceAdjustmentUsePercentage": priceAdjustmentUsePercentage,
        "PriceAdjustmentValue": priceAdjustmentValue,
        "IsPreSelected": isPreSelected,
        "PictureId": pictureId,
        "CustomerEntersQty": customerEntersQty,
        "Quantity": quantity,
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };
}

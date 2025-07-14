import 'custom_properties.dart';

class ManufacturerFilter {
  ManufacturerFilter({
    this.enabled,
    this.manufacturers,
    this.customProperties,
  });

  bool? enabled;
  List<AvailableSortOption>? manufacturers;
  CustomProperties? customProperties;

  factory ManufacturerFilter.fromJson(Map<String, dynamic> json) =>
      ManufacturerFilter(
        enabled: json["Enabled"],
        manufacturers: json["Manufacturers"] == null
            ? null
            : List<AvailableSortOption>.from(json["Manufacturers"]!
                .map((x) => AvailableSortOption.fromJson(x))),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory ManufacturerFilter.fake() => ManufacturerFilter(
        enabled: true,
        manufacturers: [
          AvailableSortOption.fake(),
          AvailableSortOption.fake(),
        ],
      );

  Map<String, dynamic> toJson() => {
        "Enabled": enabled,
        "Manufacturers": manufacturers == null
            ? null
            : List<dynamic>.from(manufacturers!.map((x) => x.toJson())),
        "CustomProperties": customProperties?.toJson(),
      };
}

class AvailableSortOption {
  AvailableSortOption({
    this.disabled,
    this.group,
    this.selected,
    this.text,
    this.value,
  });

  bool? disabled;
  dynamic group;
  bool? selected;
  String? text;
  String? value;

  factory AvailableSortOption.fromJson(Map<String, dynamic> json) =>
      AvailableSortOption(
        disabled: json["Disabled"],
        group: json["Group"],
        selected: json["Selected"],
        text: json["Text"],
        value: json["Value"],
      );

  factory AvailableSortOption.fake() => AvailableSortOption(
        disabled: false,
        group: "Group 1",
        selected: true,
        text: "Manufacturer 1",
        value: "manufacturer1",
      );

  get id => null;

  Map<String, dynamic> toJson() => {
        "Disabled": disabled,
        "Group": group,
        "Selected": selected,
        "Text": text,
        "Value": value,
      };
}

/*
from ManufacturerResponse
class ManufacturerFilter {
  ManufacturerFilter({
    this.enabled,
    this.manufacturers,
    this.customProperties,
  });

  bool? enabled;
  List<dynamic>? manufacturers;
  CustomProperties? customProperties;

  factory ManufacturerFilter.fromJson(Map<String, dynamic> json) => ManufacturerFilter(
    enabled: json["Enabled"],
    manufacturers: json["Manufacturers"] == null
        ? null
        : List<dynamic>.from(json["Manufacturers"]!.map((x) => x)),
    customProperties: json["CustomProperties"] == null
        ? null
        : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "Enabled": enabled,
    "Manufacturers": manufacturers == null
        ? null
        : List<dynamic>.from(manufacturers!.map((x) => x)),
    "CustomProperties":
    customProperties?.toJson(),
  };
}*/

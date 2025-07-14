import 'custom_properties.dart';

class PriceRangeFilter {
  PriceRangeFilter({
    this.enabled,
    this.selectedPriceRange,
    this.availablePriceRange,
    this.customProperties,
  });

  bool? enabled;
  PriceRange? selectedPriceRange;
  PriceRange? availablePriceRange;
  CustomProperties? customProperties;

  factory PriceRangeFilter.fromJson(Map<String, dynamic> json) =>
      PriceRangeFilter(
        enabled: json["Enabled"],
        selectedPriceRange: json["SelectedPriceRange"] == null
            ? null
            : PriceRange.fromJson(json["SelectedPriceRange"]),
        availablePriceRange: json["AvailablePriceRange"] == null
            ? null
            : PriceRange.fromJson(json["AvailablePriceRange"]),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory PriceRangeFilter.fake() => PriceRangeFilter(
        enabled: true,
        selectedPriceRange: PriceRange.fake(),
        availablePriceRange: PriceRange.fake(),
      );

  Map<String, dynamic> toJson() => {
        "Enabled": enabled,
        "SelectedPriceRange": selectedPriceRange?.toJson(),
        "AvailablePriceRange": availablePriceRange?.toJson(),
        "CustomProperties": customProperties?.toJson(),
      };
}

class PriceRange {
  PriceRange({
    this.from,
    this.to,
    this.customProperties,
  });

  double? from;
  double? to;
  CustomProperties? customProperties;

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        from: double.tryParse(json["From"].toString()),
        to: double.tryParse(json["To"].toString()),
        customProperties: CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory PriceRange.fake() => PriceRange(
        from: 0.0,
        to: 100.0,
      );

  Map<String, dynamic> toJson() => {
        "From": from,
        "To": to,
        "CustomProperties": customProperties?.toJson(),
      };
}

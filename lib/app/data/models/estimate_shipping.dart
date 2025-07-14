
import 'available_option.dart';
import 'custom_properties.dart';

class EstimateShipping {
  EstimateShipping({
    this.productId,
    this.requestDelay,
    this.enabled,
    this.countryId,
    this.stateProvinceId,
    this.zipPostalCode,
    this.useCity,
    this.city,
    this.availableCountries,
    this.availableStates,
    this.customProperties,
  });

  num? productId;
  int? requestDelay;
  bool? enabled;
  int? countryId;
  int? stateProvinceId;
  String? zipPostalCode;
  bool? useCity;
  String? city;
  List<AvailableOption>? availableCountries;
  List<AvailableOption>? availableStates;
  CustomProperties? customProperties;

  EstimateShipping copyWith({
    num? productId,
    int? requestDelay,
    bool? enabled,
    int? countryId,
    int? stateProvinceId,
    String? zipPostalCode,
    bool? useCity,
    String? city,
    List<AvailableOption>? availableCountries,
    List<AvailableOption>? availableStates,
    CustomProperties? customProperties,
  }) =>
      EstimateShipping(
        productId: productId ?? this.productId,
        requestDelay: requestDelay ?? this.requestDelay,
        enabled: enabled ?? this.enabled,
        countryId: countryId ?? this.countryId,
        stateProvinceId: stateProvinceId ?? this.stateProvinceId,
        zipPostalCode: zipPostalCode ?? this.zipPostalCode,
        useCity: useCity ?? this.useCity,
        city: city ?? this.city,
        availableCountries: availableCountries ?? this.availableCountries,
        availableStates: availableStates ?? this.availableStates,
        customProperties: customProperties ?? this.customProperties,
      );

  factory EstimateShipping.fromJson(Map<String, dynamic> json) => EstimateShipping(
    productId: json["ProductId"],
    requestDelay: json["RequestDelay"],
    enabled: json["Enabled"],
    countryId: json["CountryId"],
    stateProvinceId: json["StateProvinceId"],
    zipPostalCode: json["ZipPostalCode"],
    useCity: json["UseCity"],
    city: json["City"],
        availableCountries: json["AvailableCountries"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableCountries"]!
                .map((x) => AvailableOption.fromJson(x))),
        availableStates: json["AvailableStates"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableStates"]!
                .map((x) => AvailableOption.fromJson(x))),
        customProperties: json["CustomProperties"] == null ? null : CustomProperties.fromJson(json["CustomProperties"]),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "RequestDelay": requestDelay,
    "Enabled": enabled,
    "CountryId": countryId,
    "StateProvinceId": stateProvinceId,
    "ZipPostalCode": zipPostalCode,
    "UseCity": useCity,
    "City": city,
        "AvailableCountries": availableCountries == null
            ? null
            : List<dynamic>.from(availableCountries!.map((x) => x.toJson())),
        "AvailableStates": availableStates == null
            ? null
            : List<dynamic>.from(availableStates!.map((x) => x.toJson())),
        "CustomProperties":
            customProperties?.toJson(),
      };
}
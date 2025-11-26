import 'package:tamoily/app/global_widget/all_form_widgets/location_picker_from_widget/models/location_address_model.dart';
import 'package:tamoily/app/utils/constants/const_strings.dart';

import 'available_option.dart';
import 'custom_attribute.dart';
import 'custom_properties.dart';

// class GetBillingAddressResponse {
//   GetBillingAddressResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   GetBillingData? data;
//   String? message;
//   List<String>? errorList;
//
//   factory GetBillingAddressResponse.fromJson(Map<String, dynamic> json) =>
//       GetBillingAddressResponse(
//         data:
//             json["Data"] == null ? null : GetBillingData.fromJson(json["Data"]),
//         message: json["Message"],
//         errorList: json["ErrorList"] == null
//             ? null
//             : List<String>.from(json["ErrorList"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Data": data?.toJson(),
//         "Message": message,
//         "ErrorList": errorList == null
//             ? null
//             : List<dynamic>.from(errorList!.map((x) => x)),
//       };
// }

class GetBillingData {
  GetBillingData({
    this.shippingRequired,
    this.disableBillingAddressCheckoutStep,
    this.billingAddress,
    this.customProperties,
  });

  bool? shippingRequired;
  bool? disableBillingAddressCheckoutStep;
  BillingAddress? billingAddress;
  CustomProperties? customProperties;

  factory GetBillingData.fromJson(Map<String, dynamic> json) => GetBillingData(
        shippingRequired: json["ShippingRequired"],
        disableBillingAddressCheckoutStep:
            json["DisableBillingAddressCheckoutStep"],
        billingAddress: json["BillingAddress"] == null
            ? null
            : BillingAddress.fromJson(json["BillingAddress"]),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ShippingRequired": shippingRequired,
        "DisableBillingAddressCheckoutStep": disableBillingAddressCheckoutStep,
        "BillingAddress": billingAddress?.toJson(),
        "CustomProperties": customProperties?.toJson(),
      };
}

class BillingAddress {
  BillingAddress({
    this.existingAddresses,
    this.invalidExistingAddresses,
    this.billingNewAddress,
    this.shipToSameAddress,
    this.shipToSameAddressAllowed,
    this.newAddressPreselected,
    this.customProperties,
  });

  List<Address>? existingAddresses;
  List<Address>? invalidExistingAddresses;
  Address? billingNewAddress;
  bool? shipToSameAddress;
  bool? shipToSameAddressAllowed;
  bool? newAddressPreselected;
  CustomProperties? customProperties;

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
        existingAddresses: json["ExistingAddresses"] == null
            ? null
            : List<Address>.from(
                json["ExistingAddresses"]!.map((x) => Address.fromJson(x))),
        invalidExistingAddresses: json["InvalidExistingAddresses"] == null
            ? null
            : List<Address>.from(json["InvalidExistingAddresses"]!
                .map((x) => Address.fromJson(x))),
        billingNewAddress: json["BillingNewAddress"] == null
            ? null
            : Address.fromJson(json["BillingNewAddress"]),
        shipToSameAddress: json["ShipToSameAddress"],
        shipToSameAddressAllowed: json["ShipToSameAddressAllowed"],
        newAddressPreselected: json["NewAddressPreselected"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ExistingAddresses": existingAddresses == null
            ? null
            : List<dynamic>.from(existingAddresses!.map((x) => x.toJson())),
        "InvalidExistingAddresses": invalidExistingAddresses == null
            ? null
            : List<dynamic>.from(invalidExistingAddresses!.map((x) => x)),
        "BillingNewAddress": billingNewAddress?.toJson(),
        "ShipToSameAddress": shipToSameAddress,
        "ShipToSameAddressAllowed": shipToSameAddressAllowed,
        "NewAddressPreselected": newAddressPreselected,
        "CustomProperties": customProperties?.toJson(),
      };
}

class Address {
  Address({
    this.firstName,
    this.lastName,
    this.email,
    this.companyEnabled = false,
    this.companyRequired = false,
    this.company,
    this.countryEnabled = false,
    this.countryId,
    this.countryName,
    this.stateProvinceEnabled = false,
    this.stateProvinceId,
    this.stateProvinceName,
    this.countyEnabled = false,
    this.countyRequired = false,
    this.county,
    this.cityEnabled = false,
    this.cityRequired = false,
    this.city,
    this.locationEnabled = false,
    this.locationRequired = false,
    this.location,
    this.streetAddressEnabled = false,
    this.streetAddressRequired = false,
    this.address1,
    this.streetAddress2Enabled = false,
    this.streetAddress2Required = false,
    this.address2,
    this.zipPostalCodeEnabled = false,
    this.zipPostalCodeRequired = false,
    this.zipPostalCode,
    this.phoneEnabled = false,
    this.phoneRequired = false,
    this.phoneNumber,
    this.faxEnabled = false,
    this.faxRequired = false,
    this.faxNumber,
    this.availableCountries,
    this.availableStates,
    this.formattedCustomAddressAttributes,
    this.customAddressAttributes,
    this.id,
    this.customProperties,
  });

  String? firstName;
  String? lastName;
  String? email;
  bool companyEnabled;
  bool companyRequired;
  String? company;
  bool countryEnabled;
  int? countryId;
  String? countryName;
  bool stateProvinceEnabled;
  int? stateProvinceId;
  String? stateProvinceName;
  bool countyEnabled;
  bool countyRequired;
  String? county;
  bool cityEnabled;
  bool cityRequired;
  String? city;

  bool locationEnabled;
  bool locationRequired;
  AddressLocation? location;

  bool streetAddressEnabled;
  bool streetAddressRequired;
  String? address1;
  bool streetAddress2Enabled;
  bool streetAddress2Required;
  String? address2;
  bool zipPostalCodeEnabled;
  bool zipPostalCodeRequired;
  String? zipPostalCode;
  bool phoneEnabled;
  bool phoneRequired;
  String? phoneNumber;
  bool faxEnabled;
  bool faxRequired;
  String? faxNumber;
  List<AvailableOption>? availableCountries;
  List<AvailableOption>? availableStates;
  String? formattedCustomAddressAttributes;
  List<CustomAttribute>? customAddressAttributes;
  int? id;
  CustomProperties? customProperties;

  Address? copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? companyEnabled,
    bool? companyRequired,
    String? company,
    bool? countryEnabled,
    int? countryId,
    String? countryName,
    bool? stateProvinceEnabled,
    int? stateProvinceId,
    String? stateProvinceName,
    bool? countyEnabled,
    bool? countyRequired,
    String? county,
    bool? cityEnabled,
    bool? cityRequired,
    String? city,
    bool? locationEnabled,
    bool? locationRequired,
    AddressLocation? location,
    bool? streetAddressEnabled,
    bool? streetAddressRequired,
    String? address1,
    bool? streetAddress2Enabled,
    bool? streetAddress2Required,
    String? address2,
    bool? zipPostalCodeEnabled,
    bool? zipPostalCodeRequired,
    String? zipPostalCode,
    bool? phoneEnabled,
    bool? phoneRequired,
    String? phoneNumber,
    bool? faxEnabled,
    bool? faxRequired,
    String? faxNumber,
    List<AvailableOption>? availableCountries,
    List<AvailableOption>? availableStates,
    String? formattedCustomAddressAttributes,
    List<CustomAttribute>? customAddressAttributes,
    int? id,
    CustomProperties? customProperties,
  }) =>
      Address(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        companyEnabled: companyEnabled ?? this.companyEnabled,
        companyRequired: companyRequired ?? this.companyRequired,
        company: company ?? this.company,
        countryEnabled: countryEnabled ?? this.countryEnabled,
        countryId: countryId ?? this.countryId,
        countryName: countryName ?? this.countryName,
        stateProvinceEnabled: stateProvinceEnabled ?? this.stateProvinceEnabled,
        stateProvinceId: stateProvinceId ?? this.stateProvinceId,
        stateProvinceName: stateProvinceName ?? this.stateProvinceName,
        countyEnabled: countyEnabled ?? this.countyEnabled,
        countyRequired: countyRequired ?? this.countyRequired,
        county: county ?? this.county,
        cityEnabled: cityEnabled ?? this.cityEnabled,
        cityRequired: cityRequired ?? this.cityRequired,
        city: city ?? this.city,
        locationEnabled: locationEnabled ?? this.locationEnabled,
        locationRequired: locationRequired ?? this.locationRequired,
        location: location ?? this.location,
        streetAddressEnabled: streetAddressEnabled ?? this.streetAddressEnabled,
        streetAddressRequired:
            streetAddressRequired ?? this.streetAddressRequired,
        address1: address1 ?? this.address1,
        streetAddress2Enabled:
            streetAddress2Enabled ?? this.streetAddress2Enabled,
        streetAddress2Required:
            streetAddress2Required ?? this.streetAddress2Required,
        address2: address2 ?? this.address2,
        zipPostalCodeEnabled: zipPostalCodeEnabled ?? this.zipPostalCodeEnabled,
        zipPostalCodeRequired:
            zipPostalCodeRequired ?? this.zipPostalCodeRequired,
        zipPostalCode: zipPostalCode ?? this.zipPostalCode,
        phoneEnabled: phoneEnabled ?? this.phoneEnabled,
        phoneRequired: phoneRequired ?? this.phoneRequired,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        faxEnabled: faxEnabled ?? this.faxEnabled,
        faxRequired: faxRequired ?? this.faxRequired,
        faxNumber: faxNumber ?? this.faxNumber,
        availableCountries: availableCountries ?? this.availableCountries,
        availableStates: availableStates ?? this.availableStates,
        formattedCustomAddressAttributes: formattedCustomAddressAttributes ??
            this.formattedCustomAddressAttributes,
        customAddressAttributes:
            customAddressAttributes ?? this.customAddressAttributes,
        id: id ?? this.id,
        customProperties: customProperties ?? this.customProperties,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        firstName: json["FirstName"],
        lastName: json["LastName"],
        email: json["Email"],
        companyEnabled: json["CompanyEnabled"] ?? false,
        companyRequired: json["CompanyRequired"] ?? false,
        company: json["Company"],
        countryEnabled: json["CountryEnabled"] ?? false,
        countryId: json["CountryId"],
        countryName: json["CountryName"],
        stateProvinceEnabled: json["StateProvinceEnabled"] ?? false,
        stateProvinceId: json["StateProvinceId"],
        stateProvinceName: json["StateProvinceName"],
        countyEnabled: json["CountyEnabled"] ?? false,
        countyRequired: json["CountyRequired"] ?? false,
        county: json["County"],
        cityEnabled: json["CityEnabled"] ?? false,
        cityRequired: json["CityRequired"] ?? false,
        city: json["City"],
        locationEnabled: json["LocationEnabled"] ?? true,
        locationRequired: json["LocationRequired"] ?? true,
        location: json["Location"] == null
            ? null
            : AddressLocation.fromMap(json["Location"]),
        streetAddressEnabled: json["StreetAddressEnabled"] ?? false,
        streetAddressRequired: json["StreetAddressRequired"] ?? false,
        address1: json["Address1"],
        streetAddress2Enabled: json["StreetAddress2Enabled"] ?? false,
        streetAddress2Required: json["StreetAddress2Required"] ?? false,
        address2: json["Address2"],
        zipPostalCodeEnabled: json["ZipPostalCodeEnabled"] ?? false,
        zipPostalCodeRequired: json["ZipPostalCodeRequired"] ?? false,
        zipPostalCode: json["ZipPostalCode"],
        phoneEnabled: json["PhoneEnabled"] ?? false,
        phoneRequired: json["PhoneRequired"] ?? false,
        phoneNumber: json["PhoneNumber"],
        faxEnabled: json["FaxEnabled"] ?? false,
        faxRequired: json["FaxRequired"] ?? false,
        faxNumber: json["FaxNumber"],
        availableCountries: json["AvailableCountries"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableCountries"]!
                .map((x) => AvailableOption.fromJson(x))),
        availableStates: json["AvailableStates"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableStates"]!
                .map((x) => AvailableOption.fromJson(x))),
        formattedCustomAddressAttributes:
            json["FormattedCustomAddressAttributes"],
        customAddressAttributes: json["CustomAddressAttributes"] == null
            ? null
            : List<CustomAttribute>.from(json["CustomAddressAttributes"]!
                .map((x) => CustomAttribute.fromJson(x))),
        id: json["Id"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  factory Address.fake() => Address(
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@example.com",
        company: "Example Company",
        stateProvinceId: 1,
        stateProvinceName: "California",
        county: "San Francisco",
        city: "San Francisco",
        address1: "123 Main St",
        zipPostalCode: "94107",
        phoneNumber: "123-456-7890",
        faxNumber: "123-456-7890",
        // customProperties: CustomProperties.fake(),
        address2: "Apt 123",
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "CompanyEnabled": companyEnabled,
        "CompanyRequired": companyRequired,
        "Company": company,
        "CountryEnabled": countryEnabled,
        "CountryId": countryId,
        "CountryName": countryName,
        "StateProvinceEnabled": stateProvinceEnabled,
        "StateProvinceId": stateProvinceId,
        "StateProvinceName": stateProvinceName,
        "CountyEnabled": countyEnabled,
        "CountyRequired": countyRequired,
        "County": county,
        "CityEnabled": cityEnabled,
        "CityRequired": cityRequired,
        "City": city,
        "LocationEnabled": locationEnabled,
        "LocationRequired": locationRequired,
        "Location": location?.toMap(),
        "StreetAddressEnabled": streetAddressEnabled,
        "StreetAddressRequired": streetAddressRequired,
        "Address1": address1,
        "StreetAddress2Enabled": streetAddress2Enabled,
        "StreetAddress2Required": streetAddress2Required,
        "Address2": address2,
        "ZipPostalCodeEnabled": zipPostalCodeEnabled,
        "ZipPostalCodeRequired": zipPostalCodeRequired,
        "ZipPostalCode": zipPostalCode,
        "PhoneEnabled": phoneEnabled,
        "PhoneRequired": phoneRequired,
        "PhoneNumber": phoneNumber,
        "FaxEnabled": faxEnabled,
        "FaxRequired": faxRequired,
        "FaxNumber": faxNumber,
        "AvailableCountries": availableCountries == null
            ? null
            : List<dynamic>.from(availableCountries!.map((x) => x)),
        "AvailableStates": availableStates == null
            ? null
            : List<dynamic>.from(availableStates!.map((x) => x)),
        "FormattedCustomAddressAttributes": formattedCustomAddressAttributes,
        "CustomAddressAttributes": customAddressAttributes == null
            ? null
            : List<dynamic>.from(customAddressAttributes!.map((x) => x)),
        "Id": id,
        "CustomProperties": customProperties?.toJson(),
      };

  @override
  String toString() {
    return "$firstName $lastName";
  }
}

extension AddressLocationExt on Address? {
  String get getFormattedAddress {
    final Address? address = this;

    if (address == null) return '';
    var formattedAddress = '';

    if (address.email != null) {
      formattedAddress += "${ConstStrings.EMAIL.translate}: ${address.email}\n";
    }
    if (address.phoneNumber != null) {
      formattedAddress +=
          "${ConstStrings.PHONE.translate}: ${address.phoneNumber}\n";
    }
    if (address.company != null) {
      formattedAddress +=
          "${ConstStrings.COMPANY.translate}: ${address.company}\n";
    }
    if (address.address1 != null) {
      formattedAddress +=
          "${ConstStrings.STREET_ADDRESS.translate}: ${address.address1}\n";
    }
    if (address.address2 != null) {
      formattedAddress +=
          "${ConstStrings.STREET_ADDRESS_2.translate}: ${address.address2}\n";
    }
    if (address.zipPostalCode != null) {
      formattedAddress +=
          "${ConstStrings.ZIP_CODE.translate}: ${address.zipPostalCode}\n";
    }
    if (address.city != null) {
      formattedAddress += "${ConstStrings.CITY.translate}: ${address.city}\n";
    }
    if (address.stateProvinceName != null) {
      formattedAddress +=
          "${ConstStrings.STATE_PROVINCE.translate}: ${address.stateProvinceName}\n";
    }
    if (address.countryName != null) {
      formattedAddress +=
          "${ConstStrings.COUNTRY.translate}: ${address.countryName}";
    }

    return formattedAddress.trimRight();
  }
}

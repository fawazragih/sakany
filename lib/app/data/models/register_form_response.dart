import 'available_option.dart';
import 'user_login_response.dart';
import 'custom_attribute.dart';
import 'custom_properties.dart';

// class RegisterFormResponse {
//   RegisterFormResponse({
//     this.data,
//     this.message,
//     this.errorList,
//   });
//
//   RegisterFormData? data;
//   String? message;
//   List<String>? errorList;
//
//   factory RegisterFormResponse.fromJson(Map<String, dynamic> json) =>
//       RegisterFormResponse(
//         data: RegisterFormData.fromJson(json["Data"]),
//         message: json["Message"],
//         errorList: List<String>.from(json["ErrorList"]!.map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Data": data?.toJson(),
//         "Message": message,
//         "ErrorList": List<String>.from(errorList!.map((x) => x)),
//       };
// }

class RegisterFormData {
  RegisterFormData({
    this.email,
    this.enteringEmailTwice = false,
    this.confirmEmail,
    this.usernamesEnabled = false,
    this.username,
    this.checkUsernameAvailabilityEnabled = false,
    this.password,
    this.confirmPassword,
    this.genderEnabled = false,
    this.gender,
    this.firstNameEnabled = false,
    this.firstName,
    this.firstNameRequired = false,
    this.lastNameEnabled = false,
    this.lastName,
    this.lastNameRequired = false,
    this.dateOfBirthEnabled = false,
    this.dateOfBirthDay,
    this.dateOfBirthMonth,
    this.dateOfBirthYear,
    this.dateOfBirthRequired = false,
    this.companyEnabled = false,
    this.companyRequired = false,
    this.company,
    this.streetAddressEnabled = false,
    this.streetAddressRequired = false,
    this.streetAddress,
    this.streetAddress2Enabled = false,
    this.streetAddress2Required = false,
    this.streetAddress2,
    this.zipPostalCodeEnabled = false,
    this.zipPostalCodeRequired = false,
    this.zipPostalCode,
    this.cityEnabled = false,
    this.cityRequired = false,
    this.city,
    this.countyEnabled = false,
    this.countyRequired = false,
    this.county,
    this.countryEnabled = false,
    this.countryRequired = false,
    this.countryId,
    this.availableCountries,
    this.stateProvinceEnabled = false,
    this.stateProvinceRequired = false,
    this.stateProvinceId,
    this.availableStates,
    this.phoneEnabled = false,
    this.phoneRequired = false,
    this.phone,
    this.faxEnabled = false,
    this.faxRequired = false,
    this.fax,
    this.newsletterEnabled = false,
    this.newsletter = false,
    this.acceptPrivacyPolicyEnabled = false,
    this.acceptPrivacyPolicyPopup = false,
    this.timeZoneId,
    this.allowCustomersToSetTimeZone = false,
    this.availableTimeZones,
    this.vatNumber,
    this.displayVatNumber = false,
    this.honeypotEnabled = false,
    this.displayCaptcha = false,
    this.customerAttributes,
    this.gdprConsents,
    this.customProperties,
  });

  String? email;
  bool enteringEmailTwice;
  String? confirmEmail;
  bool usernamesEnabled;
  String? username;
  bool checkUsernameAvailabilityEnabled;
  String? password;
  String? confirmPassword;
  bool genderEnabled;
  String? gender;
  bool firstNameEnabled;
  String? firstName;
  bool firstNameRequired;
  bool lastNameEnabled;
  String? lastName;
  bool lastNameRequired;
  bool dateOfBirthEnabled;
  int? dateOfBirthDay;
  int? dateOfBirthMonth;
  int? dateOfBirthYear;
  bool dateOfBirthRequired;
  bool companyEnabled;
  bool companyRequired;
  String? company;
  bool streetAddressEnabled;
  bool streetAddressRequired;
  String? streetAddress;
  bool streetAddress2Enabled;
  bool streetAddress2Required;
  String? streetAddress2;
  bool zipPostalCodeEnabled;
  bool zipPostalCodeRequired;
  String? zipPostalCode;
  bool cityEnabled;
  bool cityRequired;
  String? city;
  bool countyEnabled;
  bool countyRequired;
  String? county;
  bool countryEnabled;
  bool countryRequired;
  int? countryId;
  List<AvailableOption>? availableCountries;
  bool stateProvinceEnabled;
  bool stateProvinceRequired;
  int? stateProvinceId;
  List<AvailableOption>? availableStates;
  bool phoneEnabled;
  bool phoneRequired;
  String? phone;
  bool faxEnabled;
  bool faxRequired;
  String? fax;
  bool newsletterEnabled;
  bool newsletter;
  bool acceptPrivacyPolicyEnabled;
  bool acceptPrivacyPolicyPopup;
  num? timeZoneId;
  bool allowCustomersToSetTimeZone;
  List<AvailableOption>? availableTimeZones;
  String? vatNumber;
  bool displayVatNumber;
  bool honeypotEnabled;
  bool displayCaptcha;
  List<CustomAttribute>? customerAttributes;
  List<GdprConsent>? gdprConsents;
  CustomProperties? customProperties;

  DateTime? get userDOB {
    if (dateOfBirthDay == null ||
        dateOfBirthMonth == null ||
        dateOfBirthYear == null) {
      return null;
    }

    return DateTime(dateOfBirthYear!, dateOfBirthMonth!, dateOfBirthDay!);
  }

  RegisterFormData copyWith({
    String? email,
    bool enteringEmailTwice = false,
    String? confirmEmail,
    bool usernamesEnabled = false,
    String? username,
    bool checkUsernameAvailabilityEnabled = false,
    String? password,
    String? confirmPassword,
    bool genderEnabled = false,
    String? gender,
    bool firstNameEnabled = false,
    String? firstName,
    bool firstNameRequired = false,
    bool lastNameEnabled = false,
    String? lastName,
    bool lastNameRequired = false,
    bool dateOfBirthEnabled = false,
    int? dateOfBirthDay,
    int? dateOfBirthMonth,
    int? dateOfBirthYear,
    bool dateOfBirthRequired = false,
    bool companyEnabled = false,
    bool companyRequired = false,
    String? company,
    bool streetAddressEnabled = false,
    bool streetAddressRequired = false,
    String? streetAddress,
    bool streetAddress2Enabled = false,
    bool streetAddress2Required = false,
    String? streetAddress2,
    bool zipPostalCodeEnabled = false,
    bool zipPostalCodeRequired = false,
    String? zipPostalCode,
    bool cityEnabled = false,
    bool cityRequired = false,
    String? city,
    bool countyEnabled = false,
    bool countyRequired = false,
    String? county,
    bool countryEnabled = false,
    bool countryRequired = false,
    int? countryId,
    List<AvailableOption>? availableCountries,
    bool stateProvinceEnabled = false,
    bool stateProvinceRequired = false,
    int? stateProvinceId,
    List<AvailableOption>? availableStates,
    bool phoneEnabled = false,
    bool phoneRequired = false,
    String? phone,
    bool faxEnabled = false,
    bool faxRequired = false,
    String? fax,
    bool newsletterEnabled = false,
    bool newsletter = false,
    bool acceptPrivacyPolicyEnabled = false,
    bool acceptPrivacyPolicyPopup = false,
    num? timeZoneId,
    bool allowCustomersToSetTimeZone = false,
    List<AvailableOption>? availableTimeZones,
    String? vatNumber,
    bool displayVatNumber = false,
    bool honeypotEnabled = false,
    bool displayCaptcha = false,
    List<CustomAttribute>? customerAttributes,
    List<GdprConsent>? gdprConsents,
    CustomProperties? customProperties,
  }) =>
      RegisterFormData(
        email: email ?? this.email,
        enteringEmailTwice: enteringEmailTwice ?? this.enteringEmailTwice,
        confirmEmail: confirmEmail ?? this.confirmEmail,
        usernamesEnabled: usernamesEnabled,
        username: username ?? this.username,
        checkUsernameAvailabilityEnabled: checkUsernameAvailabilityEnabled ??
            this.checkUsernameAvailabilityEnabled,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        genderEnabled: genderEnabled,
        gender: gender ?? this.gender,
        firstNameEnabled: firstNameEnabled ?? this.firstNameEnabled,
        firstName: firstName ?? this.firstName,
        firstNameRequired: firstNameRequired ?? this.firstNameRequired,
        lastNameEnabled: lastNameEnabled ?? this.lastNameEnabled,
        lastName: lastName ?? this.lastName,
        lastNameRequired: lastNameRequired ?? this.lastNameRequired,
        dateOfBirthEnabled: dateOfBirthEnabled ?? this.dateOfBirthEnabled,
        dateOfBirthDay: dateOfBirthDay ?? this.dateOfBirthDay,
        dateOfBirthMonth: dateOfBirthMonth ?? this.dateOfBirthMonth,
        dateOfBirthYear: dateOfBirthYear ?? this.dateOfBirthYear,
        dateOfBirthRequired: dateOfBirthRequired ?? this.dateOfBirthRequired,
        companyEnabled: companyEnabled ?? this.companyEnabled,
        companyRequired: companyRequired ?? this.companyRequired,
        company: company ?? this.company,
        streetAddressEnabled: streetAddressEnabled ?? this.streetAddressEnabled,
        streetAddressRequired:
            streetAddressRequired ?? this.streetAddressRequired,
        streetAddress: streetAddress ?? this.streetAddress,
        streetAddress2Enabled:
            streetAddress2Enabled ?? this.streetAddress2Enabled,
        streetAddress2Required:
            streetAddress2Required ?? this.streetAddress2Required,
        streetAddress2: streetAddress2 ?? this.streetAddress2,
        zipPostalCodeEnabled: zipPostalCodeEnabled ?? this.zipPostalCodeEnabled,
        zipPostalCodeRequired:
            zipPostalCodeRequired ?? this.zipPostalCodeRequired,
        zipPostalCode: zipPostalCode ?? this.zipPostalCode,
        cityEnabled: cityEnabled ?? this.cityEnabled,
        cityRequired: cityRequired ?? this.cityRequired,
        city: city ?? this.city,
        countyEnabled: countyEnabled ?? this.countyEnabled,
        countyRequired: countyRequired ?? this.countyRequired,
        county: county ?? this.county,
        countryEnabled: countryEnabled ?? this.countryEnabled,
        countryRequired: countryRequired ?? this.countryRequired,
        countryId: countryId ?? this.countryId,
        availableCountries: availableCountries ?? this.availableCountries,
        stateProvinceEnabled: stateProvinceEnabled ?? this.stateProvinceEnabled,
        stateProvinceRequired:
            stateProvinceRequired ?? this.stateProvinceRequired,
        stateProvinceId: stateProvinceId ?? this.stateProvinceId,
        availableStates: availableStates ?? this.availableStates,
        phoneEnabled: phoneEnabled ?? this.phoneEnabled,
        phoneRequired: phoneRequired ?? this.phoneRequired,
        phone: phone ?? this.phone,
        faxEnabled: faxEnabled ?? this.faxEnabled,
        faxRequired: faxRequired ?? this.faxRequired,
        fax: fax ?? this.fax,
        newsletterEnabled: newsletterEnabled ?? this.newsletterEnabled,
        newsletter: newsletter ?? this.newsletter,
        acceptPrivacyPolicyEnabled:
            acceptPrivacyPolicyEnabled ?? this.acceptPrivacyPolicyEnabled,
        acceptPrivacyPolicyPopup:
            acceptPrivacyPolicyPopup ?? this.acceptPrivacyPolicyPopup,
        timeZoneId: timeZoneId ?? this.timeZoneId,
        allowCustomersToSetTimeZone:
            allowCustomersToSetTimeZone ?? this.allowCustomersToSetTimeZone,
        availableTimeZones: availableTimeZones ?? this.availableTimeZones,
        vatNumber: vatNumber ?? this.vatNumber,
        displayVatNumber: displayVatNumber ?? this.displayVatNumber,
        honeypotEnabled: honeypotEnabled ?? this.honeypotEnabled,
        displayCaptcha: displayCaptcha ?? this.displayCaptcha,
        customerAttributes: customerAttributes ?? this.customerAttributes,
        gdprConsents: gdprConsents ?? this.gdprConsents,
        customProperties: customProperties ?? this.customProperties,
      );

  factory RegisterFormData.fromJson(Map<String, dynamic> json) =>
      RegisterFormData(
        email: json["Email"],
        enteringEmailTwice: json["EnteringEmailTwice"] ?? false,
        confirmEmail: json["ConfirmEmail"],
        usernamesEnabled: json["UsernamesEnabled"] ?? false,
        username: json["Username"],
        checkUsernameAvailabilityEnabled:
            json["CheckUsernameAvailabilityEnabled"] ?? false,
        password: json["Password"],
        confirmPassword: json["ConfirmPassword"],
        genderEnabled: json["GenderEnabled"] ?? false,
        gender: json["Gender"],
        firstNameEnabled: json["FirstNameEnabled"] ?? false,
        firstName: json["FirstName"],
        firstNameRequired: json["FirstNameRequired"] ?? false,
        lastNameEnabled: json["LastNameEnabled"] ?? false,
        lastName: json["LastName"],
        lastNameRequired: json["LastNameRequired"] ?? false,
        dateOfBirthEnabled: json["DateOfBirthEnabled"] ?? false,
        dateOfBirthDay: json["DateOfBirthDay"],
        dateOfBirthMonth: json["DateOfBirthMonth"],
        dateOfBirthYear: json["DateOfBirthYear"],
        dateOfBirthRequired: json["DateOfBirthRequired"] ?? false,
        companyEnabled: json["CompanyEnabled"] ?? false,
        companyRequired: json["CompanyRequired"] ?? false,
        company: json["Company"],
        streetAddressEnabled: json["StreetAddressEnabled"] ?? false,
        streetAddressRequired: json["StreetAddressRequired"] ?? false,
        streetAddress: json["StreetAddress"],
        streetAddress2Enabled: json["StreetAddress2Enabled"] ?? false,
        streetAddress2Required: json["StreetAddress2Required"] ?? false,
        streetAddress2: json["StreetAddress2"],
        zipPostalCodeEnabled: json["ZipPostalCodeEnabled"] ?? false,
        zipPostalCodeRequired: json["ZipPostalCodeRequired"] ?? false,
        zipPostalCode: json["ZipPostalCode"],
        cityEnabled: json["CityEnabled"] ?? false,
        cityRequired: json["CityRequired"] ?? false,
        city: json["City"],
        countyEnabled: json["CountyEnabled"] ?? false,
        countyRequired: json["CountyRequired"] ?? false,
        county: json["County"],
        countryEnabled: json["CountryEnabled"] ?? false,
        countryRequired: json["CountryRequired"] ?? false,
        countryId: json["CountryId"],
        availableCountries: json["AvailableCountries"] == null
            ? []
            : List<AvailableOption>.from(json["AvailableCountries"]
                ?.map((x) => AvailableOption.fromJson(x))),
        stateProvinceEnabled: json["StateProvinceEnabled"] ?? false,
        stateProvinceRequired: json["StateProvinceRequired"] ?? false,
        stateProvinceId: json["StateProvinceId"],
        availableStates: json["AvailableStates"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableStates"]!
                .map((x) => AvailableOption.fromJson(x))),
        phoneEnabled: json["PhoneEnabled"] ?? false,
        phoneRequired: json["PhoneRequired"] ?? false,
        phone: json["Phone"],
        faxEnabled: json["FaxEnabled"] ?? false,
        faxRequired: json["FaxRequired"] ?? false,
        fax: json["Fax"],
        newsletterEnabled: json["NewsletterEnabled"] ?? false,
        newsletter: json["Newsletter"] ?? false,
        acceptPrivacyPolicyEnabled: json["AcceptPrivacyPolicyEnabled"] ?? false,
        acceptPrivacyPolicyPopup: json["AcceptPrivacyPolicyPopup"] ?? false,
        timeZoneId: json["TimeZoneId"],
        allowCustomersToSetTimeZone:
            json["AllowCustomersToSetTimeZone"] ?? false,
        availableTimeZones: json["AvailableTimeZones"] == null
            ? null
            : List<AvailableOption>.from(json["AvailableTimeZones"]!
                .map((x) => AvailableOption.fromJson(x))),
        vatNumber: json["VatNumber"],
        displayVatNumber: json["DisplayVatNumber"] ?? false,
        honeypotEnabled: json["HoneypotEnabled"] ?? false,
        displayCaptcha: json["DisplayCaptcha"] ?? false,
        customerAttributes: json["CustomerAttributes"] == null
            ? null
            : List<CustomAttribute>.from(json["CustomerAttributes"]!
                .map((x) => CustomAttribute.fromJson(x))),
        gdprConsents: json["GdprConsents"] == null
            ? null
            : List<GdprConsent>.from(
                json["GdprConsents"]?.map((x) => GdprConsent.fromJson(x))),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Email": email,
        "EnteringEmailTwice": enteringEmailTwice,
        "ConfirmEmail": confirmEmail,
        "UsernamesEnabled": usernamesEnabled,
        "Username": username,
        "CheckUsernameAvailabilityEnabled": checkUsernameAvailabilityEnabled,
        "Password": password,
        "ConfirmPassword": confirmPassword,
        "GenderEnabled": genderEnabled,
        "Gender": gender,
        "FirstNameEnabled": firstNameEnabled,
        "FirstName": firstName,
        "FirstNameRequired": firstNameRequired,
        "LastNameEnabled": lastNameEnabled,
        "LastName": lastName,
        "LastNameRequired": lastNameRequired,
        "DateOfBirthEnabled": dateOfBirthEnabled,
        "DateOfBirthDay": dateOfBirthDay,
        "DateOfBirthMonth": dateOfBirthMonth,
        "DateOfBirthYear": dateOfBirthYear,
        "DateOfBirthRequired": dateOfBirthRequired,
        "CompanyEnabled": companyEnabled,
        "CompanyRequired": companyRequired,
        "Company": company,
        "StreetAddressEnabled": streetAddressEnabled,
        "StreetAddressRequired": streetAddressRequired,
        "StreetAddress": streetAddress,
        "StreetAddress2Enabled": streetAddress2Enabled,
        "StreetAddress2Required": streetAddress2Required,
        "StreetAddress2": streetAddress2,
        "ZipPostalCodeEnabled": zipPostalCodeEnabled,
        "ZipPostalCodeRequired": zipPostalCodeRequired,
        "ZipPostalCode": zipPostalCode,
        "CityEnabled": cityEnabled,
        "CityRequired": cityRequired,
        "City": city,
        "CountyEnabled": countyEnabled,
        "CountyRequired": countyRequired,
        "County": county,
        "CountryEnabled": countryEnabled,
        "CountryRequired": countryRequired,
        "CountryId": countryId,
        "AvailableCountries": availableCountries == null
            ? null
            : List<dynamic>.from(availableCountries!.map((x) => x.toJson())),
        "StateProvinceEnabled": stateProvinceEnabled,
        "StateProvinceRequired": stateProvinceRequired,
        "StateProvinceId": stateProvinceId,
        "AvailableStates": availableStates == null
            ? null
            : List<dynamic>.from(availableStates!.map((x) => x.toJson())),
        "PhoneEnabled": phoneEnabled,
        "PhoneRequired": phoneRequired,
        "Phone": phone,
        "FaxEnabled": faxEnabled,
        "FaxRequired": faxRequired,
        "Fax": fax,
        "NewsletterEnabled": newsletterEnabled,
        "Newsletter": newsletter,
        "AcceptPrivacyPolicyEnabled": acceptPrivacyPolicyEnabled,
        "AcceptPrivacyPolicyPopup": acceptPrivacyPolicyPopup,
        "TimeZoneId": timeZoneId,
        "AllowCustomersToSetTimeZone": allowCustomersToSetTimeZone,
        "AvailableTimeZones": availableTimeZones == null
            ? null
            : List<dynamic>.from(availableTimeZones!.map((x) => x.toJson())),
        "VatNumber": vatNumber,
        "DisplayVatNumber": displayVatNumber,
        "HoneypotEnabled": honeypotEnabled,
        "DisplayCaptcha": displayCaptcha,
        "CustomerAttributes": customerAttributes == null
            ? null
            : List<dynamic>.from(customerAttributes!.map((x) => x.toJson())),
        "GdprConsents": gdprConsents == null
            ? null
            : List<dynamic>.from(gdprConsents!.map((x) => x.toJson())),
        "CustomProperties": customProperties?.toJson(),
      }..removeWhere((k, v) => v == null);
}

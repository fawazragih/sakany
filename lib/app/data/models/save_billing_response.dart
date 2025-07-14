import 'package:collection/collection.dart';
import 'package:sakani_mobile_app/app/modules/checkout_page/checkout_shared_mixin.dart';
import 'shopping_cart_response.dart';
import 'custom_properties.dart';
import 'estimate_shipping.dart';
import 'get_billing_address_response.dart';

class CheckoutPostResponse {
  CheckoutPostResponse({
    this.data,
    this.message,
    this.errorList,
  });

  CheckoutPostResponseData? data;
  String? message;
  List<String>? errorList;

  factory CheckoutPostResponse.fromJson(Map<String, dynamic> json) =>
      CheckoutPostResponse(
        data: json["Data"] == null
            ? null
            : CheckoutPostResponseData.fromJson(json["Data"]),
        message: json["Message"],
        errorList: json["ErrorList"] == null
            ? null
            : List<String>.from(json["ErrorList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "Message": message,
        "ErrorList": errorList == null
            ? null
            : List<dynamic>.from(errorList!.map((x) => x)),
      };
}

class CheckoutPostResponseData {
  CheckoutPostResponseData({
    this.nextStep,
    this.billingAddressModel,
    this.shippingAddressModel,
    this.shippingMethodModel,
    this.paymentMethodModel,
    this.paymentInfoModel,
    this.confirmModel,
    this.completedModel,
  });

  CheckoutSteps? nextStep;

  BillingAddress? billingAddressModel;
  ShippingAddressModel? shippingAddressModel;
  ShippingMethodModel? shippingMethodModel;
  PaymentMethodModel? paymentMethodModel;
  PaymentInfoModel? paymentInfoModel;
  ConfirmModel? confirmModel;
  CompletedModel? completedModel;

  factory CheckoutPostResponseData.fromJson(Map<String, dynamic> json) {
    return CheckoutPostResponseData(
        nextStep: CheckoutSteps.values.firstWhereOrNull((element) =>
            element.serverValue == int.tryParse(json["NextStep"].toString())),
        billingAddressModel: json["BillingAddressModel"] == null
            ? null
            : BillingAddress.fromJson(json["BillingAddressModel"]),
        shippingAddressModel: json["ShippingAddressModel"] == null
            ? null
            : ShippingAddressModel.fromJson(json["ShippingAddressModel"]),
        shippingMethodModel: json["ShippingMethodModel"] == null
            ? null
            : ShippingMethodModel.fromJson(json["ShippingMethodModel"]),
        paymentMethodModel: json["PaymentMethodModel"] == null
            ? null
            : PaymentMethodModel.fromJson(json["PaymentMethodModel"]),
        paymentInfoModel: json["PaymentInfoModel"] == null
            ? null
            : PaymentInfoModel.fromJson(json["PaymentInfoModel"]),
        confirmModel: json["ConfirmModel"] == null
            ? null
            : ConfirmModel.fromJson(json["ConfirmModel"]),
        completedModel: json["CompletedModel"] == null
            ? null
            : CompletedModel.fromJson(json["CompletedModel"]),
      );
  }

  Map<String, dynamic> toJson() => {
        "NextStep": nextStep?.serverValue,
        "BillingAddressModel": billingAddressModel,
        "ShippingAddressModel": shippingAddressModel?.toJson(),
        "ShippingMethodModel": shippingMethodModel?.toJson(),
        "PaymentMethodModel": paymentMethodModel?.toJson(),
        "PaymentInfoModel": paymentInfoModel?.toJson(),
        "ConfirmModel": confirmModel?.toJson(),
        "CompletedModel": completedModel?.toJson(),
      };
}

class CompletedModel {
  CompletedModel({
    this.orderId,
    this.customOrderNumber,
    this.onePageCheckoutEnabled,
    this.customProperties,
  });

  int? orderId;
  String? customOrderNumber;
  bool? onePageCheckoutEnabled;
  CustomProperties? customProperties;

  factory CompletedModel.fromJson(Map<String, dynamic> json) => CompletedModel(
        orderId: json["OrderId"],
        customOrderNumber: json["CustomOrderNumber"],
        onePageCheckoutEnabled: json["OnePageCheckoutEnabled"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "OrderId": orderId,
        "CustomOrderNumber": customOrderNumber,
        "OnePageCheckoutEnabled": onePageCheckoutEnabled,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ConfirmModel {
  ConfirmModel({
    this.cart,
    this.orderTotals,
    this.confirm,
    this.selectedCheckoutAttributes,
    this.estimateShipping,
  });

  Cart? cart;
  OrderTotals? orderTotals;
  Confirm? confirm;
  String? selectedCheckoutAttributes;
  EstimateShipping? estimateShipping;

  factory ConfirmModel.fromJson(Map<String, dynamic> json) => ConfirmModel(
        cart: json["Cart"] == null ? null : Cart.fromJson(json["Cart"]),
        orderTotals: json["OrderTotals"] == null
            ? null
            : OrderTotals.fromJson(json["OrderTotals"]),
        confirm:
            json["Confirm"] == null ? null : Confirm.fromJson(json["Confirm"]),
        selectedCheckoutAttributes: json["SelectedCheckoutAttributes"],
        estimateShipping: json["EstimateShipping"] == null
            ? null
            : EstimateShipping.fromJson(json["EstimateShipping"]),
      );

  Map<String, dynamic> toJson() => {
        "Cart": cart?.toJson(),
        "OrderTotals": orderTotals?.toJson(),
        "Confirm": confirm?.toJson(),
        "SelectedCheckoutAttributes": selectedCheckoutAttributes,
        "EstimateShipping": estimateShipping?.toJson(),
      };
}

class OrderReviewData {
  OrderReviewData({
    this.display,
    this.billingAddress,
    this.isShippable,
    this.shippingAddress,
    this.selectedPickupInStore,
    this.pickupAddress,
    this.shippingMethod,
    this.paymentMethod,
    this.customValues,
    this.customProperties,
  });

  bool? display;
  Address? billingAddress;
  bool? isShippable;
  Address? shippingAddress;
  bool? selectedPickupInStore;
  Address? pickupAddress;
  dynamic shippingMethod;
  dynamic paymentMethod;
  dynamic customValues;
  CustomProperties? customProperties;

  factory OrderReviewData.fromJson(Map<String, dynamic> json) =>
      OrderReviewData(
        display: json["Display"],
        billingAddress: json["BillingAddress"] == null
            ? null
            : Address.fromJson(json["BillingAddress"]),
        isShippable: json["IsShippable"],
        shippingAddress: json["ShippingAddress"] == null
            ? null
            : Address.fromJson(json["ShippingAddress"]),
        selectedPickupInStore: json["SelectedPickupInStore"],
        pickupAddress: json["PickupAddress"] == null
            ? null
            : Address.fromJson(json["PickupAddress"]),
        shippingMethod: json["ShippingMethod"],
        paymentMethod: json["PaymentMethod"],
        customValues: json["CustomValues"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Display": display,
        "BillingAddress": billingAddress?.toJson(),
        "IsShippable": isShippable,
        "ShippingAddress": shippingAddress?.toJson(),
        "SelectedPickupInStore": selectedPickupInStore,
        "PickupAddress": pickupAddress?.toJson(),
        "ShippingMethod": shippingMethod,
        "PaymentMethod": paymentMethod,
        "CustomValues": customValues?.toJson(),
        "CustomProperties": customProperties?.toJson(),
      };
}

class Confirm {
  Confirm({
    this.termsOfServiceOnOrderConfirmPage,
    this.termsOfServicePopup,
    this.minOrderTotalWarning,
    this.warnings,
    this.customProperties,
  });

  bool? termsOfServiceOnOrderConfirmPage;
  bool? termsOfServicePopup;
  dynamic minOrderTotalWarning;
  List<dynamic>? warnings;
  CustomProperties? customProperties;

  factory Confirm.fromJson(Map<String, dynamic> json) => Confirm(
        termsOfServiceOnOrderConfirmPage:
            json["TermsOfServiceOnOrderConfirmPage"] != null
                ? null
                : json["TermsOfServiceOnOrderConfirmPage"],
        termsOfServicePopup: json["TermsOfServicePopup"],
        minOrderTotalWarning: json["MinOrderTotalWarning"],
        warnings: json["Warnings"] == null
            ? null
            : List<dynamic>.from(json["Warnings"]!.map((x) => x)),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "TermsOfServiceOnOrderConfirmPage": termsOfServiceOnOrderConfirmPage,
        "TermsOfServicePopup": termsOfServicePopup,
        "MinOrderTotalWarning": minOrderTotalWarning,
        "Warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "CustomProperties": customProperties?.toJson(),
      };
}

class PaymentInfoModel {
  PaymentInfoModel({
    this.paymentViewComponentName,
    this.displayOrderTotals,
    this.customProperties,
  });

  dynamic paymentViewComponentName;
  bool? displayOrderTotals;
  CustomProperties? customProperties;

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
        paymentViewComponentName: json["PaymentViewComponentName"],
        displayOrderTotals: json["DisplayOrderTotals"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "PaymentViewComponentName": paymentViewComponentName,
        "DisplayOrderTotals": displayOrderTotals,
        "CustomProperties": customProperties?.toJson(),
      };
}

class PaymentMethodModel {
  PaymentMethodModel({
    this.paymentMethods,
    this.displayRewardPoints,
    this.rewardPointsBalance,
    this.rewardPointsAmount,
    this.rewardPointsEnoughToPayForOrder,
    this.useRewardPoints,
    this.customProperties,
  });

  List<PaymentMethod>? paymentMethods;
  bool? displayRewardPoints;
  int? rewardPointsBalance;
  String? rewardPointsAmount;
  bool? rewardPointsEnoughToPayForOrder;
  bool? useRewardPoints;
  CustomProperties? customProperties;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        paymentMethods: json["PaymentMethods"] == null
            ? null
            : List<PaymentMethod>.from(
                json["PaymentMethods"]!.map((x) => PaymentMethod.fromJson(x))),
        displayRewardPoints: json["DisplayRewardPoints"],
        rewardPointsBalance: json["RewardPointsBalance"],
        rewardPointsAmount: json["RewardPointsAmount"],
        rewardPointsEnoughToPayForOrder:
            json["RewardPointsEnoughToPayForOrder"],
        useRewardPoints: json["UseRewardPoints"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "PaymentMethods": paymentMethods == null
            ? null
            : List<dynamic>.from(paymentMethods!.map((x) => x.toJson())),
        "DisplayRewardPoints": displayRewardPoints,
        "RewardPointsBalance": rewardPointsBalance,
        "RewardPointsAmount": rewardPointsAmount,
        "RewardPointsEnoughToPayForOrder": rewardPointsEnoughToPayForOrder,
        "UseRewardPoints": useRewardPoints,
        "CustomProperties": customProperties?.toJson(),
      };
}

class PaymentMethod {
  PaymentMethod({
    this.paymentMethodSystemName,
    this.name,
    this.description,
    this.fee,
    this.selected,
    this.logoUrl,
    this.customProperties,
  });

  String? paymentMethodSystemName;
  String? name;
  String? description;
  String? fee;
  bool? selected;
  String? logoUrl;
  CustomProperties? customProperties;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        paymentMethodSystemName: json["PaymentMethodSystemName"],
        name: json["Name"],
        description: json["Description"],
        fee: json["Fee"],
        selected: json["Selected"],
        logoUrl: json["LogoUrl"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "PaymentMethodSystemName": paymentMethodSystemName,
        "Name": name,
        "Description": description,
        "Fee": fee,
        "Selected": selected,
        "LogoUrl": logoUrl,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ShippingAddressModel {
  ShippingAddressModel({
    this.existingAddresses,
    this.invalidExistingAddresses,
    this.shippingNewAddress,
    this.newAddressPreselected,
    this.displayPickupInStore,
    this.pickupPointsModel,
    this.customProperties,
  });

  List<Address>? existingAddresses;
  List<Address>? invalidExistingAddresses;
  Address? shippingNewAddress;
  bool? newAddressPreselected;
  bool? displayPickupInStore;
  PickupPointsModel? pickupPointsModel;
  CustomProperties? customProperties;

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        existingAddresses: json["ExistingAddresses"] == null
            ? null
            : List<Address>.from(
                json["ExistingAddresses"]!.map((x) => Address.fromJson(x))),
        invalidExistingAddresses: json["InvalidExistingAddresses"] == null
            ? null
            : List<Address>.from(json["InvalidExistingAddresses"]!
                .map((x) => Address.fromJson(x))),
        shippingNewAddress: json["ShippingNewAddress"] == null
            ? null
            : Address.fromJson(json["ShippingNewAddress"]),
        newAddressPreselected: json["NewAddressPreselected"],
        displayPickupInStore: json["DisplayPickupInStore"],
        pickupPointsModel: json["PickupPointsModel"] == null
            ? null
            : PickupPointsModel.fromJson(json["PickupPointsModel"]),
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
        "ShippingNewAddress": shippingNewAddress?.toJson(),
        "NewAddressPreselected": newAddressPreselected,
        "DisplayPickupInStore": displayPickupInStore,
        "PickupPointsModel": pickupPointsModel?.toJson(),
        "CustomProperties": customProperties?.toJson(),
      };
}

class PickupPointsModel {
  PickupPointsModel({
    this.warnings,
    this.pickupPoints,
    this.allowPickupInStore,
    this.pickupInStore,
    this.pickupInStoreOnly,
    this.displayPickupPointsOnMap,
    this.googleMapsApiKey,
    this.customProperties,
  });

  List<String>? warnings;
  List<PickupPoint>? pickupPoints;
  bool? allowPickupInStore;
  bool? pickupInStore;
  bool? pickupInStoreOnly;
  bool? displayPickupPointsOnMap;
  String? googleMapsApiKey;
  CustomProperties? customProperties;

  factory PickupPointsModel.fromJson(Map<String, dynamic> json) =>
      PickupPointsModel(
        warnings: json["Warnings"] == null
            ? null
            : List<String>.from(json["Warnings"]!.map((x) => x)),
        pickupPoints: json["PickupPoints"] == null
            ? null
            : List<PickupPoint>.from(
                json["PickupPoints"]!.map((x) => PickupPoint.fromJson(x))),
        allowPickupInStore: json["AllowPickupInStore"],
        pickupInStore: json["PickupInStore"],
        pickupInStoreOnly: json["PickupInStoreOnly"],
        displayPickupPointsOnMap: json["DisplayPickupPointsOnMap"],
        googleMapsApiKey: json["GoogleMapsApiKey"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "PickupPoints": pickupPoints == null
            ? null
            : List<dynamic>.from(pickupPoints!.map((x) => x.toJson())),
        "AllowPickupInStore": allowPickupInStore,
        "PickupInStore": pickupInStore,
        "PickupInStoreOnly": pickupInStoreOnly,
        "DisplayPickupPointsOnMap": displayPickupPointsOnMap,
        "GoogleMapsApiKey": googleMapsApiKey,
        "CustomProperties": customProperties?.toJson(),
      };
}

class PickupPoint {
  PickupPoint({
    this.id,
    this.name,
    this.description,
    this.providerSystemName,
    this.address,
    this.city,
    this.county,
    this.stateName,
    this.countryName,
    this.zipPostalCode,
    this.latitude,
    this.longitude,
    this.pickupFee,
    this.openingHours,
    this.customProperties,
  });

  String? id;
  String? name;
  String? description;
  String? providerSystemName;
  String? address;
  String? city;
  String? county;
  String? stateName;
  String? countryName;
  String? zipPostalCode;
  num? latitude;
  num? longitude;
  String? pickupFee;
  String? openingHours;
  CustomProperties? customProperties;

  factory PickupPoint.fromJson(Map<String, dynamic> json) => PickupPoint(
        id: json["Id"],
        name: json["Name"],
        description: json["Description"],
        providerSystemName: json["ProviderSystemName"],
        address: json["Address"],
        city: json["City"],
        county: json["County"],
        stateName: json["StateName"],
        countryName: json["CountryName"],
        zipPostalCode: json["ZipPostalCode"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        pickupFee: json["PickupFee"],
        openingHours: json["OpeningHours"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "ProviderSystemName": providerSystemName,
        "Address": address,
        "City": city,
        "County": county,
        "StateName": stateName,
        "CountryName": countryName,
        "ZipPostalCode": zipPostalCode,
        "Latitude": latitude,
        "Longitude": longitude,
        "PickupFee": pickupFee,
        "OpeningHours": openingHours,
        "CustomProperties": customProperties?.toJson(),
      };
}

class ShippingMethodModel {
  ShippingMethodModel({
    this.shippingMethods,
    this.notifyCustomerAboutShippingFromMultipleLocations,
    this.warnings,
    this.displayPickupInStore,
    this.pickupPointsModel,
    this.customProperties,
  });

  List<ShippingMethod>? shippingMethods;
  bool? notifyCustomerAboutShippingFromMultipleLocations;
  List<String>? warnings;
  bool? displayPickupInStore;
  PickupPointsModel? pickupPointsModel;
  CustomProperties? customProperties;

  factory ShippingMethodModel.fromJson(Map<String, dynamic> json) =>
      ShippingMethodModel(
        shippingMethods: json["ShippingMethods"] == null
            ? null
            : List<ShippingMethod>.from(json["ShippingMethods"]!
                .map((x) => ShippingMethod.fromJson(x))),
        notifyCustomerAboutShippingFromMultipleLocations:
            json["NotifyCustomerAboutShippingFromMultipleLocations"],
        warnings: json["Warnings"] == null
            ? null
            : List<String>.from(json["Warnings"]!.map((x) => x)),
        displayPickupInStore: json["DisplayPickupInStore"],
        pickupPointsModel: json["PickupPointsModel"] == null
            ? null
            : PickupPointsModel.fromJson(json["PickupPointsModel"]),
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ShippingMethods": shippingMethods == null
            ? null
            : List<dynamic>.from(shippingMethods!.map((x) => x.toJson())),
        "NotifyCustomerAboutShippingFromMultipleLocations":
            notifyCustomerAboutShippingFromMultipleLocations,
        "Warnings": warnings == null
            ? null
            : List<dynamic>.from(warnings!.map((x) => x)),
        "DisplayPickupInStore": displayPickupInStore,
        "PickupPointsModel": pickupPointsModel?.toJson(),
        "CustomProperties": customProperties?.toJson(),
      };
}

class ShippingMethod {
  ShippingMethod({
    this.shippingRateComputationMethodSystemName,
    this.name,
    this.description,
    this.fee,
    this.selected,
    this.shippingOption,
    this.customProperties,
  });

  String? shippingRateComputationMethodSystemName;
  String? name;
  String? description;
  String? fee;
  bool? selected;
  String? shippingOption;
  CustomProperties? customProperties;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
        shippingRateComputationMethodSystemName:
            json["ShippingRateComputationMethodSystemName"],
        name: json["Name"],
        description: json["Description"],
        fee: json["Fee"],
        selected: json["Selected"],
        shippingOption: json["ShippingOption"],
        customProperties: json["CustomProperties"] == null
            ? null
            : CustomProperties.fromJson(json["CustomProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "ShippingRateComputationMethodSystemName":
            shippingRateComputationMethodSystemName,
        "Name": name,
        "Description": description,
        "Fee": fee,
        "Selected": selected,
        "ShippingOption": shippingOption,
        "CustomProperties": customProperties?.toJson(),
      };
}
